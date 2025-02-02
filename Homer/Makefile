# Makefile for Homer

service := homer_cloudt
tag := red

container_name := homer_cloudt
network := test_network

# Generated variables.
main_image := $(service):$(tag)

docker_run_args := --network ${network} -d \
					--name ${container_name} $(main_image) \


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
	docker rm -f ${container_name} 2>/dev/null || true && docker run ${docker_run_args} -p 9060:9060 heplify-server

stop:
	docker stop ${container_name}

exec:
	docker exec -it ${container_name} bash

logs:
	docker logs ${container_name}