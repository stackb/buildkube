workspace(name = "com_github_stackb_buildkube")


#####################################################################
# distroless_bazel
#####################################################################

http_archive(
    name = "com_github_stackb_distroless_bazel",
    url = "https://github.com/stackb/distroless-bazel/archive/70f85a64af5ac4c7b170f16cd30e32c01638bc4f.zip",
    sha256 = "c7ea5287a70af5744158c880384a31cf321a9b2c70aa674131faf94ed583096e",
    strip_prefix = "distroless-bazel-70f85a64af5ac4c7b170f16cd30e32c01638bc4f",
)

load("@com_github_stackb_distroless_bazel//:deps.bzl", "distroless_bazel_repositories", "bazel_dependencies")
distroless_bazel_repositories()
bazel_dependencies()


load("@io_bazel_rules_go//go:def.bzl", "go_rules_dependencies", "go_register_toolchains")

go_rules_dependencies()
go_register_toolchains()

load("@com_github_stackb_distroless_bazel//:debian.bzl", "debian_dependencies")
debian_dependencies()

load("@com_github_stackb_distroless_bazel//:container.bzl", "container_dependencies")
container_dependencies()

#############################################################
# KUBERNETES
#############################################################

RULES_K8S_VERSION = "8537afcc8728e5ebfafa9b68462e54a98935d06b"

http_archive(
    name = "io_bazel_rules_k8s",
    url = "https://github.com/bazelbuild/rules_k8s/archive/%s.zip" % RULES_K8S_VERSION,
    strip_prefix = "rules_k8s-" + RULES_K8S_VERSION,
    sha256 = "2a8727f40c9988eb7d411908685454aae6f9dcda4ff3b210de8ff2e9798e919a",
)

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")

k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_defaults")

k8s_defaults(
    # This becomes the name of the @repository and the rule
    # you will import in your BUILD files.
    name = "k8s_deploy",
    kind = "deployment",
    # This is the name of the cluster as it appears in:
    #   kubectl config current-context
    cluster = "gke_stackb-151821_us-central1-a_cluster-1",
)


#####################################################################
# BUILDFARM
#####################################################################

BUILDFARM_VERSION = "8f5ccc689f7d8ad2d20343c94d3475b92412e587"

local_repository(
    name = "build_buildfarm",
    path = "/home/pcj/go/src/github.com/pcj/bazel-buildfarm",
)

# http_archive(
#     name = "build_buildfarm",
#     url = "https://github.com/pcj/bazel-buildfarm/archive/%s.zip" % BUILDFARM_VERSION,
#     strip_prefix = "bazel-buildfarm-%s" % BUILDFARM_VERSION,
# )

# Needed for @grpc_java//compiler:grpc_java_plugin.
http_archive(
    name = "grpc_java",
    sha256 = "20a35772b20d8194854f6d149324f971472b7acc1a76a0969a048c4c02a1da0d",
    strip_prefix = "grpc-java-1.8.0",
    urls = ["https://github.com/grpc/grpc-java/archive/v1.8.0.zip"],
)

new_http_archive(
    name = "googleapis",
    sha256 = "27ade61091175f5bad45ec207f4dde524d3c8148903b60fa5641e29e3b9c5fa9",
    url = "https://github.com/googleapis/googleapis/archive/9ea26fdb1869d674fa21c92e5818ba4eadd500c2.zip",
    strip_prefix = "googleapis-9ea26fdb1869d674fa21c92e5818ba4eadd500c2",
    build_file = "BUILD.googleapis",
)

load("@build_buildfarm//3rdparty:workspace.bzl", "maven_dependencies", "declare_maven")

maven_dependencies(declare_maven)
