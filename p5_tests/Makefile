TESTFILES := $(wildcard *.nega)
TESTS := $(TESTFILES:.nega=.test)

.PHONY: all

all: $(TESTS)

%.test:
	@rm -f $*.unparse $*.err $*.out
	@touch $*.unparse $*.err $*.out
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

	@../negac $*.nega -a $*.out 2> $*.out
	diff -B --ignore-all-space $*.out $*.out.expected
clean:
	rm -f *.err *.out
