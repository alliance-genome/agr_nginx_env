REG := 100225593120.dkr.ecr.us-east-1.amazonaws.com
TAG := latest

registry-docker-login:
ifneq ($(shell echo ${REG} | egrep "ecr\..+\.amazonaws\.com"),)
	@$(eval DOCKER_LOGIN_CMD=aws)
ifneq (${AWS_PROFILE},)
	@$(eval DOCKER_LOGIN_CMD=${DOCKER_LOGIN_CMD} --profile ${AWS_PROFILE})
endif
	@$(eval DOCKER_LOGIN_CMD=${DOCKER_LOGIN_CMD} ecr get-login-password | docker login -u AWS --password-stdin https://${REG})
	${DOCKER_LOGIN_CMD}
endif

all:
	docker build -t ${REG}/agr_nginx_env:${TAG} -f Dockerfile_production .

push: registry-docker-login
	docker push ${REG}/agr_nginx_env:${TAG}

pull: registry-docker-login
	docker pull ${REG}/agr_nginx_env:${TAG}

bash:
	docker run -t -i ${REG}/agr_nginx_env:${TAG} bash


prod:
	docker build -t ${REG}/agr_nginx_prod:${TAG} -f Dockerfile_prod .

prod-push: registry-docker-login
	docker push ${REG}/agr_nginx_prod:${TAG}

prod-pull: registry-docker-login
	docker pull ${REG}/agr_nginx_prod:${TAG}

prod-bash:
	docker run -t -i ${REG}/agr_nginx_prod:${TAG} bash

build:
	docker build -t ${REG}/agr_nginx_prod:${TAG} -f Dockerfile_build .
