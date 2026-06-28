TPL_PATH="${PWD}/templates"

.PHONY: update
update:
	if ! test -f ./bin/liveboat ; \
	then \
		mkdir -p ./bin; \
		wget -O ./bin/liveboat-linux-musl https://github.com/exaroth/liveboat/releases/download/v1.1.8/liveboat-linux-musl; \
		wget -O ./bin/liveboat-linux-musl.sha256sum https://github.com/exaroth/liveboat/releases/download/v1.1.8/liveboat-linux-musl.sha256sum; \
		EXPECTED=$$(awk '{print $$1}' ./bin/liveboat-linux-musl.sha256sum); \
		ACTUAL=$$(sha256sum ./bin/liveboat-linux-musl | awk '{print $$1}'); \
		[ "$$EXPECTED" = "$$ACTUAL" ] || { echo "Checksum mismatch!"; exit 1; }; \
		mv ./bin/liveboat-linux-musl ./bin/liveboat; \
		chmod +x ./bin/liveboat; \
	fi;
	LIVEBOAT_TEMPLATE_DIR="$(TPL_PATH)" ./bin/liveboat -x update --config-file=./config/liveboat-config.toml
