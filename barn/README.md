# buildgrid

Assuming you have a kubernetes cluster running, update the `WORKSPACE`
`k8s_defaults` rule with the name of your cluster (`kubectl config
current-context`).

> NOTE: the repository rule that builds the buildgrid images is not hermetic and
> requires docker on your system.

Deploy the server:

```python
$ bazel run //grid/server/k8s:k8s.apply
```

Deploy the worker(s).  Edit the replicas in the `deploy.yaml` to adjust to your
cluster size:

```python
$ bazel run //grid/worker/k8s:k8s.apply
```

Establish port forwarding:

```python
kubectl port-forward buildgrid-server-75777f7df7-5bhct 50051
```

Run a remote build:

> NOTE: paths are specific to my system!  Please edit the Makefile before running for your system.

```python
make buildgrid_abseil_test
```
