---
title: Securing a Blog That Has Nothing to Lose
# The slug fixes the URL: https://www.thoughtson.ai/posts/securing-a-static-blog/
# X threads and the Cysmiq blog copy link back to that URL, so never change it after publishing.
slug: securing-a-static-blog
description: Lab notes from restarting this blog. What a static site on GitHub Pages can lose, what I found, and what I changed.
date: 2026-10-25
draft: true
# The brief isn't published. See content/style.md.
brief:
  goal: Show that a static site still has a domain, a build and readers to protect, and leave readers with a checklist they can run today.
  purpose: Restart the blog in public and set the tone for what comes next. Check, don't assume.
  reaction: Readers run the checklist on their own site and reply with what they found, or what I missed.
  intent: lab notes
comments: true
authors:
  - Stefan
categories:
  - Security
tags:
  - Application Security
  - Supply Chain Security
---

<!-- DRAFT for Stefan. Facts marked VERIFY need a source check before publishing. -->

I'm restarting this blog after two and a half years. Before writing anything new, I wanted to know what could go wrong with it.

My assumption was "nothing". It's a static site on GitHub Pages: no server, no database, no login, nothing private on it. I checked the assumption instead of trusting it. These are my notes.

<!-- more -->

## What I set out to check

A static site has no data to steal. It still has three things someone could abuse:

- **The domain.** Whoever controls what `thoughtson.ai` serves can publish under my name.
- **The build.** Whatever runs in the pipeline can change every page.
- **The readers.** Every third-party script runs in their browser, on my domain.

I looked at each one by hand, then ran an AI security review against the repository.

## Domain and DNS

The domain is at Namecheap, DNS is on Cloudflare, and `www` points at GitHub Pages.

What I found:

- The custom domain wasn't verified with GitHub. If Pages is ever switched off while `www` still points at GitHub, someone else can claim the domain for their own site. <!-- VERIFY: GitHub docs, "Verifying your custom domain for GitHub Pages" -->
- HTTPS wasn't enforced. `http://www.thoughtson.ai` served the page instead of redirecting.
- No CAA records, so any certificate authority may issue for the domain.
- DNSSEC was off.
- An old SPF record was left from email forwarding, but there's no mail server and no DMARC. Anyone can send convincing mail "from" the domain.

Status: <!-- TODO: update when done --> open. These are settings at GitHub, Cloudflare and Namecheap, and they get their own post.

## The build

What I found:

- The build installed five packages with no versions, on every push. Whatever was newest on PyPI ran with write access to the site.
- The theme, Material for MkDocs, has been in maintenance mode since November 2025, and MkDocs itself is unmaintained.
- When I pinned everything, two plugins had quietly started depending on `properdocs`, a fork of MkDocs. That's probably legitimate, but a patch release shouldn't add a new upstream to my build without me noticing.

What I changed:

- Moved to [Zensical](https://zensical.org/), the successor from the same authors. It builds the blog, feeds, social cards and redirects itself. The build went from 51 packages to 11.
- Pinned every package with a hash, and I only take releases that are at least seven days old:

```bash
uv pip compile requirements.in --generate-hashes --exclude-newer 2026-10-18 -o requirements.txt
pip install --require-hashes --no-deps -r requirements.txt
```

Malicious releases are usually found and pulled within days, so a week's wait costs a blog nothing. <!-- VERIFY: cite a source for how quickly malicious npm/PyPI releases get removed -->

One surprise: Zensical applied a setting I had only meant for local previews ("show drafts while serving") to every build. My first Zensical build would have published this post before it was finished. I caught it because I listed what the build produced instead of trusting that it looked the same.

## The deploy

What I found: the workflow ran `mkdocs gh-deploy --force` with write access to the whole repository, using actions pinned only by tag. A tag can be moved to point at different code.

What I changed:

- Every action is pinned to a commit SHA. Dependabot proposes updates after a 7-day cooldown.
- Pull requests build with read-only permissions and never deploy.
- Only `main` deploys, through GitHub's Pages action, with `pages: write` and `id-token: write` and nothing else.
- A deploy is never cancelled half-way by a newer push.

I also tightened the repository settings: only GitHub's own actions are allowed, SHA pinning is required, secret scanning and push protection are on, and `main` can't be force-pushed or deleted.

## The readers

What I found: the cookie banner made it look handled, and it wasn't. Google Analytics waited for consent. The comments script, the theme's Google Fonts and my GitHub avatar all loaded on every visit, whatever the visitor chose. For readers in Europe, loading third-party resources before consent is a known problem; a German court fined a site over Google Fonts alone. <!-- VERIFY: cite the LG München Google Fonts ruling (January 2022) -->

What I changed:

- Comments load only after you accept them in the cookie settings, or click "Load comments" on a post.
- Fonts and images are served from this site.

How I checked: I opened a post in a fresh browser and listed every request that left the site. Now there are none until you click.

## What the AI review added

With no server, the review treated every published URL as an entry point (posts, archives, feeds, the search index) and looked at the build behind them.

- It confirmed the biggest real risk: the old deploy ran unpinned code while holding a token that could write to the repository. Already fixed by then.
- It found the consent problem above, which I had missed.
- It flagged smaller points on the new workflow, which I fixed: no `pull_request_target`, and no cancelled deploys.

It couldn't see anything outside the repository: DNS, domain verification, Pages and branch settings. A code review is blind to those, so they need their own check.

## Checklist

For a static site on GitHub Pages:

- [ ] Verify your custom domain on your GitHub account.
- [ ] Enforce HTTPS.
- [ ] Add CAA records for the certificate authorities you use.
- [ ] If the domain sends no mail: `v=spf1 -all` and DMARC `p=reject`.
- [ ] Turn on DNSSEC.
- [ ] Pin build dependencies with hashes, and wait a few days before taking new releases.
- [ ] Pin actions to commit SHAs. Give the deploy job only `pages: write` and `id-token: write`.
- [ ] Load no third-party script, font or image before consent. Check by listing the requests a fresh visit makes.
- [ ] After changing your build tool, list what the build produced. Drafts included.

## Still open

- The DNS and domain fixes above.
- A Content-Security-Policy, now that the site loads almost nothing from elsewhere.

If you run the checklist on your site and find something I missed, tell me in the comments or on [X](https://x.com/s_streichsbier).
