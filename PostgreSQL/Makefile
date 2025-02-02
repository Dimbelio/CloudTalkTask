# Makefile for PostgreSQL

service := postgresql_cloudt
tag := red

container_name := postgresql_cloudt
network := test_network
# Generated variables.
main_image := $(service):$(tag)

# TARGETS

docker_run_args := --network ${network} -d \
					 -v postgres_cloudt:/var/lib/postgresql \
					--name ${container_name} $(main_image) 


.PHONY: all clean push build

all: build

clean:
	-docker rmi -f $(main_image) && docker rm ${container_name} && docker volume rm postgres_cloudt

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
	docker logs  postgresql_cloudt

