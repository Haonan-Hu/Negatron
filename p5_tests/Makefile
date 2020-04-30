TESTFILES := $(wildcard *.nega)
TESTS := $(TESTFILES:.nega=.test)

.PHONY: all

all: $(TESTS)

%.test:
	@rm -f $*.unparse $*.err $*.out $*.3ac
	@touch $*.unparse $*.err $*.out $*.3ac
	@echo "TEST $*"
	@../negac $*.nega -c 2> $*.err; \
	PROG_EXIT_CODE=$$?;\
	if [ $$PROG_EXIT_CODE != 0 ]; then \
		echo "negac error:"; \
		cat $*.err; \
		exit 1; \
	fi; \
	STDERR_DIFF_EXIT=$$?;\
	exit $$STDERR_DIFF_EXIT

	@../negac $*.nega -a $*.3ac 2> $*.3ac #run 3ac
	@../negac $*.nega -o $*.out 2> prog.s # run asm
	diff -B --ignore-all-space $*.out $*.out.expected
clean:
	rm -f *.err *.out
