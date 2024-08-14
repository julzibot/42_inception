COMPOSE_FILE = ./srcs/docker-compose.yml

all:
	@mkdir -p /home/${USER}/data/wordpress/ /home/${USER}/data/mariadb/
	@docker-compose -f $(COMPOSE_FILE)

build:
	@mkdir -p ~data/wordpress/ ~/data/mariadb/
	@docker-compose -f $(COMPOSE_FILE) --build

down:
	@docker-compose -f $(COMPOSE_FILE) down

stop:
	-docker stop $$(docker ps -qa)

re: down fclean build

clean: down
	@docker system prune -a
	@docker volume rm $(shell docker volume ls -q)
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

fclean: stop down
	-docker rm $$(docker ps -qa)
	-docker rmi -f $$(docker images -qa)
	-docker volume rm $$(docker volume ls -q)
	-docker network rm $$(docker network ls -q) 2>/dev/null
	@sudo rm -rf ~/data/wordpress
	@sudo rm -rf ~/data/mariadb

.PHONY: all build down stop re clean fclean