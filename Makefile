os					=	${shell uname -s}
RM					=	rm -rf

DIR					=	$(shell echo $(PWD))
PROGRAM				=	cub3d
SRC_DIR				=	srcs
NAME				=	$(BIN_DIR)/$(PROGRAM)

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
	@$(MAKE) $(NAME)

# $(READLINE):
# 	@curl -O https://ftp.gnu.org/gnu/readline/readline-8.2-rc1.tar.gz
# 	@tar -xvf readline-8.2-rc1.tar.gz
# 	@$(RM) readline-8.2-rc1.tar.gz
# 	@cd readline-8.2-rc1 && ./configure --prefix=$(DIR)/lib/readline && make && make install
# 	@$(RM) readline-8.2-rc1

# $(lrl):
# 	$(MAKE) -C lib -j$(NPROCS) DIR=$(PWD)/lib


$(NAME):
	mkdir -p /home/ahbasara/data/wp
	mkdir -p /home/ahbasara/data/db
	$(MAKE) up
up:
	docker-compose -f srcs/docker-compose.yml up
force:
	docker-compose -f srcs/docker-compose.yml up --force-recreate --build

run: all
	@echo "===================================program======================================\n"

clean-con:
	@if [[ `docker ps -aq` ]]; then  docker ps -aq | xargs docker stop; else echo "already clean"; fi
	@if [[ `docker ps -aq` ]]; then  docker ps -aq | xargs docker rm; else echo "already clean"; fi
clean-img:
	@if [[ `docker images -aq` ]]; then docker images -aq | xargs docker rmi; else echo "already clean"; fi
down:
	docker-compose -f srcs/docker-compose.yml down

fclean: clean-con clean-img

re: fclean
	rm -rf /home/ahbasara/data/db/mariadbd/
	$(MAKE) force
	# $(MAKE) all

# @mkdir -p $(BIN_DIR)
# @$(CC) $(CFLAGS) $(INC_DIR) test/testing.c test/token_test.c test/dollar_test.c test/equal_primitive.c $(SRCS) -o bin/test
# @./bin/test

.PHONY: all clean fclean re run t f c run m b bonus mandatory
