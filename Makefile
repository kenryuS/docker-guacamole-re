NAME=docker-guacamole
VERSION=1.5.4

all: build-amd64 build-armhf

build-amd64:
	docker buildx build --pull --push --platform=linux/amd64 --tag kenryus/docker-guacamole:latest .
	docker buildx build --pull --push --platform=linux/amd64 --tag kenryus/docker-guacamole:$(VERSION) .

build-armhf:
	docker buildx build --pull --push --platform=linux/armhf --tag kenryus/docker-guacamole:armhf -f ./Dockerfile.raspberry-pi .
	docker buildx build --pull --push --platform=linux/armhf --tag kenryus/docker-guacamole:$(VERSION)-armhf -f ./Dockerfile.raspberry-pi .

test-build-amd64:
	/bin/rm -drf build/amd64
	mkdir -p build/amd64
	docker buildx build --pull --output=type=local,dest=build/amd64 --platform=linux/amd64 .

test-build-armhf:
	/bin/rm -drf build/armhf
	mkdir -p build/armhf
	docker buildx build --pull --output=type=local,dest=build/armhf --platform=linux/armhf -f ./Dockerfile.raspberry-pi .
