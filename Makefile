.POSIX:

CC = clang-5.0 -mcx16
CFLAGS = -g -O3 -std=gnu11 -Iinclude -Isrc -Wall -Wextra -Wpedantic $(FLAGS)
LDFLAGS = -latomic -lpthread ./libmuco.a
OBJECTS = src/muco.o src/lock.o src/channel.o

all: libmuco.a

libmuco.a: $(OBJECTS)
	$(AR) -cr libmuco.a $(OBJECTS)

main: samples/main.o libmuco.a
	$(CC) samples/main.o -o main $(LDFLAGS)

switch: samples/switch.o libmuco.a
	$(CC) samples/switch.o -o switch $(LDFLAGS)

mutex: samples/mutex.o libmuco.a
	$(CC) samples/mutex.o -o mutex $(LDFLAGS)

channel: samples/channel.o libmuco.a
	$(CC) samples/channel.o -o channel $(LDFLAGS)

clean: .phony
	rm -f libmuco.a src/*.o samples/*.o main switch mutex channel

.phony:
