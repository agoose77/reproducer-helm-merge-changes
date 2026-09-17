#!/usr/bin/env bash
set -eu

latest=${1:-latest}
working="3.17.0"

# Test both versions
helm-ver "${working}" template . --values=next-values.yaml > "helm-${working}.yaml"
helm-ver "${latest}" template . --values=next-values.yaml > "helm-${latest}.yaml"

# Complain if outputs differ
diff "helm-${working}.yaml" "helm-${latest}.yaml"

