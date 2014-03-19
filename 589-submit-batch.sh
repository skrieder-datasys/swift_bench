
# Example of command used to submit 589 CPU test jobs on Blue Waters
set -x
date_str=$(date "+%Y-%m-%d-%H.%M")

out_root="$HOME/turbine-output/589-cpu-bench/runset-${date_str}"

NUM_ATTEMPTS=3
NODE_COUNTS="1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384"
SLEEP_TIMES="0 0.0001 0.001 0.01 0.1 1"

for attempt in $(seq ${NUM_ATTEMPTS}) 
do
  for NODES in ${NODE_COUNTS}
  do
    for sleeptime in ${SLEEP_TIMES}
    do
      if [ "$sleeptime" = 0 ]
      then
        taskmultiplier=10000
      else
        taskmultiplier=$(bc <<< "1/${sleeptime}")
      fi

      TURBINE_OUTPUT="$out_root/$NODES/$sleeptime/$attempt" \
      QUEUE=normal WALLTIME="00:15:00" BLUE_WATERS=true PPN=32 \
        ADLB_SERVERS=$NODES TURBINE_ENGINES=$NODES TURBINE_LOG=0 \
        ADLB_PRINT_TIME=1 ADLB_PERF_COUNTERS=1 \
        turbine-aprun-run.zsh -x -n $((NODES*32)) \
          589-big-loop.x -bound=$((NODES*2048*${taskmultiplier})) -sleeptime=$sleeptime
    done
  done
done
