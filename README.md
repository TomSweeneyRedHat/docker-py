This is a fork of docker/docker-py and used to facilitate the v2 API work of libpod.
Some integration tests of docker-py will fail for various reasons (e.g., different error message); fixing these may not be possible in all cases.
Hence, we need to adjust certain tests in order to make them pass.

Run `make build-container-image` to build the `quay.io/libpod/docker-py:latest` image locally.

Run `make shell` to run the container and get a shell.
Note that `make shell` mounts the current working directory to `/src` allowing to edit and adjust the tests on the host while running them in the container.

Run `make test` to run all integration tests.
Use the `$TEST` environment variable to control which tests are being executed, e.g., `TEST="tests/integration/api_container_test.py::ListContainersTest make test`.
