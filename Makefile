BUILDSCRIPT=./build.sh
commands=all firefox chromium clean

.PHONY: $(commands)
$(commands):
	$(BUILDSCRIPT) $@
