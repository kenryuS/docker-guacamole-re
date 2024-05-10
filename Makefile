NAME=docker-guacamole
VERSION=1.5.5

UID=${user_id}
GID=${group_id}

all: build-amd64 build-armhf

test-image: test-build-amd64-image test-build-armhf-image

test-local: test-build-amd64-local test-build-armhf-local

build-amd64:
	docker buildx build --push --platform=linux/amd64 --tag kenryus/docker-guacamole:latest .
	docker buildx build --push --platform=linux/amd64 --tag kenryus/docker-guacamole:$(VERSION) .

build-armhf:
	docker buildx build --push --platform=linux/armhf --tag kenryus/docker-guacamole:armhf -f ./Dockerfile.raspberry-pi .
	docker buildx build --push --platform=linux/armhf --tag kenryus/docker-guacamole:$(VERSION)-armhf -f ./Dockerfile.raspberry-pi .

test-build-amd64-local:
	/bin/rm -drf build/amd64
	mkdir -p build/amd64
	docker buildx build --output=type=local,dest=build/amd64 --platform=linux/amd64 .

test-build-armhf-local:
	/bin/rm -drf build/armhf
	mkdir -p build/armhf
	docker buildx build --output=type=local,dest=build/armhf --platform=linux/armhf -f ./Dockerfile.raspberry-pi .

test-build-amd64-image:
	docker buildx build --load --platform=linux/amd64 --tag kenryus/docker-guacamole:test .

test-build-armhf-image:
	docker buildx build --load --platform=linux/armhf --tag kenryus/docker-guacamole:test-armhf -f ./Dockerfile.raspberry-pi .

