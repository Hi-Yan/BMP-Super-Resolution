# Make File for Yeonji Image Super Resolution

CC:=gcc
# CFLAGS:=-g -O2 -Wall -Wextra -Werror

CFLAGS=-O2 -Wall -Wextra -ffunction-sections -fdata-sections
LDFLAGS:=
MKDIR:=mkdir -p

INCLUDE:=src
CFLAGS+= -I${INCLUDE}

SRCDIR:=src

all:bin/image_quarter bin/image_precision bin/image_2x

.PHONY:clean

clean:
	@rm -rvf obj/*
	@rm -rvf bin/*

bin/image_quarter:obj/bmp.o obj/ppm.o obj/image_io.o obj/image.o \
					obj/image_quarter.o
	${CC} ${CFLAGS} $^ -o $@

bin/image_precision:obj/bmp.o obj/ppm.o obj/image_io.o obj/image.o \
					obj/image_precision.o
	${CC} ${CFLAGS} $^ -o $@

bin/image_2x:obj/bmp.o \
				obj/ppm.o \
				obj/image_io.o \
				obj/image.o \
				obj/image_2x.o \
				obj/image_plane.o \
				obj/image_border.o \
				obj/models.o \
				obj/vgg7yuv.o \
				obj/opencl.o \
				obj/conv2d.o \
				obj/relu.o \
				obj/cnn.o \
				obj/clprogram.o \
				obj/isr_main.o
	${CC} ${CFLAGS} $^ -o $@ -framework OpenCL

obj/bmp.o:src/contrib/image/bmp.c
	${CC} -c ${CFLAGS} $< -o $@

obj/ppm.o:src/contrib/image/ppm.c
	${CC} -c ${CFLAGS} $< -o $@

obj/image_io.o:src/contrib/image/image_io.c
	${CC} -c ${CFLAGS} $< -o $@

obj/image.o:src/contrib/image/image.c
	${CC} -c ${CFLAGS} $< -o $@

obj/isr_main.o:src/core/main.c
	${CC} -c ${CFLAGS} $< -o $@

obj/image_2x.o:src/core/image_2x.c
	${CC} -c ${CFLAGS} $< -o $@

obj/image_border.o:src/core/image_border.c
	${CC} -c ${CFLAGS} $< -o $@

obj/image_plane.o:src/core/image_plane.c
	${CC} -c ${CFLAGS} $< -o $@

obj/models.o:src/models/models.c
	${CC} -c ${CFLAGS} $< -o $@

obj/vgg7yuv.o:src/models/vgg7yuv.c
	${CC} -c ${CFLAGS} $< -o $@

obj/opencl.o:src/contrib/compute/opencl.c
	${CC} -c ${CFLAGS} $< -o $@

obj/conv2d.o:src/contrib/compute/conv2d.c
	${CC} -c ${CFLAGS} $< -o $@

obj/relu.o:src/contrib/compute/relu.c
	${CC} -c ${CFLAGS} $< -o $@

obj/cnn.o:src/contrib/compute/cnn.c
	${CC} -c ${CFLAGS} $< -o $@

obj/clprogram.o:obj/clprogram.c
	${CC} -c ${CFLAGS} $< -o $@

obj/clprogram.c:src/contrib/compute/clprogram.cl
	@echo "#include <stdlib.h>" > obj/clprogram.c
	xxd --include src/contrib/compute/clprogram.cl | \
	sed 's/0x2a, 0x2f/0x2a, 0x2f, 0x0a, 0x00/g' | \
	sed 's/src_contrib_compute_clprogram_cl/opencl_program_str/g' | \
	sed 's/unsigned int/size_t/g' \
	>> obj/clprogram.c

obj/image_quarter.o:src/utils/image_quarter.c
	${CC} -c ${CFLAGS} $< -o $@

obj/image_precision.o:src/utils/image_precision.c
	${CC} -c ${CFLAGS} $< -o $@
