abseil_clone:
	(cd /tmp && git clone https://github.com/abseil/abseil-cpp.git)

abseil_clean:
	(cd /tmp/abseil-cpp && bazel clean)

abseil:
	(cd /tmp/abseil-cpp && bazel --bazelrc=./bazelrc \
		build //absl/... \
		--remote_instance_name=main \
		--config=remote)
