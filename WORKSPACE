workspace(name = "com_github_stackb_buildkube")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

#####################################################################
# rules_docker
#####################################################################

# RULES_DOCKER_VERSION = "7f61e98d7df54be9b2e0e4d46ec6ddf7f1b3ac0d"
# RULES_DOCKER_SHA256 = "01bcef77bab3e9c1564f0d2ee84180ec85ba2781004a19de4acf21d4f17fa2c6"

RULES_DOCKER_VERSION = "c9065d170c076d540166f068aec0e04039a10e66"
RULES_DOCKER_SHA256 = "e1403c24f894b49bfd64f47b74a594687567c0180eddf43d014a565b3c5552e6"

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = RULES_DOCKER_SHA256,
    strip_prefix = "rules_docker-" + RULES_DOCKER_VERSION,
    urls = ["https://github.com/bazelbuild/rules_docker/archive/%s.tar.gz" % RULES_DOCKER_VERSION],
)


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

# RULES_K8S_VERSION = "8537afcc8728e5ebfafa9b68462e54a98935d06b"
# RULES_K8S_SHA256 = "2a8727f40c9988eb7d411908685454aae6f9dcda4ff3b210de8ff2e9798e919a"

RULES_K8S_VERSION = "62ae7911ef60f91ed32fdd48a6b837287a626a80"
RULES_K8S_SHA256 = "9bf9974199b3908a78638d3c7bd688bc2a69b3ddc857bd160399c58ca7fc18ea"

http_archive(
    name = "io_bazel_rules_k8s",
    url = "https://github.com/bazelbuild/rules_k8s/archive/%s.zip" % RULES_K8S_VERSION,
    strip_prefix = "rules_k8s-" + RULES_K8S_VERSION,
    sha256 = RULES_K8S_SHA256,
)

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")

k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_defaults")

k8s_defaults(
    name = "k8s_deploy",
    kind = "deployment",
    cluster = "gke_stackb-151821_us-central1-a_remote-execution",
    #cluster = "gke_stackb-151821_us-central1-a_cluster-1",
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

#####################################################################
# BUILDGRID
#####################################################################

BUILDGRID_VERSION = "a49581a60a595fcca0ddb7beec958cf943f09cf7"

load("//grid:workspace.bzl", "buildgrid_repository")

buildgrid_repository(
    name = "buildgrid_server",
    commit = BUILDGRID_VERSION,
)

buildgrid_repository(
    name = "buildgrid_worker",
    commit = BUILDGRID_VERSION,
    dockerfile = "//grid/worker:Dockerfile",
)

load(
    "@io_bazel_rules_docker//container:container.bzl",
    container_repositories = "repositories",
    "container_pull",
)

container_pull(
    name = "rbe_ubuntu",
    registry = "gcr.io",
    repository = "cloud-marketplace/google/rbe-ubuntu16-04",
    digest = "sha256:9bd8ba020af33edb5f11eff0af2f63b3bcb168cd6566d7b27c6685e717787928",
    #tag = "latest",
)
