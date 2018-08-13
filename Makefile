all:
	docker build -t agrdocker/agr_nginx_env:latest -f Dockerfile_production .

push:
	docker push agrdocker/agr_nginx_env:latest

pull:
	docker pull agrdocker/agr_nginx_env:latest

bash:
	docker run -t -i agrdocker/agr_nginx_env:latest bash


prod:
	docker build -t agrdocker/agr_nginx_prod:latest -f Dockerfile_prod .

prod-push:
	docker push agrdocker/agr_nginx_prod:latest

prod-pull:
	docker pull agrdocker/agr_nginx_prod:latest

prod-bash:
	docker run -t -i agrdocker/agr_nginx_prod:latest bash

build:
	docker build -t agrdocker/agr_nginx_prod:latest -f Dockerfile_build .
