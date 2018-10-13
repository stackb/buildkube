local_worker:
	bazel build //farm/worker:image
	./bazel-bin/external/build_buildfarm/src/main/java/build/buildfarm/buildfarm-worker ./worker/worker.config.local

local_server:
	bazel build //farm/server:image
	./bazel-bin/external/build_buildfarm/src/main/java/build/buildfarm/buildfarm-server ./server/server.config.master

remote_worker:
	bazel run //farm/worker/k8s:deploy.apply

remote_server:
	bazel run //farm/server/k8s:deploy.apply


rbe_setup:
	curl -X GET -o /tmp/key.json "https://www.googleapis.com/storage/v1/b/bazel_key/o/key.json?alt=media"
	mkdir -p /tmp/rbe-system-check && cd /tmp/rbe-system-check/
	(cd /tmp && git clone https://github.com/bazelbuild/bazel-toolchains.git)
	(cd /tmp && git clone https://github.com/abseil/abseil-cpp.git)

rbe_system_check_test:
	(cd /tmp/bazel-toolchains && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel --bazelrc=bazelrc/latest.bazelrc \
		test //examples/remotebuildexecution/rbe_system_check/cc:rbe_system_check_test \
		--config=remote --jobs=100 \
		--remote_instance_name=projects/bazelcon18-rbe-shared/instances/default_instance \
		--auth_credentials=/tmp/key.json)

rbe_abseil_test:
	(cd /tmp/abseil-cpp && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel --bazelrc=/tmp/bazel-toolchains/bazelrc/latest.bazelrc \
		build //absl/... \
		--config=remote --jobs=300 \
		--remote_instance_name=projects/bazelcon18-rbe-shared/instances/default_instance \
		--auth_credentials=/tmp/key.json)

buildgrid_abseil_test:
	(cd /tmp/abseil-cpp && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel --bazelrc=/home/pcj/go/src/github.com/stackb/buildkube/grid/server/latest.bazelrc \
		build //absl/... \
		--remote_instance_name=main \
		--config=remote --jobs=3)

buildgrid_protor:
	(cd /tmp/protor && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel --bazelrc=/home/pcj/go/src/github.com/stackb/buildkube/grid/server/latest.bazelrc \
		build //... \
		--remote_instance_name=main \
		--config=remote --jobs=3)