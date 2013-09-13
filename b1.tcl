
# Generated by stc version 0.2.0
# date                    : 2013/09/11 20:38:01
# Turbine version         : 0.3.0
# Input filename          : /mnt/a/u/sciteam/krieder/swift_bench/b1.swift
# Output filename         : /mnt/a/u/sciteam/krieder/swift_bench
# STC home                : /mnt/a/u/sciteam/krieder/soft/exm-trunk-r8770/stc
# Turbine home            : /u/sciteam/krieder/soft/exm-trunk-r8770/turbine
# Compiler settings:
# stc.auto-declare              : true
# stc.c_preprocess              : true
# stc.codegen.no-stack          : true
# stc.codegen.no-stack-vars     : true
# stc.compiler-debug            : true
# stc.debugging                 : COMMENTS
# stc.exp.refcounting           : true
# stc.ic.output-file            : 
# stc.input_filename            : b1.swift
# stc.log.file                  : 
# stc.log.trace                 : false
# stc.must_pass_wait_vars       : true
# stc.opt.algebra               : false
# stc.opt.array-build           : true
# stc.opt.cancel-refcounts      : true
# stc.opt.constant-fold         : true
# stc.opt.controlflow-fusion    : true
# stc.opt.dead-code-elim        : true
# stc.opt.disable-asserts       : false
# stc.opt.expand-dataflow-ops   : true
# stc.opt.expand-loop-threshold-insts: 256
# stc.opt.expand-loop-threshold-iters: 16
# stc.opt.expand-loops          : true
# stc.opt.flatten-nested        : true
# stc.opt.forward-dataflow      : true
# stc.opt.full-unroll           : false
# stc.opt.function-inline       : false
# stc.opt.function-inline-threshold: 500
# stc.opt.function-signature    : true
# stc.opt.hoist                 : true
# stc.opt.max-iterations        : 10
# stc.opt.piggyback-refcounts   : true
# stc.opt.pipeline              : false
# stc.opt.reorder-insts         : false
# stc.opt.shared-constants      : true
# stc.opt.unroll-loop-threshold-insts: 192
# stc.opt.unroll-loop-threshold-iters: 8
# stc.opt.unroll-loops          : true
# stc.opt.wait-coalesce         : true
# stc.output_filename           : 
# stc.preproc.force-cpp         : false
# stc.preproc.force-gcc         : false
# stc.preprocess_only           : false
# stc.profile                   : false
# stc.rpath                     : 
# stc.stc_home                  : /mnt/a/u/sciteam/krieder/soft/exm-trunk-r8770/stc
# stc.turbine.version           : 0.3.0
# stc.turbine_home              : /u/sciteam/krieder/soft/exm-trunk-r8770/turbine
# stc.version                   : 0.2.0

# Metadata:

package require turbine 0.3.0
namespace import turbine::*


proc swift:constants {  } {
    turbine::c::log "function:swift:constants"
}


proc swift:main {  } {
    turbine::c::log "enter function: main"
    set stack 0
    # Value __ov___t0 with type $void was defined
    # Swift l.6: assigning expression to N
    # Swift l.8 evaluating  expression and throwing away 1 results
    set optv:__t0 [ turbine::printf_local "N: %i\n" 320000 ]
    # Swift l.10 evaluating  expression and throwing away 1 results
    main-range0:outer ${stack} 0 319999 1
}


proc main-range0:outer { stack tcltmp:lo tcltmp:hi tcltmp:inc } {
    set tcltmp:itersleft [ expr { max(0,(${tcltmp:hi} - ${tcltmp:lo}) / ${tcltmp:inc} + 1) } ]
    if { [ expr { ${tcltmp:itersleft} <= 0 } ] } {
        return
    }
    if { [ expr { ${tcltmp:itersleft} <= 64 } ] } {
        main-range0:inner ${stack} ${tcltmp:lo} ${tcltmp:hi} ${tcltmp:inc}
    } else {
        set tcltmp:skip [ expr { ${tcltmp:inc} * max(64,((${tcltmp:itersleft} - 1) / 16) + 1) } ]
        for { set tcltmp:splitstart ${tcltmp:lo} } { ${tcltmp:splitstart} <= ${tcltmp:hi} } { incr tcltmp:splitstart ${tcltmp:skip} } {
            set tcltmp:splitend [ expr { min(${tcltmp:hi},${tcltmp:splitstart} + ${tcltmp:skip} - 1) } ]
            set tcltmp:prio [ turbine::get_priority ]
            turbine::set_priority ${tcltmp:prio}
            adlb::spawn 1 "command main-range0:outer ${stack} ${tcltmp:splitstart} ${tcltmp:splitend} ${tcltmp:inc}"
            turbine::reset_priority
        }
    }
}


proc main-range0:inner { stack tcltmp:lo tcltmp:hi tcltmp:inc } {
    for { set v:i ${tcltmp:lo} } { ${v:i} <= ${tcltmp:hi} } { incr v:i ${tcltmp:inc} } {
        set tcltmp:prio [ turbine::get_priority ]
        turbine::set_priority ${tcltmp:prio}
        adlb::spawn 0 "-1 main-call_sync-python ${stack}"
        turbine::reset_priority
    }
}


proc main-call_sync-python { stack } {
    # Value __ov___t6 with type $string was defined
    set optv:__t6 [ python::eval "'{0}'.format(2+2)" ]
}


proc f:python { stack u:output u:code dr:location } {
    turbine::c::log "enter function: python"
    turbine::read_refcount_incr ${u:code} 1
    turbine::rule [ list ${u:code} ] "python-argwait ${stack} ${u:code} ${u:output}" target ${dr:location} type ${::turbine::WORK}
}


proc python-argwait { stack u:code u:output } {
    # Value __v_code with type $string was defined
    # Value __v_output with type $string was defined
    set v:code [ turbine::retrieve_string ${u:code} CACHED 1 ]
    set v:output [ python::eval ${v:code} ]
    turbine::store_string ${u:output} ${v:output}
}

turbine::defaults
turbine::init $engines $servers
turbine::enable_read_refcount
turbine::check_constants "WORKER" ${turbine::WORK_TASK} 0 "CONTROL" ${turbine::CONTROL_TASK} 1 "ADLB_RANK_ANY" ${adlb::RANK_ANY} -100
turbine::start swift:main swift:constants
turbine::finalize

