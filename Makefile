VERSION = $(shell git describe --abbrev=8 --dirty=.devel --always)

all:
	echo "$(VERSION)" >version
	zip -r operation-brass-drum-$(VERSION).miz Config l10n Scripts \
		license.txt mission options warehouses version

clean:
	rm version *.miz
