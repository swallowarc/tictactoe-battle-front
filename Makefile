# basic parameters
NAME     := tictactoe-battle-frontend
VERSION  := v0.0.0
REVISION := $(shell git rev-parse --short HEAD)

# build parameters
BACKEND_URI ?= http://localhost:8080
DOCKER_USER ?= fake_suer
DOCKER_PASS ?= fake_pass
DOCKER_REGISTRY = swallowarc/tictactoe-battle-frontend

.PHONY: build/release docker/login docker/build docker/push generate test
build/release:
	flutter pub get
	flutter build web --release --dart-define=BACKEND_URI=$(BACKEND_URI)

docker/login:
	docker login -u $(DOCKER_USER) -p $(DOCKER_PASS)

docker/build:
	docker build -t $(DOCKER_REGISTRY) .

docker/push: docker-login
	docker push $(DOCKER_REGISTRY)

generate:
	flutter pub run build_runner build --delete-conflicting-outputs

test:
	flutter test
