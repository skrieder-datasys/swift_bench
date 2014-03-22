
# Example of command used to submit 589 CPU test jobs on Blue Waters
set -x
date_str=$(date "+%Y-%m-%d-%H.%M")

out_root="$HOME/turbine-output/589-cpu-bench/runset-${date_str}"

# Record submit script
mkdir -p $out_root
cp $0 $out_root

TURBINE_INSTALL=${HOME}/soft/exm-dev/turbine
TURBINE_APRUN=${TURBINE_INSTALL}/scripts/submit/cray/turbine-aprun-run.zsh 

# Function that accepts <space separated attempt numbers>
#                       <space-separated node counts> 
#                       <space-separated sleep times>
submit_batch() {
  local attempts=$1
  local node_counts=$2
  local sleep_times=$3
  for attempt in ${attempts}
  do
    for NODES in ${node_counts}
    do
      for sleeptime in ${sleep_times}
      do
        if [ "$sleeptime" = 0 ]
        then
          taskmultiplier=10000
        else
          taskmultiplier=$(bc <<< "1/${sleeptime}")
        fi

        TURBINE_OUTPUT="$out_root/${NODES}_nodes/${sleeptime}_sleep/run$attempt" \
        QUEUE=normal WALLTIME="00:15:00" BLUE_WATERS=true PPN=32 \
          ADLB_SERVERS=$NODES TURBINE_ENGINES=$NODES TURBINE_LOG=0 \
          ADLB_PRINT_TIME=1 ADLB_PERF_COUNTERS=1 \
          turbine-aprun-run.zsh -x -n $((NODES*32)) \
            589-big-loop.x -bound=$((NODES*2048*${taskmultiplier})) -sleeptime=$sleeptime
      done
    done
  done
}

NUM_ATTEMPTS=3
NODE_COUNTS="1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384"
SLEEP_TIMES="0 0.0001 0.001 0.01 0.1 1"

submit_batch "$(seq $NUM_ATTEMPTS)" "$NODE_COUNTS" "$SLEEP_TIMES"
