# Demo of Helm merging behaviour

## 0. Define helpers
```bash
alias helm-317='podman run --rm -it -v $PWD:/app -w /app "alpine/helm:3.17.0"'
alias helm-411='podman run --rm -it -v $PWD:/app -w /app "alpine/helm:4.1.1"'
```
## 1. Overriding chart values (in parent chart)

- The `child` chart defines a config section (empty mapping) in `values.yaml`. 
- The `parent` chart defines a config value in `values.yaml`
- The custom `next-values.yaml` overrides the parent config key with null
```bash
(
  cd nested-chart-values-override
  helm-317 template . --values=./next-values.yaml 
  helm-411 template . --values=./next-values.yaml 
)
```
## 2. Overriding sibling values (in parent chart)

- The `child` chart defines a config section (empty mapping) in `values.yaml`. 
- The `parent` chart defines an arbitrary key in `values.yaml`
- The custom `next-values-1.yaml` and `next-values-2.yaml` define a different key with a non-null, and null value, respectively.
```bash
(
  cd nested-chart-siblings-override
  helm-317 template . --values=./next-values-1.yaml --values=./next-values-2.yaml 
  helm-411 template . --values=./next-values-1.yaml --values=./next-values-2.yaml 
)
```
## 3. Overriding chart values (in single chart)

- The chart defines a config section with a default value in `values.yaml`. 
- The custom `next-values.yaml` overrides the chart config key with null
```bash
(
  cd single-chart-values-override
  helm-317 template . --values=./next-values.yaml 
  helm-411 template . --values=./next-values.yaml
)

