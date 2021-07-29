#!/bin/bash
# This script is needed because root cannot access NFS-mounted HOME folder for mounting host paths.

set -e

cd "$(dirname "$0")/.."

SRC_DIR="$(pwd)"
DST_DIR=/data/k8s/deathstarbench/socialnetwork

set -x
pssh-launch "rsync -ahvzP --delete $SRC_DIR/ $DST_DIR/"
$DST_DIR/kubernetes/kompose-and-run.sh

