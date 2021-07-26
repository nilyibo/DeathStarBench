#!/bin/bash

# Re-create kubernetes file using kompose and run
rm -f *.yaml
kompose convert -f ../docker-compose.yml --volumes hostPath
kubectl apply -f .

# Watch status
kubectl get pods
