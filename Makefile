# The DOCKER_HOST endpoint
ENDPOINT ?= tcp://localhost:8080

CTR_IMAGE ?= quay.io/libpod/docker-py:latest
CTR_ENGINE ?= podman
CTR_COMMAND = run --rm --security-opt label=disable --privileged \
	      	-v $(testLogs):/testLogs --net=host -e DOCKER_HOST=$(ENDPOINT)

.PHONY: build-container-image
build-container-image:
	$(CTR_ENGINE) build -t $(CTR_IMAGE) -f ./Dockerfile-py3 .

.PHONY: shell
shell:
	@echo "Connecting to $(ENDPOINT)"
	$(eval testLogs=$(shell mktemp))
	@echo "Test logs at $(testLogs)"
	@echo "Note that PWD is mounted at /src."
	$(CTR_ENGINE) $(CTR_COMMAND) -v `pwd`:/src -it $(CTR_IMAGE) sh

.PHONY: test
test:
	@echo "Connecting to $(ENDPOINT)"
	$(eval testLogs=$(shell mktemp))
	@echo "Test logs at $(testLogs)"
	@echo "Use the TEST env var to control which tests are being run, for instance:"
	@echo "    TEST=tests/integration/api_container_test.py::ListContainersTest"
	$(CTR_ENGINE) $(CTR_COMMAND) $(CTR_IMAGE) sh -c "pytest $(TEST)"
