# Makefile for Docker-compose

down:
	docker-compose down -v --rmi all

build-main-image:
	docker-compose --profile main-image build main-image

build:
	docker-compose --profile main-image build

run:
	docker-compose up

build-clean:
	docker-compose --profile main-image build --no-cache
