# Copyright 2022 PsychoGenics, All rights reserved.

PROJECT				?= dc_ws
DOCKER_IMAGE		?= ${PROJECT}:latest
SHMSIZE				?= 444G
WORKSPACE			?= /home/guest/${PROJECT}
DOCKER_BUILDKIT		:=1
DOCKER_OPTS			:= \
						--name ${PROJECT} \
						--shm-size=${SHMSIZE} \
						--runtime=nvidia \
						--privileged \
						-d \
						--rm \
						--gpus all \
						-v /tmp:/tmp \
						-v ${LOCAL_DC_DATA_MNT}:/local_data \
						-v ${DC_DATA_MNT}:/data \
						-e NVIDIA_DRIVER_CAPABILITIES=all \
						-e NVIDIA_VISIBLE_DEVICES=all \
						-v ${PWD}:${WORKSPACE}
DOCKER_RUNNING		:=$(shell docker ps -q)
DOCKER_CONTAINERS	:=$(shell docker ps -a -q)
DOCKER_IMAGES		:=$(shell docker images -q)
DOCKER_HOST         :=$(shell hostname)_DOCKER

# src files for Dockerfile
DOC_TMP				:= dockerfile.tmp
DOC_BASH_FILES		:= docker/Dockerfile.GPU \
						docker/Dockerfile.BASH
DOC_ZSH_FILES		:= docker/Dockerfile.GPU \
						docker/Dockerfile.SSH \
						docker/Dockerfile.JUPYTER \
						docker/Dockerfile.ZSH 

# Makefile commands
.PHONY: all clean docker-run

all: clean

clean:
	find . -name "*.pyc" | xargs rm -f && \
	find . -name "__pycache__" | xargs rm -rf

combine-doc-bash:
	@echo "Building BASH shell version"
	@cat $(DOC_BASH_FILES) > $(DOC_TMP)

combine-doc-zsh:
	@echo "Building ZSH shell version"
	@cat $(DOC_ZSH_FILES) > $(DOC_TMP)

docker-kill:
	docker kill ${DOCKER_RUNNING}

docker-rm-containers:
	docker rm ${DOCKER_CONTAINERS}

docker-rm-images:
	docker rmi $(DOCKER_IMAGES)

docker-purge: docker-rm-containers docker-rm-images

# Docker build step
ifdef USE_ZSH
docker-build: combine-doc-zsh
else
docker-build: combine-doc-bash
endif
docker-build:
	docker build -f ${DOC_TMP} -t ${DOCKER_IMAGE} .
	rm -f ${DOC_TMP}

# Run: create a *new* container of an image (input), and execute the container.
# E.g.: docker run IMAGE_ID
docker-run: docker-build
	docker run ${DOCKER_OPTS} -h=${DOCKER_HOST} -t ${DOCKER_IMAGE}

# Start: Launch a container previously stopped.
# E.g.: docker start CONTAINER_ID
docker-start:
	docker start ${PROJECT}

# Stop: Disable a container currently running.
# E.g.: docker stop CONTAINER_ID
docker-stop:
	docker stop ${PROJECT}

docker-bash:
	docker exec -it ${PROJECT} bash
