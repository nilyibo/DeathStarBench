#!/bin/bash

cd "$(dirname "$0")"

MANIFESTS="."
if [ $# -gt 0 ]; then
    MANIFESTS="$@"
fi
# echo $MANIFESTS

# Re-create kubernetes file using kompose and run
rm -f *.yaml
kompose convert -f ../docker-compose.yml --volumes hostPath
(set -x; kubectl apply $(echo "$MANIFESTS" | sed 's/[^ ]* */-f &/g'))

# Watch status
echo >&2 'Start to watch `kubectl get pods` in 5s ...'
sleep 5
watch kubectl get pods
