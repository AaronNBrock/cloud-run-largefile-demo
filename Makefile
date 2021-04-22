TAG  ?= gcr.io/sada-aaron-brock/cloud-run-largefile-demo:latest

export DOCKER_BUILDKIT = 1
pull:
	-docker pull $(TAG)

build: pull
	docker build \
		-t $(TAG) \
		--cache-from $(TAG) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		.

run: build
	docker run \
		--rm \
		-p 8080:80 \
		--name largefile \
		$(TAG)
exec:
	docker exec \
		-it \
		largefile \
		/bin/sh

push: build
	docker push $(TAG)

fmt:
	docker run --rm -it --volume $(shell pwd):/app --workdir /app golang:1.15-alpine go fmt
