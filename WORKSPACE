workspace(name = "com_github_stackb_buildkube")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

#####################################################################
# rules_go
#####################################################################

RULES_GO_VERSION = "43d7595b0123b5f0cc35bd45c084582b3eb3198b"
RULES_GO_SHA256 = "31ac06c3101ae13c226cdbccefd5f14577249c7e78bb344aabfb8e5d29366079"

http_archive(
    name = "io_bazel_rules_go",
    strip_prefix = "rules_go-" + RULES_GO_VERSION,
    urls = ["https://github.com/bazelbuild/rules_go/archive/%s.tar.gz" % RULES_GO_VERSION],
    sha256 = RULES_GO_SHA256,
)

load("@io_bazel_rules_go//go:def.bzl", "go_rules_dependencies", "go_register_toolchains")

go_rules_dependencies()

go_register_toolchains()


#####################################################################
# bazel_skylib
#####################################################################

http_archive(
    name = "bazel_skylib",
    sha256 = "b5f6abe419da897b7901f90cbab08af958b97a8f3575b0d3dd062ac7ce78541f",
    strip_prefix = "bazel-skylib-0.5.0",
    urls = ["https://github.com/bazelbuild/bazel-skylib/archive/0.5.0.tar.gz"],
)


#####################################################################
# rules_docker
#####################################################################

RULES_DOCKER_VERSION = "c9065d170c076d540166f068aec0e04039a10e66"
RULES_DOCKER_SHA256 = "e1403c24f894b49bfd64f47b74a594687567c0180eddf43d014a565b3c5552e6"

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = RULES_DOCKER_SHA256,
    strip_prefix = "rules_docker-" + RULES_DOCKER_VERSION,
    urls = ["https://github.com/bazelbuild/rules_docker/archive/%s.tar.gz" % RULES_DOCKER_VERSION],
)


#############################################################
# worker execution container
#############################################################

load(
    "@io_bazel_rules_docker//container:container.bzl",
    container_repositories = "repositories",
    "container_pull",
)

RBE_UBUNTU_REGISTRY = "gcr.io"
RBE_UBUNTU_REPOSITORY = "cloud-marketplace/google/rbe-ubuntu16-04"
RBE_UBUNTU_DIGEST = "sha256:9bd8ba020af33edb5f11eff0af2f63b3bcb168cd6566d7b27c6685e717787928"
RBE_UBUNTU_TAG = "%s/%s@%s" % (RBE_UBUNTU_REGISTRY, RBE_UBUNTU_REPOSITORY, RBE_UBUNTU_DIGEST)

container_pull(
    name = "rbe_ubuntu",
    registry = RBE_UBUNTU_REGISTRY,
    repository = RBE_UBUNTU_REPOSITORY,
    digest = RBE_UBUNTU_DIGEST,
)

#############################################################
# KUBERNETES
#############################################################

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
)


#####################################################################
# BUILDFARM
#####################################################################

load(
    "@io_bazel_rules_docker//java:image.bzl",
    java_image_repositories = "repositories",
)

java_image_repositories()

load("//farm:workspace.bzl", "buildfarm_repository")

BUILDFARM_VERSION = "7f8f4c407041b5cd6795b28121cef7d3a3cbab2b"

buildfarm_repository(
    name = "build_buildfarm",
    commit = BUILDFARM_VERSION,
)

# Switch to the following for local buildfarm development
#
# load("//farm:local_repository.bzl", "local_buildfarm_repository")
# local_buildfarm_repository(
#     path = "../../bazelbuild/bazel-buildfarm",
# )
# load("@build_buildfarm//3rdparty:workspace.bzl", "maven_dependencies", "declare_maven")
# maven_dependencies(declare_maven)


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
    dockerfile = """
FROM {base_image_tag}
RUN python3 -m pip install --upgrade setuptools pip
WORKDIR /app
COPY . .
RUN pip install --user --editable .
    """.format(base_image_tag = RBE_UBUNTU_TAG),
)


#####################################################################
# BUILDBARN
#####################################################################


http_archive(
    name = "bazel_gazelle",
    sha256 = "bc653d3e058964a5a26dcad02b6c72d7d63e6bb88d94704990b908a1445b8758",
    urls = ["https://github.com/bazelbuild/bazel-gazelle/releases/download/0.13.0/bazel-gazelle-0.13.0.tar.gz"],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

load("//barn:workspace.bzl", "buildbarn_repositories")

buildbarn_repositories()

BUILDBARN_VERSION = "e4c05f8003ae7a9f80876ed8fe61cf9b0e4b0784"
BUILDBARN_SHA256 = "e4f4abc2fa5ddcd50c1652d21a28973113408b50f5151fcbe570d985f8bc7599"

http_archive(
    name = "buildbarn",
    strip_prefix = "bazel-buildbarn-" + BUILDBARN_VERSION,
    urls = ["https://github.com/EdSchouten/bazel-buildbarn/archive/%s.tar.gz" % BUILDBARN_VERSION],
    sha256 = BUILDBARN_SHA256,
    patch_cmds = [
        # Expose the go_library targets so we can build our own binaries / images
        "sed -i 's|//visibility:private|//visibility:public|g' cmd/bbb_frontend/BUILD.bazel",
        "sed -i 's|//visibility:private|//visibility:public|g' cmd/bbb_scheduler/BUILD.bazel",
        "sed -i 's|//visibility:private|//visibility:public|g' cmd/bbb_worker/BUILD.bazel",
    ],
)

# local_repository(
#     name = "buildbarn",
#     path = "../../EdShouten/bazel-buildbarn",
# )

load(
    "@io_bazel_rules_docker//go:image.bzl",
    go_image_repositories = "repositories",
)

go_image_repositories()
