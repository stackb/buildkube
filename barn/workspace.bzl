load("@bazel_gazelle//:deps.bzl", "go_repository")

def buildbarn_repositories():
    go_repository(
        name = "com_github_aws_aws_sdk_go",
        importpath = "github.com/aws/aws-sdk-go",
        sha256 = "b6cd9c78df8aeb973f8d9b01d11c1d1e5096850614b3a3e0b4111ec747d811d3",
        strip_prefix = "aws-sdk-go-bc3f534c19ffdf835e524e11f0f825b3eaf541c3",
        urls = ["https://github.com/aws/aws-sdk-go/archive/bc3f534c19ffdf835e524e11f0f825b3eaf541c3.tar.gz"],
    )

    go_repository(
        name = "com_github_beorn7_perks",
        commit = "3a771d992973f24aa725d07868b467d1ddfceafb",
        importpath = "github.com/beorn7/perks",
    )

    go_repository(
        name = "com_github_go_ini_ini",
        commit = "358ee7663966325963d4e8b2e1fbd570c5195153",
        importpath = "github.com/go-ini/ini",
    )

    go_repository(
        name = "com_github_golang_protobuf",
        commit = "b4deda0973fb4c70b50d226b1af49f3da59f5265",
        importpath = "github.com/golang/protobuf",
    )

    go_repository(
        name = "com_github_jmespath_go_jmespath",
        commit = "0b12d6b5",
        importpath = "github.com/jmespath/go-jmespath",
    )

    go_repository(
        name = "com_github_matttproud_golang_protobuf_extensions",
        commit = "c12348ce28de40eed0136aa2b644d0ee0650e56c",
        importpath = "github.com/matttproud/golang_protobuf_extensions",
    )

    go_repository(
        name = "com_github_prometheus_client_golang",
        commit = "c5b7fccd204277076155f10851dad72b76a49317",
        importpath = "github.com/prometheus/client_golang",
    )

    go_repository(
        name = "com_github_prometheus_client_model",
        commit = "5c3871d89910bfb32f5fcab2aa4b9ec68e65a99f",
        importpath = "github.com/prometheus/client_model",
    )

    go_repository(
        name = "com_github_prometheus_common",
        commit = "7600349dcfe1abd18d72d3a1770870d9800a7801",
        importpath = "github.com/prometheus/common",
    )

    go_repository(
        name = "com_github_prometheus_procfs",
        commit = "ae68e2d4c00fed4943b5f6698d504a5fe083da8a",
        importpath = "github.com/prometheus/procfs",
    )

    go_repository(
        name = "com_github_satori_go_uuid",
        commit = "f58768cc1a7a7e77a3bd49e98cdd21419399b6a3",
        importpath = "github.com/satori/go.uuid",
    )

    go_repository(
        name = "org_golang_google_genproto",
        commit = "e92b116572682a5b432ddd840aeaba2a559eeff1",
        importpath = "google.golang.org/genproto",
    )

    go_repository(
        name = "org_golang_google_grpc",
        commit = "168a6198bcb0ef175f7dacec0b8691fc141dc9b8",
        importpath = "google.golang.org/grpc",
    )

    go_repository(
        name = "org_golang_x_net",
        commit = "039a4258aec0ad3c79b905677cceeab13b296a77",
        importpath = "golang.org/x/net",
    )

    go_repository(
        name = "org_golang_x_text",
        commit = "f21a4dfb5e38f5895301dc265a8def02365cc3d0",
        importpath = "golang.org/x/text",
    )

    go_repository(
        name = "com_github_grpc_ecosystem_go_grpc_prometheus",
        commit = "c225b8c3b01faf2899099b768856a9e916e5087b",
        importpath = "github.com/grpc-ecosystem/go-grpc-prometheus",
    )

    go_repository(
        name = "com_github_go_redis_redis",
        commit = "480db94d33e6088e08d628833b6c0705451d24bb",
        importpath = "github.com/go-redis/redis",
    )

    go_repository(
        name = "com_github_bazelbuild_remote_apis",
        commit = "6130f7e23ae157d5cf12c5d6af325a1dae57e235",
        importpath = "github.com/bazelbuild/remote-apis",
    )
