#!/bin/bash
# Step: Divergence time estimation

# 1. Prepare MCMCtree Input
# Requires the phylogenetic tree from Step 01 and a concatenated alignment
# Ensure you have your fossil calibration points in your tree file

mcmctree mcmctree.ctl

# 2. Assess Convergence in Tracer
# Note: Tracer is a GUI tool. This script prepares the log files.
echo "Analysis complete. Load 'mcmc.txt' into Tracer to check ESS values.
