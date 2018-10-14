load("@io_bazel_rules_docker//container:load.bzl", "container_load")

BUILD_BAZEL = """
exports_files(["image.tar"])
"""


def _buildgrid_repository_impl(repository_ctx):
    commit = repository_ctx.attr.commit
    tag = "buildgrid-" + commit

    # Build the gitlab url where buildgrid is installed
    url = repository_ctx.attr.remote + "?ref=" + commit

    print("Installing " + url)

    # Download and unarchive it!
    repository_ctx.download_and_extract(url, 
        stripPrefix = "-".join(["buildgrid", commit, commit]),
    )

    if repository_ctx.attr.dockerfile:
        repository_ctx.file("Dockerfile", repository_ctx.attr.dockerfile)

    result = repository_ctx.execute(["docker", "build", "-t", tag, "."], quiet = False)
    if result.return_code: 
        fail("docker build failed: %s" % result.stderr)
    
    result = repository_ctx.execute(["docker", "save", "-o", "image.tar", tag], quiet = False)
    if result.return_code: 
        fail("docker build failed: %s" % result.stderr)

    repository_ctx.file("BUILD.bazel", BUILD_BAZEL)


_buildgrid_repository = repository_rule(
    implementation = _buildgrid_repository_impl,
    attrs = {
        "remote": attr.string(
            default = "https://gitlab.com/BuildGrid/buildgrid/repository/archive.tar.gz",
        ),
        "dockerfile": attr.string(
            doc = "The Dockerfile content to use when building the image.",
        ),
        "commit": attr.string(
            mandatory = True,
        ),
    }
)

def buildgrid_repository(**kwargs):
    name = kwargs.pop("name")
    name_tar = name + "_tar"
    kwargs["name"] = name_tar

    _buildgrid_repository(**kwargs)

    container_load(
        name = name,
        file = "@%s//:image.tar" % name_tar,
    )
