OBJECT_FILES = \
	board.o \
	book.o \
	data.o \
	eval.o \
	main.o \
	search.o

all: tscp1

tscp1: $(OBJECT_FILES)
	g++ -O3 -o tscp1 $(OBJECT_FILES)

%.o: %.c data.h defs.h protos.h
	g++ -O3 -x c -c $< -o $@

clean:
	rm -f *.o
	rm -f tscp1
