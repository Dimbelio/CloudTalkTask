# Makefile for Docker-compose

down:
	docker-compose down -v --rmi all

build:
	docker-compose --profile main-image build 

run:
	docker-compose up

build-clean:
	docker-compose build --no-cache
