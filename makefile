LEXER_TOOL := flex
CXX ?= g++ # Set the C++ compiler to g++ iff it hasn't already been set
CPP_SRCS := $(wildcard *.cpp)
OBJ_SRCS := parser.o lexer.o $(CPP_SRCS:.cpp=.o)
DEPS := $(OBJ_SRCS:.o=.d)
FLAGS=-pedantic -Wall -Wextra -Wcast-align -Wcast-qual -Wctor-dtor-privacy -Wdisabled-optimization -Wformat=2 -Wuninitialized -Winit-self -Wmissing-declarations -Wmissing-include-dirs -Wold-style-cast -Woverloaded-virtual -Wredundant-decls -Wsign-conversion -Wsign-promo -Wstrict-overflow=5 -Wundef -Werror -Wno-unused -Wno-unused-parameter


.PHONY: all clean test cleantest

all: clean negac stdnegatron.o test

clean: cleantest
	rm -rf *.output *.o *.cc *.hh $(DEPS) negac parser.dot parser.png

-include $(DEPS)

negac: $(OBJ_SRCS)
	$(CXX) $(FLAGS) -g -std=c++14 -o $@ $(OBJ_SRCS)

stdnegatron.o: stdnegatron.c
	gcc -o stdnegatron.o -c stdnegatron.c

%.o: %.cpp
	$(CXX) $(FLAGS) -g -std=c++14 -MMD -MP -c -o $@ $<

parser.o: parser.cc
	$(CXX) $(FLAGS) -Wno-sign-compare -Wno-sign-conversion -Wno-switch-default -g -std=c++14 -MMD -MP -c -o $@ $<

parser.cc: negatron.yy
	bison --graph=parser.dot --defines=grammar.hh -v $<

lexer.yy.cc: negatron.l
	$(LEXER_TOOL) --outfile=lexer.yy.cc $<

lexer.o: lexer.yy.cc
	$(CXX) $(FLAGS) -Wno-sign-compare -Wno-sign-conversion -Wno-old-style-cast -Wno-switch-default -g -std=c++14 -c lexer.yy.cc -o lexer.o

test: p5

p5: all
	$(MAKE) -C p5_tests/
	
cleantest:
	$(MAKE) -C p5_tests/ clean
