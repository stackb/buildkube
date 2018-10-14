install:
	bazel build \
		//grid/k8s:k8s.apply \
		//grid/server/k8s:k8s.apply \
		//grid/worker/k8s:k8s.apply

	bazel run //grid/k8s:k8s.apply
	bazel run //grid/server/k8s:k8s.apply
	bazel run //grid/worker/k8s:k8s.apply

uninstall:
	bazel run //grid/k8s:k8s.delete

port-forward:
	kubectl -n grid port-forward \
		`kubectl -n grid get pods --selector=k8s-app=server -o jsonpath='{.items[0].metadata.name}'` \
		8980
