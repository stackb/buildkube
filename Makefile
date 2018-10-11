local_worker:
	bazel build //worker:image
	./bazel-bin/external/build_buildfarm/src/main/java/build/buildfarm/buildfarm-worker ./worker/worker.config.local

local_server:
	bazel build //server:image
	./bazel-bin/external/build_buildfarm/src/main/java/build/buildfarm/buildfarm-server ./server/server.config.master


remote_worker:
	bazel run //worker/k8s:deploy.apply

remote_server:
	bazel run //server/k8s:deploy.apply

