BUILDSCRIPT=./build.sh
commands=build/all build/firefox build/chromium run/firefox run/chromium clean lint

.PHONY: $(commands)
$(commands):
	$(BUILDSCRIPT) $@

.PHONY: set_version
set_version:
	@read -p "Enter version string (e.g. 1.0.0): " version; \
	$(BUILDSCRIPT) set_version $$version

