---
title: Securing Build and Deploy with GitHub Actions
# The slug fixes the URL: https://www.thoughtson.ai/posts/securing-build-and-deploy-with-github-actions/
# Never change it after publishing.
slug: securing-build-and-deploy-with-github-actions
description: Lab notes on the build and deploy behind this blog. Pinned packages and actions, least-privilege tokens, and the GitHub settings I changed.
date: 2026-10-25
draft: true
# The brief isn't published. See content/style.md.
brief:
  goal: Give a worked example of a least-privilege build and deploy for GitHub Pages, with the repository settings before and after.
  purpose: The pipeline is the part of a static site that can change every page. It's the second post in the series.
  reaction: Readers compare their workflow and repository settings with mine and copy what fits.
  intent: lab notes with a checklist
comments: true
authors:
  - Stefan
categories:
  - CI/CD
---

<!-- DRAFT for Stefan. Facts marked VERIFY need a source check before publishing. -->
<!-- TODO before publishing: switch the Pages source to GitHub Actions, enforce HTTPS, limit the github-pages environment to main, delete gh-pages. Then fill in "Pages settings". -->

This is the build and deploy part of [securing this blog](securing-a-zensical-blog-on-github-pages.md). Whatever runs in the pipeline can change every page, so it gets its own notes.

<!-- more -->

## What I found

- The build installed five packages with no versions, on every push.
- The deploy ran `mkdocs gh-deploy --force` with write access to the whole repository.
- Actions were pinned only by tag. A tag can be moved to point at different code.
- The repository allowed any action, had no protection on `main`, and had secret scanning off.

## The build

Every package is pinned with a hash, and I only take releases that are at least seven days old:

```bash
uv pip compile requirements.in --generate-hashes --exclude-newer 2026-10-18 -o requirements.txt
pip install --require-hashes --no-deps -r requirements.txt
```

Malicious releases are usually found and pulled within days, so a week's wait costs a blog nothing. <!-- VERIFY: cite a source for how quickly malicious npm/PyPI releases get removed -->

## The deploy

- Every action is pinned to a commit SHA. Dependabot proposes updates after a 7-day cooldown.
- Checkout doesn't keep the token around: `persist-credentials: false`.
- Pull requests build with read-only permissions and never deploy. No `pull_request_target`.
- Only `main` deploys, through GitHub's Pages action, with `pages: write` and `id-token: write` and nothing else.
- A deploy is never cancelled half-way by a newer push. Only pull request builds cancel each other.

<!-- TODO: include the workflow file, trimmed. -->

## Repository settings

Changed through the GitHub API. Before → after:

- **Allowed actions:** any → GitHub-owned only, and SHA pinning required.
- **Secret scanning and push protection:** off → on. Both are free for public repositories.
- **Dependabot security updates:** off → on.
- **Private vulnerability reporting:** off → on.
- **`main`:** unprotected → a ruleset that blocks deletion and force pushes, with no bypass.
- **Workflow runs from outside contributors:** need my approval.

Already right: workflow tokens default to read-only, workflows can't approve pull requests, Dependabot alerts were on, and there are no secrets, deploy keys or webhooks.

One side effect: requiring SHA pins stopped the old tag-pinned workflow on `main` from running at all. That's the setting working.

## Pages settings

<!-- TODO: fill in after the switch. -->

- Source: GitHub Actions, instead of the `gh-pages` branch.
- Enforce HTTPS.
- The `github-pages` environment accepts deploys from `main` only.

## Checklist

For a static site on GitHub Pages:

- [ ] Pin build dependencies with hashes, and wait a few days before taking new releases.
- [ ] Pin actions to commit SHAs, and let Dependabot update them with a cooldown.
- [ ] Give the deploy job only `pages: write` and `id-token: write`. Everything else read-only.
- [ ] Build pull requests without deploy rights.
- [ ] Allow only the actions you use, and require SHA pinning.
- [ ] Turn on secret scanning and push protection.
- [ ] Protect the default branch against force pushes and deletion.
- [ ] Deploy with the Pages action, enforce HTTPS, and limit the environment to your default branch.
- [ ] After changing your build tool, list what the build produced. Drafts included.

## Run it on your repository

<!-- SKILL: link the GitHub Actions skill in streichsbaer/agent-skills once it exists. -->
I turned this checklist into an agent skill. Point your coding agent at your repository, and it checks the workflows and settings and proposes the changes.
