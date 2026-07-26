IGNORE = ./ignore
IMAGE_NAME = "unix-simh"

.PHONY: run
run: $(IGNORE)/image.stamp
	docker run -it $(IMAGE_NAME)

$(IGNORE)/image.stamp: Dockerfile $(IGNORE)
	docker build . --tag $(IMAGE_NAME)
	touch $(IGNORE)/image.stamp

$(IGNORE):
	mkdir $(IGNORE)
