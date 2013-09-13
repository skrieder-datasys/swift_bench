PPN=32
NODES=$1
bound=$(($NODES * 2000))
n=$(($PPN * $NODES))

echo "PPN:" $PPN
echo "NODES:" $NODES
echo "bound:" $bound
echo "nprocs:" $n

TURBINE_ENGINES=$NODES ADLB_SERVERS=$NODES QUEUE=normal BLUE_WATERS=true PPN=$PPN turbine-aprun-run.zsh -n $n 589-big-loop.tcl -bound=$bound -sleeptime=1
TURBINE_ENGINES=$NODES ADLB_SERVERS=$NODES QUEUE=normal BLUE_WATERS=true PPN=$PPN turbine-aprun-run.zsh -n $n 589-big-loop.tcl -bound=$bound -sleeptime=0.1
TURBINE_ENGINES=$NODES ADLB_SERVERS=$NODES QUEUE=normal BLUE_WATERS=true PPN=$PPN turbine-aprun-run.zsh -n $n 589-big-loop.tcl -bound=$bound -sleeptime=0.01
TURBINE_ENGINES=$NODES ADLB_SERVERS=$NODES QUEUE=normal BLUE_WATERS=true PPN=$PPN turbine-aprun-run.zsh -n $n 589-big-loop.tcl -bound=$bound -sleeptime=0.001
TURBINE_ENGINES=$NODES ADLB_SERVERS=$NODES QUEUE=normal BLUE_WATERS=true PPN=$PPN turbine-aprun-run.zsh -n $n 589-big-loop.tcl -bound=$bound -sleeptime=0
