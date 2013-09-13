NODES=8
N=1000000
PPN=32
AS=$NODES
TE=$NODES
nprocs=$(($PPN*$NODES))

for i in {1..11}
do
    echo "N:" $N
    echo "PPN:" $PPN
    echo "NODES:" $NODES
    echo "ADLB_SERVERS:" $AS
    echo "TUBINE_ENGINES:" $TE
    echo "nprocs:" $nprocs

    ADLB_SERVERS=$AS TURBINE_ENGINES=$TE QUEUE=debug BLUE_WATERS=true PPN=$PPN turbine-aprun-run.zsh -n $nprocs b1.tcl -N=$N
    
    NODES=$(($NODES*2))
    N=$(($N*2))
    PPN=32
    AS=$NODES
    TE=$NODES
    nprocs=$(($PPN*$NODES))
done

#ADLB_SERVERS=2 TURBINE_ENGINES=2 QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 64 b1.tcl -N=250000
#ADLB_SERVERS=4 TURBINE_ENGINES=4 QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 128 b1.tcl -N=250000
#ADLB_SERVERS=8 TURBINE_ENGINES=8 QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 256 b1.tcl -N=250000
#ADLB_SERVERS=16 TURBINE_ENGINES=16 QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 512 b1.tcl -N=250000
#ADLB_SERVERS=32 TURBINE_ENGINES=32 QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 1024 b1.tcl -N=250000
