# Demo of Helm merging behaviour

Helm `null` handling has regressed between 3.17.0 and 4.x. Each test can be run by Helm 3.17.0, and Helm latest. Compare the outputs!

## Running the tests

You can run `./run-tests.sh`, or manually invoke each one. There's a helper to run a specific version of Helm via the Docker image:

```bash
function helm-ver() {
  version="${1:?need version}"
  shift
  podman run --rm -it -v $PWD:/app -w /app "docker.io/alpine/helm:${version}" "${@}"
}
```

## Tests

### Test 1

> [!Note]
> This test has **a single chart**
> A key is introduced in `values.yaml`
> The key is nulled in `next-values.yaml`
> The result should be that the key is removed.

**Manual invocation**
```bash
(
  cd test-1
  helm-ver 3.17.0 template . --values=./next-values.yaml
  helm-ver latest template . --values=./next-values.yaml
)
```

### Test 2

> [!Note]
> This test has **a single chart**
> A key is introduced in `values.yaml`
> The key is overridden in `next-values-1.yaml`
> The key is nulled in `next-values-2.yaml`
> The result should be that the key is `null`.

**Manual invocation**
```bash
(
  cd test-2
  helm-ver 3.17.0 template . --values=./next-values-1.yaml --values=./next-values-2.yaml
  helm-ver latest template . --values=./next-values-1.yaml --values=./next-values-2.yaml
)
```

### Test 3

> [!Note]
> This test has **a nested chart**
> A map is introduced in the child `charts/child/values.yaml`
> A key is added in the parent `values.yaml`
> The key is nulled in the parent `next-values.yaml`
> The result should be that the key is removed.

> [!Warning]
> This test has regressed.

**Manual invocation**
```bash
(
  cd test-3
  helm-ver 3.17.0 template . --values=./next-values.yaml
  helm-ver latest template . --values=./next-values.yaml
)
```

### Test 4

> [!Note]
> This test has **a nested chart**
> A key is introduced in the child `charts/child/values.yaml`
> The key is modified in the parent `values.yaml`
> The key is nulled in the parent `next-values.yaml`
> The result should be that the key is removed.

> [!Warning]
> This test has regressed.

**Manual invocation**
```bash
(
  cd test-4
  helm-ver 3.17.0 template . --values=./next-values.yaml
  helm-ver latest template . --values=./next-values.yaml
)
```

### Test 5

> [!Note]
> This test has **a nested chart**
> A map is introduced in the child `charts/child/values.yaml`
> A key is added in the parent `values.yaml`
> The key is modified in the parent `next-values-1.yaml`
> The key is nulled in the parent `next-values-2.yaml`
> The result should be that the key is removed.

**Manual invocation**
```bash
(
  cd test-5
  helm-ver 3.17.0 template . --values=./next-values-1.yaml --values=./next-values-2.yaml
  helm-ver latest template . --values=./next-values-1.yaml --values=./next-values-2.yaml
)
```
