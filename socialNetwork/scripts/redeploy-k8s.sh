#!/bin/bash

cd "$(dirname "$0")"

set -x

./stop-k8s.sh
./deploy-k8s.sh

