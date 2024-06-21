NAME=docker-guacamole
VERSION=1.5.5

UID=${user_id}
GID=${group_id}

all: build-amd64 build-armhf build-arm64

public-test: public-test-amd64 public-test-armhf public-test-arm64

test-image: test-build-amd64-image test-build-armhf-image test-build-arm64-image

test-local: test-build-amd64-local test-build-armhf-local test-build-arm64-local

public-test-amd64:
	docker buildx build --push --platform=linux/amd64 --progress plain --tag kenryus/docker-guacamole:test-$(VERSION) .

public-test-armhf:
	docker buildx build --push --platform=linux/armhf --progress plain --tag kenryus/docker-guacamole:test-$(VERSION)-armhf -f ./Dockerfile.raspberry-pi-32 .

public-test-arm64:
	docker buildx build --push --platform=linux/arm64 --progress plain --tag kenryus/docker-guacamole:test-$(VERSION)-arm64 -f ./Dockerfile.raspberry-pi-64 .

build-amd64:
	docker buildx build --push --platform=linux/amd64 --tag kenryus/docker-guacamole:latest .
	docker buildx build --push --platform=linux/amd64 --tag kenryus/docker-guacamole:$(VERSION) .

build-armhf:
	docker buildx build --push --platform=linux/armhf --tag kenryus/docker-guacamole:armhf -f ./Dockerfile.raspberry-pi-32 .
	docker buildx build --push --platform=linux/armhf --tag kenryus/docker-guacamole:$(VERSION)-armhf -f ./Dockerfile.raspberry-pi-32 .

build-arm64:
	docker buildx build --push --platform=linux/arm64 --tag kenryus/docker-guacamole:arm64 -f ./Dockerfile.raspberry-pi-64 .
	docker buildx build --push --platform=linux/arm64 --tag kenryus/docker-guacamole:$(VERSION)-arm64 -f ./Dockerfile.raspberry-pi-64 .

test-build-amd64-local:
	/bin/rm -drf build/amd64
	mkdir -p build/amd64
	docker buildx build --output=type=local,dest=build/amd64 --platform=linux/amd64 .

test-build-armhf-local:
	/bin/rm -drf build/armhf
	mkdir -p build/armhf
	docker buildx build --output=type=local,dest=build/armhf --platform=linux/armhf -f ./Dockerfile.raspberry-pi-32 .

test-build-arm64-local:
	/bin/rm -drf build/arm64
	mkdir -p build/arm64
	docker buildx build --output=type=local,dest=build/arm64 --platform=linux/arm64 -f ./Dockerfile.raspberry-pi-64 .

test-build-amd64-image:
	docker buildx build --load --platform=linux/amd64 --tag kenryus/docker-guacamole:test .

test-build-armhf-image:
	docker buildx build --load --platform=linux/armhf --tag kenryus/docker-guacamole:test-armhf -f ./Dockerfile.raspberry-pi-32 .

test-build-arm64-image:
	docker buildx build --load --platform=linux/arm64 --tag kenryus/docker-guacamole:test-arm64 -f ./Dockerfile.raspberry-pi-64 .

