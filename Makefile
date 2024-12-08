all: build push

IMG ?= uhziel/gohttpbin

.PHONY: build
build:
	docker build -t ${IMG} .

.PHONY: push
push:
	docker push ${IMG}
