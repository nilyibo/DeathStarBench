#!/bin/bash
# This script is needed because root cannot access NFS-mounted HOME folder for mounting host paths.

DST_DIR=/data/k8s/deathstarbench/socialnetwork

set -e
set -x

kubectl delete -f $DST_DIR/kubernetes/

