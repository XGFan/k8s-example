#!/bin/bash
ns=${1:-"dev"}
echo "deploy to $ns"

helm install single --name "$ns-redis" --namespace "$ns" --values profile/values.redis.yaml
helm install single --name "$ns-rng" --namespace "$ns" --values profile/values.rng.yaml
helm install single --name "$ns-hasher" --namespace "$ns" --values profile/values.hasher.yaml
helm install single --name "$ns-worker" --namespace "$ns" --values profile/values.worker.yaml
helm install single --name "$ns-webui" --namespace "$ns" --values profile/values.webui.yaml
