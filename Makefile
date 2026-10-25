# Writing and building Thoughts on AI. Run `make help` for the list.
PY ?= python3.12
VENV := .venv
BIN := $(VENV)/bin
COOLDOWN_DAYS ?= 7

.PHONY: help install lock new serve build cards clean

help:
	@echo "make install          create .venv from the pinned, hashed requirements.txt"
	@echo "make new SLUG=my-post create docs/blog/posts/<SLUG>.md as a draft"
	@echo "make serve            preview at http://127.0.0.1:8000 (drafts included)"
	@echo "make build            strict build into site/, as CI does but without social cards"
	@echo "make cards            strict build with social cards (needs Cairo: brew install cairo)"
	@echo "make lock             re-pin requirements.in, skipping releases newer than $(COOLDOWN_DAYS) days"

$(BIN)/mkdocs: requirements.txt
	$(PY) -m venv $(VENV)
	$(BIN)/pip install --quiet --require-hashes --no-deps -r requirements.txt
	@touch $@

install: $(BIN)/mkdocs

lock:
	uv pip compile requirements.in --python-version 3.12 --generate-hashes --universal \
		--exclude-newer $$($(PY) -c 'import datetime as d; print(d.date.today() - d.timedelta(days=$(COOLDOWN_DAYS)))') \
		-o requirements.txt

new:
	@test -n "$(SLUG)" || { echo "usage: make new SLUG=my-post"; exit 1; }
	@test ! -e docs/blog/posts/$(SLUG).md || { echo "docs/blog/posts/$(SLUG).md already exists"; exit 1; }
	@sed -e 's/{{SLUG}}/$(SLUG)/' -e "s/{{DATE}}/$$(date +%Y-%m-%d)/" templates/post.md > docs/blog/posts/$(SLUG).md
	@echo "Created docs/blog/posts/$(SLUG).md (draft). URL once published: https://www.thoughtson.ai/blog/$(SLUG)/"

serve: install
	$(BIN)/mkdocs serve

build: install
	$(BIN)/mkdocs build --strict

cards: install
	CARDS=true $(BIN)/mkdocs build --strict

clean:
	rm -rf site .cache
