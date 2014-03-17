all: big b1

TCL_STATIC_HOME = /u/sciteam/tarmstro/soft/exm-dev/tcl
TCL_STATIC_LIB = $(TCL_STATIC_HOME)/lib
TCL_INCLUDE = $(TCL_STATIC_HOME)/include
TCL_VERSION = 8.6

EXM_INSTALL = /u/sciteam/tarmstro/soft/exm-dev
C_UTILS_INSTALL = $(EXM_INSTALL)/c-utils
LB_INSTALL = $(EXM_INSTALL)/lb
TURBINE_INSTALL = $(EXM_INSTALL)/turbine

SWIFT_589 = 589-big-loop.swift
TCL_589 = 589-big-loop.tcl
MAIN_C_589 = 589-big-loop.c
MANIFEST_589 = 589-big-loop.manifest
EXEC_589 = 589-big-loop.x

CC = cc

CFLAGS = -std=c99
LDFLAGS = -dynamic

TCL_LIB_FLAGS = -lz -lm -ldl

EXM_INCLUDE = -I $(C_UTILS_INSTALL)/include -I $(LB_INSTALL)/include \
      -I $(TURBINE_INSTALL)/include -I $(TCL_INCLUDE)

EXM_LIB = -L $(TURBINE_INSTALL)/lib -ltclturbinestatic -ltclturbine -ltclturbinestaticres \
     -L $(LB_INSTALL)/lib -l adlb \
     -L $(C_UTILS_INSTALL)/lib -lexmcutils \
     -L $(TCL_STATIC_LIB) -ltcl$(TCL_VERSION) $(TCL_LIB_FLAGS)
          

big: $(TCL_589)

$(TCL_589): $(SWIFT_589)
	stc -O3 $(SWIFT_589) $(TCL_589)

# Rule to build static main function
$(MAIN_C_589): $(TCL_589) $(MANIFEST_589)
	mkstatic.tcl $(MANIFEST_589) -c $(MAIN_C_589) --include-sys-lib $(TCL_STATIC_LIB) --tcl-version 8.6

$(EXEC_589): $(MAIN_C_589)
	$(CC) $(LDFLAGS) $(CFLAGS) $(MAIN_C_589) $(EXM_INCLUDE) $(EXM_LIB) -o $(EXEC_589)

b1:
	stc b1.swift

test-b1:
	QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 32 b1.tcl -N=1

test-big:
	QUEUE=normal BLUE_WATERS=true PPN=32 turbine-aprun-run.zsh -n 32 589-big-loop.tcl -bound=1 -sleeptime=1

clean:
	rm -f $(TCL_589) $(MAIN_C_589) $(EXEC_589)
