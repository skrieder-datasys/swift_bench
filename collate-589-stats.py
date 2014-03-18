#!/usr/bin/env python

import sys
import os.path
import glob


output_columns = ["directory",
        "PROCS", "NODES", "TURBINE_ENGINES", "ADLB_SERVERS",
        "TURBINE_WORKERS", "bound", "sleeptime", "adlb_elapsed_time" ] 

def process_dir(dir):
  out1 = os.path.join(dir, "output.txt")
  if not os.path.isfile(out1):
    print >> sys.stderr, "Could not find %s" % out1
    return

  out2_pattern = os.path.join(dir, "output.txt.*.nid*.out")
  out2_matches = glob.glob(out2_pattern)

  if len(out2_matches) == 1:
    out2 = out2_matches[0]
  elif len(out2_matches) == 0:
    print >> sys.stderr, "Could not find %s" % out2_pattern
    return
  else: 
    print >> sys.stderr, "Multiple matches for %s" % out2_pattern
    return
  
  vals = {"directory": dir}

  scrape_file(vals, out1, [
        ("PROCS:", "PROCS"),
        ("NODES:", "NODES"),
        ("TURBINE_ENGINES:", "TURBINE_ENGINES"),
        ("ADLB_SERVERS:", "ADLB_SERVERS"),
        ("TURBINE_WORKERS:", "TURBINE_WORKERS")])

  scrape_file(vals, out2, [
        ("The bound is:", "bound"),
        ("The sleeptime is:", "sleeptime"),
        ("ADLB Total Elapsed Time:", "adlb_elapsed_time")])

  cols = []
  for colname in output_columns:
    val = vals.get(colname, None)
    if val is None:
      print >> sys.stderr, "No data for output column %s in %s" % \
                                                    (colname, dir)
      cols.append("NULL")
    else:
      cols.append(val)

  print ','.join(cols)

def scrape_file(val_dict, file, keys):
  with open(file) as f:
    for line in f.readlines():
      for prefix, name in keys:
        if line.startswith(prefix):
          val = line[len(prefix):].strip()
          val_dict[name] = val

dirs = []
for dir in sys.argv[1:]:
  if os.path.isdir(dir):
    print >> sys.stderr, "Input directory %s" % dir
    dirs.append(dir)
  else:
    print >> sys.stderr, "Ignoring input, not a directory: %s" % dir

print ','.join(output_columns)

for dir in dirs:
  process_dir(dir)

