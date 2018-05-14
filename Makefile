NAME := nginx-builder

.PHONY: build clean
prepare-docker:
	docker build --force-rm -t $(NAME) .

nginx: prepare-docker
	docker run --rm -v $(CURDIR)/pkg:/tmp/pkg $(NAME) \
		cp -r /root/rpmbuild/RPMS/x86_64/ /tmp/pkg/

clean:
	docker ps -qa --filter ancestor=nginx-builder | \
		xargs docker stop | \
		xargs docker rm
	docker rmi $(NAME)
