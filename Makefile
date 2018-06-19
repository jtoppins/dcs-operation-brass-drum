VERSION = $(shell git describe --abbrev=8 --dirty=.devel)

all:
	zip -r operation-brass-drum-$(VERSION).miz Config l10n Scripts \
	   	license.txt mission options warehouses
