install:
	bazel run //barn/k8s:k8s.apply
	bazel run //barn/redis/k8s:k8s.apply
	bazel run //barn/server/k8s:k8s.apply
	bazel run //barn/scheduler/k8s:k8s.apply
	bazel run //barn/worker/k8s:k8s.apply

install_server:
	bazel run //barn/server/k8s:k8s.apply

uninstall:
	bazel run //barn/k8s:k8s.delete

pods:
	kubectl -n barn get pods

svc:
	kubectl -n barn get svc -o wide

# Port forward into the barn server.  Server is listening on 8980 but we expose
# 50051 locally so the bazelrc file is the same for farm|grid|barn|rbe
port-forward:
	kubectl -n barn port-forward --selector=app=server 50051:8980

logsr:
	kubectl -n barn logs --selector=app=redis

logsf:
	kubectl -n barn logs --selector=app=server

logss:
	kubectl -n barn logs --selector=app=scheduler

logsw:
	kubectl -n barn logs --selector=app=scheduler

abseil_clone:
	(cd /tmp && git clone https://github.com/abseil/abseil-cpp.git)

abseil:
	(cd /tmp/abseil-cpp && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel \
		--bazelrc=/home/pcj/go/src/github.com/stackb/buildkube/bazelrc \
		build //absl/... \
		--remote_instance_name=main \
		--config=remote)
