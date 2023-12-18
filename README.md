# Builder Bash
A Docker image that provides an environment to run static code analyze and run unit tests on bash scripts.

## Description
The image is based on the index.docker.io/flounderpinto/runner-bash image and adds shellcheck and shunit2.

## Docker repo
```bash
index.docker.io/flounderpinto/builder-bash:<VERSION>
```

## Usage

### Makefile Docker example
The commands to run static code analysis or tests via the builder-bash container can be contained in a Makefile.

```Makefile
USER=$(shell id -u):$(shell id -g)
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

CONTAINER_CODE_DIR=/opt/code

DOCKER_REGISTRY=index.docker.io/flounderpinto

ANALYZE_CMD=cd ./src        && find . -name '*.sh' | xargs shellcheck -x && \
            cd ../test/unit && find . -name '*.sh' | xargs shellcheck -x
UNIT_TEST_CMD=cd ./test/unit && ./test.sh

BUILDER_IMAGE=${DOCKER_REGISTRY}/builder-bash:<TODO-VERSION>
BUILDER_PULL_CMD=docker pull ${BUILDER_IMAGE}
BUILDER_RUN_CMD=${BUILDER_PULL_CMD} && \
    docker run \
        --rm \
        --user ${USER} \
        -v ${ROOT_DIR}:${CONTAINER_CODE_DIR} \
        -w ${CONTAINER_CODE_DIR} \
        ${BUILDER_IMAGE} /bin/bash -c

.PHONY: analyze analyze_local unit_test unit_test_local

analyze:
	${BUILDER_RUN_CMD} "${ANALYZE_CMD}"

analyze_local:
	${ANALYZE_CMD}

unit_test:
	${BUILDER_RUN_CMD} "${UNIT_TEST_CMD}"

unit_test_local:
	${UNIT_TEST_CMD}

all: | analyze unit_test
```

## License
Distributed under the MIT License. See `LICENSE.txt` for more information.