
def local_buildfarm_repository(path):

    native.local_repository(
        name = "build_buildfarm",
        path = path,
    )

    native.new_http_archive(
        name = "googleapis",
        sha256 = "7b6ea252f0b8fb5cd722f45feb83e115b689909bbb6a393a873b6cbad4ceae1d",
        url = "https://github.com/googleapis/googleapis/archive/143084a2624b6591ee1f9d23e7f5241856642f4d.zip",
        strip_prefix = "googleapis-143084a2624b6591ee1f9d23e7f5241856642f4d",
        build_file = "@build_buildfarm//:BUILD.googleapis",
    )

    # The API that we implement.
    native.new_http_archive(
        name = "remote_apis",
        sha256 = "865c6950a64b859cf211761330e5d13e6c4b54e22a454ae1195238594299de34",
        url = "https://github.com/bazelbuild/remote-apis/archive/fdeb922b595df28650d12fc2335c4426df2fc726.zip",
        strip_prefix = "remote-apis-fdeb922b595df28650d12fc2335c4426df2fc726",
        build_file = "@build_buildfarm//:BUILD.remote_apis",
    )

    native.http_archive(
        name = "grpc_java",
        sha256 = "20a35772b20d8194854f6d149324f971472b7acc1a76a0969a048c4c02a1da0d",
        strip_prefix = "grpc-java-1.8.0",
        urls = ["https://github.com/grpc/grpc-java/archive/v1.8.0.zip"],
    )
