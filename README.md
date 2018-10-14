# buildkube

<table><tr>
<td>
  <a href="https://bazel.build">
    <img src="https://github.com/bazelbuild.png" height="120"/>
  </a>
</td>
<td>
  <a href="https://github.com/bazelbuild/remote-apis">
    <img src="http://laplace.us.es/wiki/images/0/09/Conduccion-metal.gif"
         height="120"/>
  </a>
</td>
<td>
  <a href="https://kubernetes.io">
    <img src="https://github.com/kubernetes.png"
         height="120"/>
  </a>
</td>
</tr>
<td>Bazel</td>
<td>REAPI</td>
<td>Kubernetes</td>
</table>

Buildkube uses [rules_docker] and [rules_k8s] to build and deploy
[bazel-buildfarm], [bazel-buildbarn] and/or [buildgrid] into an existing
kubernetes cluster.  These are the 3 known open-source server-side
implementations of the [remote-execution-api] (REAPI).  

Known clients of the REAPI include [bazel](https://github.com/bazelbuild/bazel)
itself, [recc](https://gitlab.com/bloomberg/recc), and possibly
[pants](https://github.com/pantsbuild/pants/pull/4910). 

## INSTRUCTIONS

1. Clone this repository
2. Edit the `WORKSPACE` file `k8s_deploy` rule to point to your kubernetes cluster (should match `kubectl config current-context`).
3. Build and deploy an implementation, for example: `$ (cd farm/ && make install)`
4. Clone the abseil repository as a test case: `$ make abseil_clone`
5. Setup port-forwarding on your cluster `$ (cd farm/ && make port-forward &)`
5. Compile abseil remotely: `$ (cd farm/ && make abseil)`.

### NOTES

* BuildFarm worker does not detect if server goes down.  Must manually `kubectl
  delete pod --selector=k8s-app=worker` when re-installing or updating server
  deployment.

* When a worker registers itself with the server (operation-queue), it provides
  a dict of key:value pairs that must match the action execution requirements.
  In particular, the `worker.config` `container-image` key MUST be exactly
  matching the rbe_ubuntu image tag. 

[rules-docker]: https://github.com/bazelbuild/rules_docker 
[rules-k8s]: https://github.com/bazelbuild/rules_k8s
[bazel-buildfarm]: https://github.com/bazelbuild/bazel-buildfarm/
[bazel-buildbarn]: https://github.com/EdShouten/bazel-buildbarn/
[buildgrid]: https://gitlab.com/BuildGrid/buildgrid
[remote-execution-api]: https://github.com/bazelbuild/remote-apis