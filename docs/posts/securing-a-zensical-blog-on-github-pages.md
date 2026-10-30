---
title: Securing a Zensical Blog on GitHub Pages
# The slug fixes the URL: https://www.thoughtson.ai/posts/securing-a-zensical-blog-on-github-pages/
# X threads and the Cysmiq blog copy link back to that URL, so never change it after publishing.
slug: securing-a-zensical-blog-on-github-pages
description: "Lab notes from restarting this blog: why I moved it from MkDocs and Material to Zensical, and what a static site on GitHub Pages can still lose."
date: 2026-10-25
draft: true
# The brief isn't published. See content/style.md.
brief:
  goal: Explain the move to Zensical, map what a static blog can still lose, and hand readers a skill that runs the same checks on their site.
  purpose: Restart the blog in public and start a series that secures increasingly complex systems, beginning with the easiest one.
  reaction: Readers check their own static site against the attack surface, follow the series, and tell me what I missed.
  intent: lab notes
comments: true
authors:
  - Stefan
categories:
  - Security
---

<!-- DRAFT for Stefan. Facts marked VERIFY need a source check before publishing. -->
<!-- LINK markers: the DNS and CI/CD posts are drafts too. Link them once they're published. -->

I'm restarting this blog after two and a half years. I also want to secure everything I run properly, and write down how, so other people can do the same.

I'm starting with the easiest system I have: this blog. It's public, static, and holds nothing private. Later posts move on to increasingly complex systems.

<!-- more -->

## Why I moved from MkDocs to Zensical

The blog was built with MkDocs and the Material theme. When I came back to it:

- Material for MkDocs had been in maintenance mode since November 2025, and MkDocs itself is unmaintained.
- The build installed five packages with no versions on every push, so whatever was newest on PyPI ran with write access to the site.
- When I pinned everything, two plugins had quietly started depending on `properdocs`, a fork of MkDocs. That's probably legitimate, but a patch release shouldn't add a new upstream to my build without me noticing.

[Zensical](https://zensical.org/) is the successor from the same authors. It reads the existing `mkdocs.yml`, and it builds the blog, feeds, social cards and redirects itself, without plugins. The build went from 51 packages to 11.

One surprise: Zensical applied a setting I had only meant for local previews ("show drafts while serving") to every build. My first Zensical build would have published this post before it was finished. I caught it because I listed what the build produced instead of trusting that it looked the same. If you migrate, do the same.

## What a static blog can still lose

There's no server, no database and no login. There are still three things someone could abuse:

- **The domain.** Whoever controls what `thoughtson.ai` serves can publish under my name.
- **The build and deploy.** Whatever runs in the pipeline can change every page.
- **The readers.** Every third-party script runs in their browser, on my domain.

### The domain

The domain is at Namecheap, DNS is on Cloudflare, and `www` points at GitHub Pages. I found an unverified custom domain, no CAA records, DNSSEC off, and a mail setup that lets anyone send convincing mail "from" the domain.

The fixes are standard settings at those three services:

- verify the custom domain on my GitHub account;
- add CAA records for the certificate authorities that issue for the site;
- turn on DNSSEC;
- since the domain sends no mail, publish `v=spf1 -all` and DMARC `p=reject`.

### The build and deploy

The old workflow installed unpinned packages and ran `mkdocs gh-deploy --force` with write access to the whole repository, using actions pinned only by tag.

What I changed, and the repository settings I tightened, are in their own post: Securing Build and Deploy with GitHub Actions. <!-- LINK: /posts/securing-build-and-deploy-with-github-actions/ -->

### The readers

This part I fixed here, because it's specific to the blog.

What I found: the cookie banner made it look handled, and it wasn't. Google Analytics waited for consent. The comments script, the theme's Google Fonts and my GitHub avatar all loaded on every visit, whatever the visitor chose. For readers in Europe, loading third-party resources before consent is a known problem; a German court fined a site over Google Fonts alone. <!-- VERIFY: cite the LG München Google Fonts ruling (January 2022) -->

What I changed:

- Comments load only after you accept them in the cookie settings, or click "Load comments" on a post.
- Fonts and images are served from this site.

How I checked: I opened a post in a fresh browser and listed every request that left the site. Now there are none until you click.

## Still open

- The DNS and domain fixes.
- A Content-Security-Policy, now that the site loads almost nothing from elsewhere.

## Run it on your site

<!-- SKILL: link the static-site skill in streichsbaer/agent-skills once it exists. -->
I turned these checks into an agent skill, so your coding agent can run them on your site and suggest the fixes.

## What's next

This was the easy one. Next I'll go through the build and deploy in detail, then move on to systems with more to lose.

If you run a static site, check it against the three parts above. If you find something I missed, tell me in the comments or on [X](https://x.com/s_streichsbier).
