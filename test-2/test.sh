#!/usr/bin/env bash
set -eu

latest=${1:-latest}
working="3.17.0"

# Test both versions
helm-ver "${working}" template . --values="next-values-1.yaml,next-values-2.yaml" > "helm-${working}.yaml"
helm-ver "${latest}" template . --values="next-values-1.yaml,next-values-2.yaml" > "helm-${latest}.yaml"

# Complain if outputs differ
diff "helm-${working}.yaml" "helm-${latest}.yaml"

