IMAGE_NAME=adumont/plex

all:
	docker build -t $(IMAGE_NAME) .

clean:
	docker rmi $(IMAGE_NAME) || true
