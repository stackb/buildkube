install:
	bazel build \
		//farm/k8s:k8s.apply \
		//farm/server/k8s:k8s.apply \
		//farm/worker/k8s:k8s.apply
	bazel run //farm/k8s:k8s.apply
	bazel run //farm/server/k8s:k8s.apply
	bazel run //farm/worker/k8s:k8s.apply

uninstall:
	bazel run //farm/k8s:k8s.delete

port-forward:
	kubectl -n farm port-forward \
		`kubectl -n farm get pods --selector=k8s-app=server -o jsonpath='{.items[0].metadata.name}'` \
		8980

abseil:
	(cd /tmp/abseil-cpp && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel \
		--bazelrc=/home/pcj/go/src/github.com/stackb/buildkube/bazelrc \
		build //absl/... \
		--remote_instance_name=main \
		--config=remote)