REPO_NAME=ectools
TMP_CONTAINTER=build-ectools

export REPO_NAME
export TMP_CONTAINER

all: builds

builds: create-container
	docker container cp build-ectools:/opt/ectools/build/ .
	docker container cp build-ectools:/opt/ectools/dist/ .

create-container: build-docker
	docker container create --name build-ectools ectools:latest

build-docker:
	docker build --build-arg REPO_NAME=ectools --build-arg UID=1000 -t ectools:latest .

clean: clean-container
	rm -r dist/
	rm -r build/

clean-container:
	docker container rm build-ectools || true
