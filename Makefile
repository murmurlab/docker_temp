os					=	${shell uname -s}
RM					=	rm -rf
# DOCKER				=	sudo docker

DIR					=	$(shell echo $(PWD))
SRC_DIR				=	srcs

#lib paths######################################################################
ifeq "$(os)" "Darwin"

else ifeq ($(os),Linux)

endif
################################################################################

asan = 1
ifeq '$(asan)' '1'
LFLAGS += -fsanitize=address
endif

# $(SRC_DIR)/.env
all:
	@echo "===================================program======================================\n"
	@echo '======='"$$USER"'=======';\
	sudo mkdir -p /home/$$USER/data/wp;\
	sudo mkdir -p /home/$$USER/data/db
	$(MAKE) up

up:
	docker-compose -f srcs/docker-compose.yml up

down:
	docker-compose -f srcs/docker-compose.yml down

fclean: down
	sudo docker system prune -af
	(\
		docker stop `docker ps -qa`;\
		docker rm `docker ps -qa`;\
		docker rmi -f `docker images -qa`;\
		docker volume rm `docker volume ls -q`;\
		docker network rm `docker network ls -q`\
	) 2>/dev/null;\
	sudo rm -rf /home/$$USER/data;

re: fclean
	$(MAKE) all

.PHONY: all clean fclean re up down
