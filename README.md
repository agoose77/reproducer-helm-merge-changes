# Demo of Helm merging behaviour

Helm `null` handling has regressed between 3.17.0 and 4.x. Each test can be run by Helm 3.17.0, and Helm latest. Compare the outputs!

## Running the tests

You can run tests with:

```bash
export PATH="$PWD/bin:$PATH"
./run-tests.sh

```

There's a helper in `bin/helm-ver` to run a specific version of Helm via the Docker image. You can alternatively add the helper to the path, manually invoke each `test.sh` in the various test dirs.
