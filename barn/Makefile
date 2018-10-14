install:
	bazel build \
		//barn/k8s:k8s.apply \
		//barn/redis/k8s:k8s.apply \
		//barn/server/k8s:k8s.apply \
		//barn/scheduler/k8s:k8s.apply \
		//barn/worker/k8s:k8s.apply

	bazel run //barn/k8s:k8s.apply
	bazel run //barn/redis/k8s:k8s.apply
	bazel run //barn/server/k8s:k8s.apply
	bazel run //barn/scheduler/k8s:k8s.apply
	bazel run //barn/worker/k8s:k8s.apply

uninstall:
	bazel run //barn/k8s:k8s.delete

port-forward:
	kubectl -n barn port-forward \
		`kubectl -n barn get pods --selector=app=server -o jsonpath='{.items[0].metadata.name}'` \
		8980

abseil:
	(cd /tmp/abseil-cpp && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel \
		--bazelrc=/home/pcj/go/src/github.com/stackb/buildkube/bazelrc \
		build //absl/... \
		--remote_instance_name=rbe_ubuntu1604 \
		--config=remote)
