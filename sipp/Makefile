# Makefile for SIPp

service := sipp_cloudt
tag := red

container_name := sipp_cloudt
network := test_network
# Generated variables.
main_image := $(service):$(tag)

# TARGETS

docker_run_args := --network ${network} -d \
					--name ${container_name} $(main_image) 


.PHONY: all clean push build

all: build


clean:
	-docker rmi -f $(main_image) && docker rm ${container_name}

push:
	docker push $(main_image)

build:
	docker rmi -f $(main_image)
	docker build --build-arg FULL=1 -t $(main_image) .


run:
	docker rm -f ${container_name} 2>/dev/null || true && docker run ${docker_run_args}

stop:
	docker stop ${container_name}

exec:
	docker exec -it ${container_name} bash

