BUILDDIR=web-ext-artifacts

name=startpagina
ignore=Makefile README.md manifest_*.json

.PHONY: all
all:
	./build.sh all $(BUILDDIR)

.PHONY: firefox
firefox:
	./build.sh firefox $(BUILDDIR)

.PHONY: chromium
chromium:
	./build.sh chromium $(BUILDDIR)

.PHONY: clean
clean:
	./build.sh clean $(BUILDDIR)
