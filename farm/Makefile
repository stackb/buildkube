install:
	bazel run //farm/k8s:k8s.apply
	bazel run //farm/server/k8s:k8s.apply
	bazel run //farm/worker/k8s:k8s.apply

uninstall:
	bazel run //farm/k8s:k8s.delete

pods:
	kubectl -n farm get pods

svc:
	kubectl -n farm get svc -o wide

abseil_clone:
	(cd /tmp && git clone https://github.com/abseil/abseil-cpp.git)

abseil_clean:
	(cd /tmp/abseil-cpp && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel clean)

abseil:
	(cd /tmp/abseil-cpp && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel \
		--bazelrc=/home/pcj/go/src/github.com/stackb/buildkube/bazelrc \
		build //absl/... \
		--remote_instance_name=main \
		--config=remote)

