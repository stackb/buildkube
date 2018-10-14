abseil_clone:
	(cd /tmp && git clone https://github.com/abseil/abseil-cpp.git)

abseil_clean:
	(cd /tmp/abseil-cpp && bazel clean)

abseil:
	cp ./bazelrc /tmp
	(cd /tmp/abseil-cpp && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel \
		--bazelrc=/tmp/bazelrc \
		build //absl/... \
		--remote_instance_name=main \
		--config=remote)
