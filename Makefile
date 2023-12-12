ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

CONTAINER_CODE_DIR=/opt/code

#TODO - registry var needs to move elsewhere. Builder?
DOCKER_REGISTRY=index.docker.io/flounder5
DOCKER_REPO=builder-bash
DOCKER_BUILD_CMD=dockerBuildStandard -e ${DOCKER_REGISTRY} -r ${DOCKER_REPO} ${ARGS}

DOCKER_BUILDER_IMAGE=flounder5/builder-docker:v0.0.6
DOCKER_BUILDER_PULL_CMD=docker pull ${DOCKER_BUILDER_IMAGE}
DOCKER_BUILDER_RUN_CMD=${DOCKER_BUILDER_PULL_CMD} && \
    docker run \
        --rm \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v ${HOME}/.docker:/tmp/.docker:ro \
        -v ${ROOT_DIR}:${CONTAINER_CODE_DIR} \
        ${DOCKER_BUILDER_IMAGE}

.PHONY: docker

docker:
	${DOCKER_BUILDER_RUN_CMD} ${DOCKER_BUILD_CMD}

#Everything right of the pipe is order-only prerequisites.
all: | docker