os					=	${shell uname -s}
CC					=	clang
RM					=	rm -rf
DEFINES				=	-D BUFFER_SIZE=65535
CFLAGS				=	-std=c99 $(DEFINES)

DIR					=	$(shell echo $(PWD))
PROGRAM				=	cub3d
LIB_DIR				=	lib
SRC_DIR				=	src
OBJ_DIR				=	.objs
BIN_DIR				=	.bin
NAME				=	$(BIN_DIR)/$(PROGRAM)
# CMD_DIR			=	cmd
# INC_DIR			=	-I $(SRC_DIR)/incs

program_dir			=	$(SRC_DIR)

#lib paths######################################################################
ifeq "$(os)" "Darwin"
# minilibx_D			=	$(LIB_DIR)/minilibx_mms_20200219/
# minilibx_A			=	$(minilibx_D)/libmlx.dylib

minilibx_D			=	$(LIB_DIR)/minilibx_opengl_20191021/
minilibx_A			=	$(minilibx_D)/libmlx.a
minilibx_flags		=	-lm -framework OpenGL -framework AppKit

else ifeq ($(os),Linux)
minilibx_D			=	$(LIB_DIR)/minilibx-linux
minilibx_A			=	$(minilibx_D)/libmlx.a
minilibx_flags		=	-lXext -lX11 -lm
endif

libft_D				=	$(LIB_DIR)/libft/
murmur_eval_D		=	$(LIB_DIR)/murmur-eval/murmur_eval

################################################################################

#lib paths######################################################################
# readline_L		=	-L $(LIB_DIR)/readline/lib/readline/lib -lreadline $(ltinfo)
# minilibx-linux_L	=	-L $(LIB_DIR)/minilibx-linux -lmlx

minilibx_L			=	-L $(minilibx_D) -lmlx $(minilibx_flags)
libft_L				=	-L $(libft_D) -lft
murmur_eval_L		=	-L $(murmur_eval_D)/build -lmurmureval
################################################################################

#inc paths######################################################################
# readline_I		=	-I $(LIB_DIR)/readline/lib/readline/include
# minilibx-linux_I	=	-I $(LIB_DIR)/minilibx-linux/
minilibx_I			=	-I $(minilibx_D)
lava_caster_I		=	-I $(program_dir)/inc/
libft_I				=	-I $(libft_D)
murmur_eval_I		=	-I $(murmur_eval_D)/incs/

# murmur_test_I		=	-I $(LIB_DIR)/murmurtest/incs/
################################################################################

# readline_A		=	$(LIB_DIR)/readline/lib/libreadline.a
# minilibx-linux_A	=	$(LIB_DIR)/minilibx-linux/libmlx.a

murmur_eval_A		=	$(murmur_eval_D)/build/libmurmureval.a
libft_A				=	$(libft_D)/libft.a

libr				=	$(minilibx_L) \
						$(libft_L) \
						$(murmur_eval_L)


incs				=	$(lava_caster_I) \
						$(libft_I) \
						$(minilibx_I) \
						$(murmur_eval_I)

CFLAGS				+=	$(incs)

SRCS				=	$(SRC_DIR)/init.c \
						$(SRC_DIR)/hook_destroy.c \
						$(SRC_DIR)/hook_move.c \
						$(SRC_DIR)/hook_rotate.c \
						$(SRC_DIR)/hook.c \
						$(SRC_DIR)/init_cub_map.c \
						$(SRC_DIR)/init_cub_map1.c \
						$(SRC_DIR)/init_cub_meta.c \
						$(SRC_DIR)/init_cub.c \
						$(SRC_DIR)/init_cub1.c \
						$(SRC_DIR)/init_mlx.c \
						$(SRC_DIR)/render.c \
						$(SRC_DIR)/render1.c \
						$(SRC_DIR)/utils1.c \
						$(SRC_DIR)/utils2.c \
						$(SRC_DIR)/utils3.c \


TEST_SRCS			=	test/tests_1.c
TEST_OBJS			=	$(TEST_SRCS:.c=.o)

OBJS				=	$(SRCS:.c=.o)

CMD					=	$(SRC_DIR)/mains/cub3d.c
CMD_OBJS			=	$(CMD:.c=.o)
# CMD				=	$(PROGRAM).c

DEPENDENCIES_A		=	$(minilibx_A) $(libft_A) $(murmur_eval_A)
DEPENDENCIES		=	murmur_eval minilibx libft

j = 0
ifeq '$(os)' 'Darwin'
NPROCS = $(shell sysctl -n hw.ncpu)
else ifeq '$(os)' 'Linux'
NPROCS = $(shell nproc)
endif

ifeq '$(j)' '1'
MAKEFLAGS += -j$(NPROCS)
endif

w = 1
ifeq '$(w)' '1'
CFLAGS += -Wextra -Werror -Wall -Wvla
endif

debug = 1
ifeq '$(debug)' '1'
CFLAGS += -g
endif

asan = 1
ifeq '$(asan)' '1'
LFLAGS += -fsanitize=address
endif

