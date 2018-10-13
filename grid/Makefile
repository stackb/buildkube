install:
	bazel run //grid/k8s:k8s.apply
	bazel run //grid/server/k8s:k8s.apply
	bazel run //grid/worker/k8s:k8s.apply

uninstall:
	bazel run //grid/k8s:k8s.delete

pods:
	kubectl -n grid get pods

svc:
	kubectl -n grid get svc -o wide

sl:
	kubectl -n grid logs --selector=k8s-app=server

wl:
	kubectl -n grid logs --selector=k8s-app=worker

abseil_clone:
	(cd /tmp && git clone https://github.com/abseil/abseil-cpp.git)

abseil:
	(cd /tmp/abseil-cpp && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel \
		--bazelrc=/home/pcj/go/src/github.com/stackb/buildkube/bazelrc \
		build //absl/... \
		--remote_instance_name=main \
		--config=remote)
