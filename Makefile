.DEFAULT_GOAL = docker-run

SOURCE_DIR = src

OS = Windows
ARCH = x86_64
BUILD_TYPE = Release
BUILD_DIR_PREFIX = build
BUILD_DIR = $(BUILD_DIR_PREFIX)_$(OS)_$(ARCH)_$(BUILD_TYPE)

PROJECT = hello-world
ifeq ($(OS),Windows)
	CONAN_IMAGE_VERSION = gcc7-mingw
endif
ifeq ($(OS),Linux)
	CONAN_IMAGE_VERSION = gcc7
endif
CONAN_CACHE_VOLUME = $(PROJECT)_$(CONAN_IMAGE_VERSION)_conan_cache
CONTAINER_NAME = $(PROJECT)_conan_env
IMAGE = $(PROJECT):$(CONAN_IMAGE_VERSION)
WORKDIR = /home/conan/$(PROJECT)

.PHONY: conan-source
.ONESHELL: conan-source
conan-source:
	if [ ! -d "$(SOURCE_DIR)" ]; then
		conan source . \
		--source-folder $(SOURCE_DIR)
	fi

.PHONY: conan-install
.ONESHELL: conan-install
conan-install:
	conan install . \
	--install-folder $(BUILD_DIR) \
	--settings os=$(OS) \
	--settings build_type=$(BUILD_TYPE) \
	--settings arch=$(ARCH)

.PHONY: conan-build
.ONESHELL: conan-build
conan-build:
	conan build . \
	--build-folder $(BUILD_DIR) \
	--source-folder $(SOURCE_DIR)

.PHONY: build
build: conan-source
build: conan-install
build: conan-build

.PHONY: docker-build
.ONESHELL: docker-build
docker-build:
	docker build \
	--build-arg CONAN_IMAGE_VERSION=$(CONAN_IMAGE_VERSION) \
	--tag $(IMAGE) .

.PHONY: clean
.ONESHELL: clean
clean:
	rm -rf $(BUILD_DIR_PREFIX)*
	# rm -rf $(SOURCE_DIR)

.PHONY: docker-run
.ONESHELL: docker-run
docker-run: docker-build
	docker run --interactive \
	--rm \
	--volume $(CONAN_CACHE_VOLUME):/home/conan/.conan \
	--volume $(PWD):$(WORKDIR) \
	--workdir $(WORKDIR) \
	--name $(CONTAINER_NAME) \
	$(IMAGE) \
	make \
	BUILD_DIR=$(BUILD_DIR) \
	SOURCE_DIR=$(SOURCE_DIR) \
	OS=$(OS) \
	BUILD_TYPE=$(BUILD_TYPE) \
	ARCH=$(ARCH) \
	build