tsan = 0
ifeq '$(tsan)' '1'
LFLAGS += -fsanitize=thread
endif

leak =
msl = 0
ifeq '$(msl)' '1'
leak=MallocStackLogging=1
endif

test = 0
ifeq '$(test)' '1'
CFLAGS += -D TEST=$(test)
endif

all: $(DEPENDENCIES)
# @mkdir -p $(OBJ_DIR)
	@$(MAKE) $(NAME)
# mv *.o $(OBJ_DIR)/

murmur_eval:
	$(MAKE) -C $(murmur_eval_D)

minilibx:
	$(MAKE) -j1 -C $(minilibx_D)

libft:
	$(MAKE) -C $(LIB_DIR)/libft/ bonus


# b: bonus

m: mandatory

mandatory: all

# $(READLINE):
# 	@curl -O https://ftp.gnu.org/gnu/readline/readline-8.2-rc1.tar.gz
# 	@tar -xvf readline-8.2-rc1.tar.gz
# 	@$(RM) readline-8.2-rc1.tar.gz
# 	@cd readline-8.2-rc1 && ./configure --prefix=$(DIR)/lib/readline && make && make install
# 	@$(RM) readline-8.2-rc1

# $(lrl):
# 	$(MAKE) -C lib -j$(NPROCS) DIR=$(PWD)/lib


$(NAME): $(CMD_OBJS) $(OBJS) $(DEPENDENCIES_A)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CMD_OBJS) $(OBJS) $(libr) $(LFLAGS) -o $(NAME)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
	@# @mv $@ $(OBJ_DIR)/

run: all
	@echo "===================================program======================================\n"
	DYLD_LIBRARY_PATH=$(minilibx_D) $(leak) ./$(NAME) mapz/$(map).cub

clean:
	$(RM) $(OBJS) $(CMD_OBJS)
# $(MAKE) -C $(minilibx_D) clean
# $(MAKE) -C $(libft_D) clean
# find . -name "*.o" -exec $(RM) '{}' \;
c: clean

fclean: clean
	$(RM) $(NAME)
	$(RM) $(DEPENDENCIES)

f: fclean

re: fclean
	$(MAKE) all

test: all
	# $(MAKE) clean
# @mkdir -p $(BIN_DIR)
# @$(CC) $(CFLAGS) $(INC_DIR) test/testing.c test/token_test.c test/dollar_test.c test/equal_primitive.c $(SRCS) -o bin/test
# @./bin/test

.PHONY: all clean fclean re run t f c run m b bonus mandatory





# INC	=%%%%

# UNAME = $(shell uname)
# CC	= gcc
# ifeq ($(UNAME),FreeBSD)
# 	CC = clang
# endif

# NAME		= libmlx.a
# NAME_UNAME	= libmlx_$(UNAME).a

# SRC	= mlx_init.c mlx_new_window.c mlx_pixel_put.c mlx_loop.c \
# 	mlx_mouse_hook.c mlx_key_hook.c mlx_expose_hook.c mlx_loop_hook.c \
# 	mlx_int_anti_resize_win.c mlx_int_do_nothing.c \
# 	mlx_int_wait_first_expose.c mlx_int_get_visual.c \
# 	mlx_flush_event.c mlx_string_put.c mlx_set_font.c \
# 	mlx_new_image.c mlx_get_data_addr.c \
# 	mlx_put_image_to_window.c mlx_get_color_value.c mlx_clear_window.c \
# 	mlx_xpm.c mlx_int_str_to_wordtab.c mlx_destroy_window.c \
# 	mlx_int_param_event.c mlx_int_set_win_event_mask.c mlx_hook.c \
# 	mlx_rgb.c mlx_destroy_image.c mlx_mouse.c mlx_screen_size.c \
# 	mlx_destroy_display.c

# OBJ_DIR = obj
# OBJ	= $(addprefix $(OBJ_DIR)/,$(SRC:%.c=%.o))
# CFLAGS	= -O3 -I$(INC)

# all	: $(NAME)

# $(OBJ_DIR)/%.o: %.c
# 	@mkdir -p $(OBJ_DIR)
# 	$(CC) $(CFLAGS) $(IFLAGS) -c $< -o $@

# $(NAME)	: $(OBJ)
# 	ar -r $(NAME) $(OBJ)
# 	ranlib $(NAME)
# 	cp $(NAME) $(NAME_UNAME)

# check: all
# 	@test/run_tests.sh

# show:
# 	@printf "NAME  		: $(NAME)\n"
# 	@printf "NAME_UNAME	: $(NAME_UNAME)\n"
# 	@printf "CC		: $(CC)\n"
# 	@printf "CFLAGS		: $(CFLAGS)\n"
# 	@printf "SRC		:\n	$(SRC)\n"
# 	@printf "OBJ		:\n	$(OBJ)\n"

# clean	:
# 	rm -rf $(OBJ_DIR)/ $(NAME) $(NAME_UNAME) *~ core *.core

# .PHONY: all check show clean