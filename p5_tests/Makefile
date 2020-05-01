TESTFILES := $(wildcard *.nega)
TESTS := $(TESTFILES:.nega=.test)

.PHONY: all

all: $(TESTS)

%.test:
	@rm -f $*.unparse $*.err $*.s $*.3ac
	@touch $*.unparse $*.err $*.s $*.3ac
	@echo "TEST $*"
	@../negac $*.nega -o $*.s; \
	PROG_EXIT_CODE=$$?;\
	if [ $$PROG_EXIT_CODE != 0 ]; then \
		echo "negac error:"; \
		cat $*.err; \
		exit 1; \
	fi; \
	as $*.s -o $*.o; \
	ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 \
	/usr/lib/x86_64-linux-gnu/crt1.o \
	/usr/lib/x86_64-linux-gnu/crti.o \
	-lc \
	$*.o \
	../stdnegatron.o \
	/usr/lib/x86_64-linux-gnu/crtn.o \
	-o $*.exe; \

clean:
	rm -f *.err *.o *.exe
