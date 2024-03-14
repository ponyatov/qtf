# var
MODULE  = $(notdir $(CURDIR))
module  = $(shell echo $(MODULE) | tr A-Z a-z)
NOW     = $(shell date +%d%m%y)
REL     = $(shell git rev-parse --short=4 HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
CORES  ?= $(shell grep processor /proc/cpuinfo | wc -l)

# dir
CWD  = $(CURDIR)
BIN  = $(CWD)/bin
INC  = $(CWD)/inc
SRC  = $(CWD)/src
TMP  = $(CWD)/tmp
REF  = $(CWD)/ref
GZ   = $(HOME)/gz

# tool
CURL = curl -L -o
CF   = clang-format

# src
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)

# cfg
CFLAGS += -I$(INC) -I$(TMP)

# all
.PHONY: all
all: bin/$(MODULE) lib/$(MODULE).ini
	$^

# format
format: tmp/format_c
tmp/format_c: $(C) $(H)
	$(CF) -style=file -i $? && touch $@

# rule
bin/$(MODULE): $(C) $(H) tmp/CMakeCache.txt
	cmake --build tmp
tmp/CMakeCache.txt: $(CWD)/CMakeLists.txt
	cd tmp ; cmake -DAPP=$(MODULE) $<

# doc
doxy: .doxygen
	rm -rf docs ; doxygen $< 1>/dev/null

.PHONY: doc
doc:

# install
.PHONY: install update gz ref
install: doc gz
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -yu `cat apt.txt`
gz:

# merge
MERGE += Makefile README.md apt.txt LICENSE
MERGE += .clang-format .doxygen .gitignore
MERGE += .vscode bin doc lib inc src tmp ref

.PHONY: dev
dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)

.PHONY: shadow
shadow:
	git push -v
	git checkout $@
	git pull -v

.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v --tags
	$(MAKE) shadow

.PHONY: zip
zip:
	git archive \
		--format zip \
		--output $(TMP)/$(MODULE)_$(NOW)_$(REL).src.zip \
	HEAD
