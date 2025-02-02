# Makefile for Asterisk

service := asterisk_cloudt
tag := red

container_name := asterisk_cloudt
network := test_network

# Generated variables.
main_image := $(service):$(tag)

docker_run_args := --network ${network} -d \
					-p 5060:5060 \
					--name ${container_name} $(main_image) 
					



# TARGETS

.PHONY: all clean push build

all: build

clean:
	-docker rmi -f $(main_image)

push:
	docker push $(main_image)

build:
	docker rmi -f $(main_image)
	docker build  -t $(main_image) .

run:
	docker rm -f ${container_name} 2>/dev/null || true && docker run ${docker_run_args} 
stop:
	docker stop ${container_name}

exec:
	docker exec -it ${container_name} bash

logs:
	docker logs ${container_name}