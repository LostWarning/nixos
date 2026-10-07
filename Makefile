.PHONY: all json installed clean serve help

DOCS_DIR ?= docs
OPTIONS_JSON ?= $(DOCS_DIR)/options.json
INSTALLED_JSON ?= $(DOCS_DIR)/installed.json
OPTIONS_EXPR ?= docs/options.nix
INSTALLED_EXPR ?= docs/installed.nix
PORT ?= 8000

all: $(OPTIONS_JSON) $(INSTALLED_JSON)

$(OPTIONS_JSON): $(OPTIONS_EXPR)
	@mkdir -p $(DOCS_DIR)
	@echo "Evaluating Metronome options schema..."
	@out=$$(nix build --impure --file $(OPTIONS_EXPR) --no-link --print-out-paths) && \
	cp -f "$$out" $(OPTIONS_JSON) && \
	chmod 644 $(OPTIONS_JSON)
	@echo "✓ Generated $(OPTIONS_JSON) ($$(jq '.meta.total' $(OPTIONS_JSON)) options)"

$(INSTALLED_JSON): $(INSTALLED_EXPR)
	@mkdir -p $(DOCS_DIR)
	@echo "Evaluating active configurations and installed packages..."
	@out=$$(nix build --impure --file $(INSTALLED_EXPR) --no-link --print-out-paths) && \
	cp -f "$$out" $(INSTALLED_JSON) && \
	chmod 644 $(INSTALLED_JSON)
	@echo "✓ Generated $(INSTALLED_JSON) ($$(jq '.hosts | keys | length' $(INSTALLED_JSON)) hosts)"

json: $(OPTIONS_JSON)

installed: $(INSTALLED_JSON)

serve: all
	@echo "Serving Metronome Documentation & Dashboard on http://localhost:$(PORT)..."
	@nix run nixpkgs#python3 -- -m http.server $(PORT) --directory $(DOCS_DIR)

clean:
	rm -f $(OPTIONS_JSON) $(INSTALLED_JSON) options.json installed.json result

help:
	@echo "Metronome Documentation & Inspection Generator"
	@echo "  make            - Generate $(OPTIONS_JSON) and $(INSTALLED_JSON)"
	@echo "  make json       - Generate options schema ($(OPTIONS_JSON))"
	@echo "  make installed  - Generate active system state ($(INSTALLED_JSON))"
	@echo "  make serve      - Serve $(DOCS_DIR)/ on http://localhost:$(PORT)"
	@echo "  make clean      - Clean generated JSON files"
