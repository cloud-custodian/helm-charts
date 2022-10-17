ACT_VERSION = 0.2.32
BIN_DIR = ./.bin
ACT_PKG_PATH = $(BIN_DIR)/act.$(ACT_VERSION).tgz
ACT = $(BIN_DIR)/act

default: lint test verify-generated-code

$(BIN_DIR):
	mkdir $@

$(ACT_PKG_PATH): $(BIN_DIR)
	# --no-use-server-timestamps = make sure makefile understands not to download this again
	wget --output-document $@ \
		--no-use-server-timestamps \
		https://github.com/nektos/act/releases/download/v${ACT_VERSION}/act_Linux_x86_64.tar.gz
	touch $@

$(ACT): $(ACT_PKG_PATH)
	tar \
		--extract \
		--file $(ACT_PKG_PATH) \
		--directory $(BIN_DIR) \
		--touch \
		act

	# without this, make consistently redownloads $(ACT_PKG_PATH), no idea why.
	touch $(ACT_PKG_PATH)
	touch $@

.PHONY: lint
lint: $(ACT)
	$(ACT) --job lint

.PHONY: test
test: $(ACT)
	$(ACT) --job test

.PHONY: verify-generated-code
verify-generated-code: $(ACT)
	$(ACT) --job verify-generated-code
