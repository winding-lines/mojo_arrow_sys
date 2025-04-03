# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -fPIC
PYTHON ?= python3
UV ?= uv
PYTHON_INCLUDES = $(shell $(UV) run $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('include'))")
SYSTEM_INCLUDES = $(shell $(UV) run $(PYTHON) -c "import sysconfig; print(sysconfig.get_config_var('INCLUDEPY'))")

# Platform detection
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	SHARED_EXT = so
else ifeq ($(UNAME_S),Darwin)
	SHARED_EXT = dylib
else
	$(error Unsupported platform: $(UNAME_S))
endif

# Targets
.PHONY: all clean build install test

all: build

build:
	$(UV) run $(PYTHON) setup.py build_ext --inplace

install:
	$(UV) run $(PYTHON) setup.py install

test: build
	$(UV) run $(PYTHON) -m pytest tests/

clean:
	rm -rf build/
	rm -f mojo_arrow_sys/*.so mojo_arrow_sys/*.dylib
	rm -f *.egg-info
