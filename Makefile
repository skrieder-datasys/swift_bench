all: big b1

big:
	stc 589-big-loop.swift

b1:
	stc b1.swift

test-b1:
	QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 32 b1.tcl -N=1

test-big:
	QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 32 589-big-loop.tcl -bound=1 -sleeptime=1

clean:
	rm 589-big-loop.tcl
