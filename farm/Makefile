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