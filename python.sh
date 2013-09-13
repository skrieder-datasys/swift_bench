ADLB_SERVERS=1 TURBINE_ENGINES=1 QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 32 b1.tcl -N=250000


QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 64 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 128 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 256 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 512 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 1024 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 2048 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 4096 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 8192 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 16384 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 32768 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 65536 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 131072 b1.tcl -N=1000000
QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 262144 b1.tcl -N=1000000
