all: big-loop

big-loop:
	stc 589-big-loop.swift

test:
	QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 32 589-big-loop.tcl -bound=1 -sleepTime=1

clean:
	rm 589-big-loop.tcl
