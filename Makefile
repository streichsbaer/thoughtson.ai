# Writing and building Thoughts on AI. Run `make help` for the list.
PY ?= python3.12
VENV := .venv
BIN := $(VENV)/bin
COOLDOWN_DAYS ?= 7

.PHONY: help install lock new serve build clean

help:
	@echo "make install          create .venv from the pinned, hashed requirements.txt"
	@echo "make new SLUG=my-post create docs/posts/<SLUG>.md as a draft"
	@echo "make serve            preview at http://127.0.0.1:8000, localhost only (drafts hidden; set draft: false locally to preview one)"
	@echo "make build            strict build into site/, as CI does"
	@echo "make lock             re-pin requirements.in, skipping releases newer than $(COOLDOWN_DAYS) days"

$(BIN)/zensical: requirements.txt
	$(PY) -m venv $(VENV)
	$(BIN)/pip install --quiet --require-hashes --no-deps -r requirements.txt
	@touch $@

install: $(BIN)/zensical

lock:
	uv pip compile requirements.in --python-version 3.12 --generate-hashes --universal \
		--exclude-newer $$($(PY) -c 'import datetime as d; print(d.date.today() - d.timedelta(days=$(COOLDOWN_DAYS)))') \
		-o requirements.txt

new:
	@test -n "$(SLUG)" || { echo "usage: make new SLUG=my-post"; exit 1; }
	@test ! -e docs/posts/$(SLUG).md || { echo "docs/posts/$(SLUG).md already exists"; exit 1; }
	@sed -e 's/{{SLUG}}/$(SLUG)/' -e "s/{{DATE}}/$$(date +%Y-%m-%d)/" templates/post.md > docs/posts/$(SLUG).md
	@echo "Created docs/posts/$(SLUG).md (draft). URL once published: https://www.thoughtson.ai/posts/$(SLUG)/"

serve: install
	$(BIN)/zensical serve -a 127.0.0.1:8000

build: install
	$(BIN)/zensical build --strict --clean
	! grep -rlE '<!-- *(TODO|VERIFY|LINK|SKILL|DRAFT)' site

clean:
	rm -rf site .cache
