abseil_clone:
	(cd /tmp && git clone https://github.com/abseil/abseil-cpp.git)

abseil_clean:
	(cd /tmp/abseil-cpp && /home/pcj/.cache/bzl/release/0.17.2/bin/bazel clean)
