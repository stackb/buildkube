# buildkube

Buildkube facilitates installing [bazel-buildfarm]() and/or [BuildGrid] into an existing kubernetes cluster using [rules_docker]() and [rules_k8s]()

  digest_function: SHA256

  memory_instance_config: {

    # Operations#listOperations request limits
    list_operations_default_page_size: 1024
    list_operations_max_page_size: 16384

    # ContentAddressableStorage#getTree request limits
    tree_default_page_size: 1024
    tree_max_page_size: 16384

    # the maximum time after dispatch of an operation until
    # the worker must poll to indicate continued work, after
    # which the operation will be requeued
    operation_poll_timeout: {
      seconds: 30
      nanos: 0
    }

    # the delay after an action timeout before an action is
    # automatically considered to have failed with no results
    # and a timeout exceeded failure condition
    operation_completed_delay: {
      seconds: 10
      nanos: 0
    }

    # an imposed action-key-invariant timeout used in the unspecified timeout case
    default_action_timeout: {
      seconds: 600
      nanos: 0
    }

    # a limit on the action timeout specified in the action, above which
    # the operation will report a failed result immediately
    maximum_action_timeout: {
      seconds: 3600
      nanos: 0
    }

    
  }

NOTES

* BuildFarm worker does not detect if server goes down.  Must manually `kubectl delete pod --selector=k8s-app=worker` when re-installing or updating server deployment.

* When a worker registers itself with the server (operation-queue), it provides
  a dict of key:value pairs that must match the action execution requirements.
  EXPLAIN MORE HERE. 