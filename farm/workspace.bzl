load("@io_bazel_rules_docker//container:load.bzl", "container_load")

BUILD_BAZEL = """
java_import(
    name = "server",
    jars = ["server.jar"],
    visibility = ["//visibility:public"],
)
java_import(
    name = "worker",
    jars = ["worker.jar"],
    visibility = ["//visibility:public"],
)
"""

def _buildfarm_repository_impl(repository_ctx):
    commit = repository_ctx.attr.commit

    url = repository_ctx.attr.remote.format(
        commit = commit,
    )

    print("Installing " + url)

    # Download and unarchive it!
    repository_ctx.download_and_extract(url, 
        stripPrefix = "-".join(["bazel-buildfarm", commit]),
    )

    result = repository_ctx.execute(["bazel", "build", 
        "//src/main/java/build/buildfarm:buildfarm-server_deploy.jar",
        "//src/main/java/build/buildfarm:buildfarm-worker_deploy.jar",
    ], quiet = False)
    if result.return_code: 
        fail("bazel build failed: %s" % result.stderr)
    
    result = repository_ctx.execute(["cp", "bazel-bin/src/main/java/build/buildfarm/buildfarm-server_deploy.jar", "./server.jar"])
    if result.return_code: 
        fail("copy failed: %s" % result.stderr)
    result = repository_ctx.execute(["cp", "bazel-bin/src/main/java/build/buildfarm/buildfarm-worker_deploy.jar", "./worker.jar"])
    if result.return_code: 
        fail("copy failed: %s" % result.stderr)

    repository_ctx.file("BUILD.bazel", BUILD_BAZEL)


buildfarm_repository = repository_rule(
    implementation = _buildfarm_repository_impl,
    attrs = {
        "remote": attr.string(
            default = "https://github.com/bazelbuild/bazel-buildfarm/archive/{commit}.tar.gz",
        ),
        "commit": attr.string(
            mandatory = True,
        ),
    }
)
