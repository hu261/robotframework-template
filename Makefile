#          Makefile for my projects
#
# ----------------------------------------------------------------------------

ifndef SILENCE
	SILENCE = @
endif

define HELP

 makefile help
 -------------

 Please use `make <target>' where <target> is one of:

  clean            delete all build files
  unit-test        run unit tests
  acceptance-test  run story acceptance tests. By default, all tests are launched
                     TAGS variable only runs the tests containing these tags
                     NOTAGS variable does not run the tests containing these tags
                     ex: 'make TAGS=SPRINT3 NOTAGS=MANUAL acceptance-test'
  clean-test       clean test environment (kill existing processes)
  
endef
export HELP

PRODUCT_NAME = My product name
GIT_HASH = $(shell git log -1 --format=%h)
GIT_STATUS = $(shell git status -uno --porcelain 2> /dev/null)
ifeq ($(strip $(GIT_STATUS)),)
	IS_DIRTY = 
else
	IS_DIRTY = *
endif

# Directories definition
ROOT_DIR = ./
SCRIPTS_DIR = $(ROOT_DIR)/scripts
TESTS_DIR = $(ROOT_DIR)/tests
TESTS_RESSOURCES_DIR = $(TESTS_DIR)/resources
TESTS_LOGS_DIR = $(TESTS_DIR)/logs

TARGET = localhost

# ----------------------------------------------------------------------------
#
# Build related tasks

.PHONY: help clean clean-obj

# keep this rule first
help:
	@echo "$$HELP"

clean: clean-obj clean-log

clean-log:
	@echo "Cleaning logs..."
	$(SILENCE)find -name \*.log -exec rm {} \;
	$(SILENCE)rm -rf $(TESTS_LOGS_DIR)/*
# ----------------------------------------------------------------------------
#
# Testing related tasks

.PHONY: test unit-test acceptance-test clean-test manual-test

test: clean-test unit-test story-test

unit-test: 
	@echo "Unit testing..."
	@echo "Put your command here"
	@echo "Done."

TEST_TITLE = $(PRODUCT_NAME) ($(GIT_HASH)${IS_DIRTY}) Acceptance Test

ACCEPTANCE_TEST_ARGS += -v TARGET:$(TARGET)

ACCEPTANCE_TEST_ARGS += -d $(TESTS_LOGS_DIR) --reporttitle '$(TEST_TITLE) Report' \
				--logtitle '$(TEST_TITLE) Log'
TAGS =

ifneq ($(TAGS),)
	ACCEPTANCE_TEST_ARGS += --include $(TAGS)
endif

NOTAGS =

ifneq ($(NOTAGS),)
	ACCEPTANCE_TEST_ARGS += --exclude $(NOTAGS)
endif

TEST =

ifneq ($(TEST),)
	ACCEPTANCE_TEST_ARGS += -t $(TEST)
endif

acceptance-test: clean-test
	@echo "Acceptance testing..."
	$(SILENCE)PYTHONPATH=. python $(SCRIPTS_DIR)/run_acceptancetest.py $(ACCEPTANCE_TEST_ARGS) $(TESTS_DIR)

clean-test:
	@echo "Cleaning test environment..."
	$(SILENCE)$(SCRIPTS_DIR)/kill.sh pybot

manual-test:
	@echo "Acceptance testing..."
	make TAGS=MANUAL acceptance-test
	
