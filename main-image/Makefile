# Makefile for main-image
service := main-image
tag := red

container_name := main-os

# Generated variables.
main_image := $(service):$(tag)

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
	docker rm -f ${container_name} 2>/dev/null || true && docker run -d --name ${container_name} $(main_image)

stop:
	docker stop ${container_name}

exec:
	docker exec -it ${container_name} bash

