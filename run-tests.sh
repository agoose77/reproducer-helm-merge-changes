#!/usr/bin/env bash
set -eu

latest=${1:-latest}

failed=0

for case in test-*; do
  echo "Running ${case}"
  if ! env -C "${case}" ./test.sh "${latest}"; then
    echo "${case} failed" >&2;
    failed=1;
  fi
done

exit "${failed}"
