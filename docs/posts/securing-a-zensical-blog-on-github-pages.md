---
title: Securing a Zensical Blog on GitHub Pages
# The slug fixes the URL: https://www.thoughtson.ai/posts/securing-a-zensical-blog-on-github-pages/
# X threads and the Cysmiq blog copy link back to that URL, so never change it after publishing.
slug: securing-a-zensical-blog-on-github-pages
description: "I'm securing everything I own, one system at a time. First up: this blog. Why I moved it to Zensical, the draft that almost went live, and why a static site still carries risk."
date: 2026-10-25
draft: true
# The brief isn't published. See content/style.md.
brief:
  goal: Restart the blog with a clear promise (I'm securing everything I own and sharing how) and show, on the simplest system, that "nothing to lose" is the wrong question.
  purpose: The warm-up for a series that moves on to increasingly complex systems.
  reaction: Readers run the skill on their own site, follow the series, and tell me what I missed.
  intent: lab notes
comments: true
authors:
  - Stefan
categories:
  - Security
---

<!-- DRAFT for Stefan, rewritten from his narration on 2026-10-30. -->
<!-- LINK markers: the GitHub Actions post and the skill are drafts too. Link them once they're published. -->

I'm restarting this blog after two and a half years. A lot has happened in AI since then, and it feels like a cyber apocalypse out there.

So I'm taking the time to look at everything I own and am accountable for, personal and company, and securing it one by one. I'll share how I do it, and what I take care of along the way.

The easiest one to start with is this blog. It's public, static, and holds nothing private. That doesn't mean there's no risk. Consider it a warm-up; more complex systems follow.

<!-- more -->

## Why I moved to Zensical

The blog ran on MkDocs with the Material theme. MkDocs is unmaintained, and Material is in maintenance mode.

It also pulled in 51 packages to build a blog. Every dependency is something that can go wrong, and a simple site shouldn't need much. [Zensical](https://zensical.org/), from the Material authors, builds the same site with 11.

## The draft that almost went live

Zensical has a setting to show drafts while previewing locally. Zensical applied it to every build, so my first build would have published this post before it was finished.

Embarrassing rather than dangerous. But it shows how easily something gets overlooked. Don't trust that the new system behaves like the old one; understand what it actually does, and check that it's configured securely. I caught it because I listed what the build produced.

## It's not about what I can lose

There's nothing here to steal in the traditional sense. The risk is that my properties get used to attack other people. For a static blog, that's three things:

- **The domain** must be configured securely, so nobody else can serve pages or send mail in its name.
- **Every build and deploy** must run in a way that can't be hijacked, because the pipeline can change every page.
- **Anything readers load** must be trustworthy, and kept up to date, especially when a third-party library has a known issue.

### The domain

The domain is at Namecheap, DNS is on Cloudflare, and the site is hosted on GitHub Pages. The fixes are standard settings:

- verify the custom domain on my GitHub account, so nobody else can claim it;
- add CAA records for the certificate authorities that issue for the site;
- turn on DNSSEC;
- since the domain sends no mail, publish `v=spf1 -all` and DMARC `p=reject`.

### The build and deploy

The old workflow installed unpinned packages and deployed with write access to the whole repository. How I locked it down is in the next post: Securing Build and Deploy with GitHub Actions. <!-- LINK: /posts/securing-build-and-deploy-with-github-actions/ -->

### What readers load

The comments, the fonts and my avatar all loaded from third parties on every visit, whatever the visitor chose in the cookie banner. Now the fonts and images come from this site, comments load only when you ask for them, and nothing loads from elsewhere before you choose.

Next: privacy-friendly analytics, and readers decide what they allow.

### Hosting and headers

<!-- TODO before publishing: make this section true. Proxy www through Cloudflare, add the headers, check them with curl, and record before → after. -->
A site should tell browsers how to protect its readers: a Content-Security-Policy, HSTS, no framing by other sites. GitHub Pages sent none of these headers, and it doesn't let me add any. <!-- VERIFY: GitHub Pages docs, no custom response headers -->

So I put Cloudflare in front of the site. Its free tier is a good idea for your own projects anyway: it sits between your site and attackers. What I get from it:

- the security headers, added to every response;
- HTTPS and HSTS settings in one place;
- protection against floods of traffic, and caching;
- privacy-friendly analytics without cookies.

One catch: GitHub renews the site's certificate itself, and that can break once Cloudflare sits in front. <!-- TODO: what we did about it, after testing. -->

## Run it on your site

<!-- SKILL: link the static-site skill in streichsbaer/agent-skills once it exists. -->
I turned these checks into an agent skill, so your coding agent can run them on your site and suggest the fixes.

## Still open

- The domain fixes.
- Analytics with a choice.

If you run a static site, run the skill and tell me what it found, or what I missed, in the comments or on [X](https://x.com/s_streichsbier).
