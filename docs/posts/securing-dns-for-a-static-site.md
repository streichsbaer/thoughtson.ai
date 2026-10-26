---
title: Securing DNS for a Static Site
# The slug fixes the URL: https://www.thoughtson.ai/posts/securing-dns-for-a-static-site/
# Never change it after publishing.
slug: securing-dns-for-a-static-site
description: Lab notes on the domain behind this blog. Domain verification, CAA, DNSSEC and mail records, at Cloudflare and Namecheap.
date: 2026-10-25
draft: true
# The brief isn't published. See content/style.md.
brief:
  goal: Show what to check and fix on the domain of a static site, with Cloudflare and Namecheap as the worked example.
  purpose: Whoever controls the domain can publish under my name. It's part of the series on securing this blog.
  reaction: Readers check their own domain's records and account settings, and tell me how it works at other providers.
  intent: lab notes with a checklist
comments: true
authors:
  - Stefan
categories:
  - DNS
---

<!-- DRAFT for Stefan. Status: findings only. The fixes need Stefan's Cloudflare, Namecheap and GitHub accounts. -->
<!-- TODO: after the fixes, add the before → after records and the commands that verify them. -->

This is the domain part of [securing this blog](securing-a-static-blog.md). Whoever controls what `thoughtson.ai` serves can publish under my name.

The setup: the domain is registered at Namecheap, DNS is on Cloudflare, and `www` points at GitHub Pages.

<!-- more -->

## What I found

- **The custom domain wasn't verified with GitHub.** If Pages is ever switched off while `www` still points at GitHub, someone else can claim the domain for their own site. <!-- VERIFY: GitHub docs, "Verifying your custom domain for GitHub Pages" -->
- **No CAA records,** so any certificate authority may issue for the domain.
- **DNSSEC was off.**
- **Mail:** an old SPF record was left from email forwarding, but there's no mail server and no DMARC. Anyone can send convincing mail "from" the domain.

## The records

<!-- TODO: before → after, once done. -->

- Domain verification: a TXT record from GitHub's account Pages settings.
- CAA: allow only the certificate authorities that issue for the site.
- DNSSEC: turn it on at Cloudflare, then add the DS record at Namecheap.
- A domain that sends no mail: `v=spf1 -all` and DMARC `p=reject`.

## The accounts

The records are only as safe as the accounts that can change them.

Cloudflare:

- passkeys or two-factor authentication, and a check of who has access;
- scoped API tokens instead of the global key;
- notifications for DNS changes, and the audit log.

Namecheap:

- two-factor authentication;
- registrar lock and auto-renew;
- account recovery details that still reach me.

## Other providers

<!-- TODO: decide whether to cover other DNS providers and registrars here, or ask readers how it works at theirs. -->

## Checklist

- [ ] Verify your custom domain on your GitHub account.
- [ ] Add CAA records for the certificate authorities you use.
- [ ] Turn on DNSSEC, and add the DS record at your registrar.
- [ ] If the domain sends no mail: `v=spf1 -all` and DMARC `p=reject`.
- [ ] Protect the DNS and registrar accounts: passkeys or 2FA, scoped tokens, change alerts, registrar lock, auto-renew.
