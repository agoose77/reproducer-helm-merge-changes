#!/usr/bin/env bash
set -eu

function helm-ver() {
  version="${1:?need version}"
  shift
  podman run --rm -it -v $PWD:/app -w /app "docker.io/alpine/helm:${version}" "${@}"
}

latest=${1:-latest}
working="3.17.0"

for case in test-*; do
  (
    cd "${case}"
    echo "Running ${case}"

    # Build foo.yaml,bar.yaml string
    values="$(ls next-values*.yaml | sort | paste -sd ',')"

    # Test both versions
    helm-ver "${working}" template . --values="${values}" > "helm-${working}.yaml"
    helm-ver "${latest}" template . --values="${values}" > "helm-${latest}.yaml"

    # Complain if outputs differ
    diff "helm-${working}.yaml" "helm-${latest}.yaml" || echo "${case} failed" >&2
  )
done
