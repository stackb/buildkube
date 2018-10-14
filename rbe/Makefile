
setup:
	curl -X GET -o /tmp/key.json "https://www.googleapis.com/storage/v1/b/bazel_key/o/key.json?alt=media"

abseil:
	(cd /tmp/abseil-cpp && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel \
		--bazelrc=/home/pcj/go/src/github.com/stackb/buildkube/bazelrc \
		build //absl/... \
		--config=remote --jobs=300 \
		--remote_instance_name=projects/bazelcon18-rbe-shared/instances/default_instance \
		--auth_credentials=/tmp/key.json)
