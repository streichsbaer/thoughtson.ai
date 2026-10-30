# Writing and building Thoughts on AI. Run `make help` for the list.
PY ?= python3.12
VENV := .venv
BIN := $(VENV)/bin
COOLDOWN_DAYS ?= 7

.PHONY: help install lock new serve preview build clean

help:
	@echo "make install          create .venv from the pinned, hashed requirements.txt"
	@echo "make new SLUG=my-post create content/drafts/<SLUG>.md (content/ is private and never committed here)"
	@echo "make serve            preview the published site at http://127.0.0.1:8000, localhost only"
	@echo "make preview          preview with the drafts from content/drafts at http://127.0.0.1:8001"
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
	@test ! -e content/drafts/$(SLUG).md || { echo "content/drafts/$(SLUG).md already exists"; exit 1; }
	@mkdir -p content/drafts
	@sed -e 's/{{SLUG}}/$(SLUG)/' -e "s/{{DATE}}/$$(date +%Y-%m-%d)/" templates/post.md > content/drafts/$(SLUG).md
	@echo "Created content/drafts/$(SLUG).md. To publish: move it to docs/posts/, remove its editing notes, set draft: false."

serve: install
	$(BIN)/zensical serve -a 127.0.0.1:8000

# Drafts live in the private content/ folder. Preview them from a throwaway copy in .preview/.
preview: install
	rm -rf .preview && mkdir .preview
	rsync -a --exclude .git --exclude .venv --exclude .preview --exclude site --exclude .cache --exclude content ./ .preview/
	cp content/drafts/*.md .preview/docs/posts/
	sed -i.bak 's/^draft: true/draft: false/' .preview/docs/posts/*.md && rm .preview/docs/posts/*.bak
	cd .preview && ../$(BIN)/zensical serve -a 127.0.0.1:8001

build: install
	$(BIN)/zensical build --strict --clean
	! grep -rlE '<!-- *(TODO|VERIFY|LINK|SKILL|DRAFT)' site

clean:
	rm -rf site .cache .preview
