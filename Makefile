BUILDSCRIPT=./build.sh
commands=all firefox chromium clean lint

.PHONY: $(commands)
$(commands):
	$(BUILDSCRIPT) $@

.PHONY: set_version
set_version:
	@read -p "Enter version string: " version; \
	$(BUILDSCRIPT) set_version $$version

