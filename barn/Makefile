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
		`kubectl -n barn get pods --selector=k8s-app=server -o jsonpath='{.items[0].metadata.name}'` \
		8980

