#!/bin/bash
ns=${1:-"dev"}
echo "clear $ns"
OUTPUT="$(helm ls --namespace "$ns" | awk 'NR!=1 {print $1}')"
for i in $OUTPUT; do
  echo "remove $i"
  helm del --purge "$i"
done
