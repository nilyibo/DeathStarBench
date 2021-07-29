#!/bin/bash

cd "$(dirname "$0")"

# Re-create kubernetes file using kompose and run
rm -f *.yaml
kompose convert -f ../docker-compose.yml --volumes hostPath
kubectl apply -f .

# Watch status
echo >&2 'Start to watch `kubectl get pods` in 5s ...'
sleep 5
watch kubectl get pods
