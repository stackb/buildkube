
setup:
	curl -X GET -o /tmp/key.json "https://www.googleapis.com/storage/v1/b/bazel_key/o/key.json?alt=media"

abseil:
	cp ./bazelrc /tmp
	(cd /tmp/abseil-cpp && bazel \
		--bazelrc=/tmp/bazelrc \
		build //absl/... \
		--config=remote --jobs=300 \
		--remote_instance_name=projects/bazelcon18-rbe-shared/instances/default_instance \
		--auth_credentials=/tmp/key.json)
