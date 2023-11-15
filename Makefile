NAME=docker-guacamole
VERSION=1.5.3

all: build-amd64 build-armhf

build-amd64:
	docker buildx build --push --platform=linux/amd64 --tag kenryus/docker-guacamole:latest .
	docker buildx build --push --platform=linux/amd64 --tag kenryus/docker-guacamole:$(VERSION) .

build-armhf:
	docker buildx build --push --platform=linux/armhf --tag kenryus/docker-guacamole:armhf .
	docker buildx build --push --platform=linux/armhf --tag kenryus/docker-guacamole:$(VERSION)-armhf .

test-build:
	mkdir -p build
	docker buildx build --output=type=local,dest=build --platform=linux/amd64,linux/armhf .
