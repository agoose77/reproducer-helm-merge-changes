# Test 4

> [!Note]
> This test has **a nested chart**
> A key is introduced in the child `charts/child/values.yaml`
> The key is modified in the parent `values.yaml`
> The key is nulled in the parent `next-values.yaml`
> The result should be that the key is removed.

> [!Warning]
> This test has regressed.
