mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

IMAGE_NAME := adumont/$(current_dir)

all:
	docker build -t $(IMAGE_NAME) --no-cache=true .

clean:
	docker rmi $(IMAGE_NAME) || true
