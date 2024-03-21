# var
MODULE  = $(notdir $(CURDIR))
module  = $(shell echo $(MODULE) | tr A-Z a-z)
OS      = $(shell uname -o|tr / _)
NOW     = $(shell date +%d%m%y)
REL     = $(shell git rev-parse --short=4 HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
CORES  ?= $(shell grep processor /proc/cpuinfo | wc -l)

WINHOST = 192.168.0.111

# dir
CWD   = $(CURDIR)
BIN   = $(CWD)/bin
INC   = $(CWD)/inc
SRC   = $(CWD)/src
TMP   = $(CWD)/tmp
REF   = $(CWD)/ref
GZ    = $(HOME)/gz
BUILD = $(CWD)/tmp/build

# tool
CURL = curl -L -o
CF   = clang-format

# src
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)
Y += $(wildcard src/*.lex) $(wildcard src/*.yacc)
F += lib/$(MODULE).ini $(wildcard lib/*.f*)
M += Makefile CMakeLists.txt $(wildcard cmake/*)

# cfg
CFLAGS += -I$(INC) -I$(TMP)

# all
.PHONY: all
all: bin/$(MODULE) $(F)
	$^

.PHONY: win
win: tmp/$(MODULE).exe tmp/$(MODULE).ini
	vncviewer $(WINHOST)

# format
format: tmp/format_c
tmp/format_c: $(C) $(H)
	$(CF) -style=file -i $? && touch $@

# rule
bin/$(MODULE): $(C) $(H) $(Y) $(M)
	rm -rf $(BUILD)
	cmake -DAPP=$(MODULE) -DCMAKE_TOOLCHAIN_FILE=Linux_ -S$(CWD) -B$(BUILD)
	cd $(BUILD) ; make -j$(CORES)
tmp/$(MODULE).exe: $(C) $(H) $(Y) $(M)
	rm -rf $(BUILD)
	cmake -DAPP=$(MODULE) -DCMAKE_TOOLCHAIN_FILE=Windows_ -S$(CWD) -B$(BUILD)
	cd $(BUILD) ; make -j$(CORES)
tmp/%: lib/%
	cp $< $@

# doc
doxy: .doxygen
	rm -rf docs ; doxygen $< 1>/dev/null

.PHONY: doc
doc: doc/Shlee_Qt_4_8.pdf

doc/Shlee_Qt_4_8.pdf:
	$(CURL) $@ http://cosmic-rays.ru/books61/Shlee_Qt_4_8.pdf

# install
.PHONY: install update gz ref
install: doc gz ref
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -yu `cat apt.txt`
ref:
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
