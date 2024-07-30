os					=	${shell uname -s}
RM					=	rm -rf

DIR					=	$(shell echo $(PWD))
PROGRAM				=	cub3d
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


all:
	@echo "===================================program======================================\n"
	mkdir -p /home/ahbasara/data/wp
	mkdir -p /home/ahbasara/data/db
	$(MAKE) up

up:
	docker-compose -f srcs/docker-compose.yml up

down:
	docker-compose -f srcs/docker-compose.yml down

fclean: down
	docker stop $(docker ps -qa);
	docker rm $(docker ps -qa);
	docker rmi -f $(docker images -qa);
	docker volume rm $(docker volume ls -q);
	docker network rm $(docker network ls -q) 2>/dev/null
	rm -rf /home/ahbasara/data

re: fclean
	$(MAKE) all

.PHONY: all clean fclean re up down
