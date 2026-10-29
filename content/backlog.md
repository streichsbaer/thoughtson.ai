# Content backlog

This is the working list for Thoughts on AI. It lives outside `docs/`, so it is never published.

Publishing order for every piece: Thoughts on AI first (the canonical URL), then an X thread that links to it, then the Cysmiq blog copy with rel=canonical pointing back.
Nothing is published or posted without Stefan's explicit OK. The writing style is in `style.md`.

The theme across every piece: verify that the tools actually work, close the gaps with our own extensions where they fall short, and show the evidence.

## Never share

- Customer, tenant and internal repository names, including the internal libraries we test on.
- Costs, subscription usage numbers and per-run dollar figures.
- Which model vendors and models we use, and internal model nicknames.
- How package intelligence is delivered; the package registry and patching plans.
- Contributor profiling, vulnerability imports from other tools, KYC and red-teaming ideas.
- Prompts, code, schemas, and exact internal metrics that are not generalised.
- Real snippets from Cysmiq images or pipelines. Use generic examples instead (Stefan, 2026-10-25).

## Articles, in order

| # | Working title | Status | File |
|---|---|---|---|
| 1 | Securing a Zensical Blog on GitHub Pages: the move from MkDocs, and what a static site can still lose | drafting; split on 2026-10-26 (below) | `docs/posts/securing-a-zensical-blog-on-github-pages.md` |
| 1a | Securing Build and Deploy with GitHub Actions (category CI/CD) | draft; waits on the Pages switch at publish time | `docs/posts/securing-build-and-deploy-with-github-actions.md` |
| 1b | Securing DNS with Cloudflare and Namecheap (category DNS) | draft, findings only; waits on Stefan's account changes | `docs/posts/securing-dns-with-cloudflare-and-namecheap.md` |
| 2 | Hardening the Dockerfiles of security tools, plus a free agent skill | outlined | — |
| 3 | GitHub Actions: secure the open-source actions you depend on, and give back | idea; the blog repo's own workflow is the first testbed | — |
| 4 | CircleCI and container registry settings: what to check, and how to cut pipeline time | later, once the platform supports it | — |
| 5 | Securing the accounts behind your site | mostly folded into 1a and 1b; what's left is the GitHub account level (2FA, keys, tokens, OAuth apps) | — |
| 6 | What good looks like | idea; also an X article that asks people for feedback | — |
| 7 | What took us so long | idea, for later | — |

### 1. Securing a static blog

Stefan, 2026-10-26: say little about the platform. Post 1 covers the move from MkDocs to Zensical and why, and the attack surface of a static blog. It links to a CI/CD post (build, deploy, GitHub settings) and a DNS post (Cloudflare, maybe other providers). The framing: I'm starting to secure all of this properly and helping other people do the same; a public blog is the easiest part, and the series moves on to increasingly complex systems. The "What the AI review added" section was dropped. The reader/consent fix stays in post 1.

Publish 1, 1a and 1b together, or replace the LINK markers in post 1 with plain text until the others are out. Uncomment their categories in `docs/categories.md` when they publish.

To plan later with Stefan: the series as a whole (what it covers, its name, how posts link to each other), where posts are created, and how the skills repo fits in.

Original notes, 2026-10-25:

The story is migrating this blog: what's at risk on GitHub Pages, and what is safe to share. Stefan expects little risk ("we don't own anything, it's just public information"), and we check whether that holds.

Sections:
- the domain and DNS;
- GitHub Pages settings;
- the build's supply chain;
- the deploy workflow's permissions;
- third-party scripts in the browser;
- our application review of the repo and of the generator package.

Facts found so far (2026-10-25):
- No GitHub Pages domain verification for `thoughtson.ai`. If Pages is ever turned off while `www` still points at `streichsbaer.github.io`, someone else could claim the domain.
- HTTPS is not enforced on Pages: `http://www` serves the page instead of redirecting. The apex redirects to `https://www` through Cloudflare.
- No CAA records. DNSSEC is unsigned. The registrar is Namecheap and DNS is on Cloudflare.
- The SPF record points at Namecheap email forwarding, but there is no MX and no DMARC. A domain that sends no mail should publish `v=spf1 -all` and `p=reject`.
- The build was unpinned (`pip install` of five unpinned packages, actions pinned by tag only), and the deploy ran `mkdocs gh-deploy --force` with `contents: write`.
- `mkdocs-redirects` 1.2.3 and `mkdocs-rss-plugin` 1.18+ quietly started depending on `properdocs`, a MkDocs fork created in March 2026. That's a real example of a dependency set changing under you.
- Material for MkDocs has been in maintenance mode since November 2025. Its successor is Zensical, now with blog, RSS and social-card support. MkDocs 1.x itself is unmaintained.
- GA4 and Giscus are the only third-party scripts.

### 2. Dockerfile hardening and the skill library

Use generic examples, and explain how the Cysmiq platform runs the same checks. The material comes from real work on our SBOM and code images; publish no real snippets.

- Pin every base image by digest.
- Lock the whole npm dependency tree, not one hashed tarball: `npm ci --ignore-scripts`. The tool we locked had about 200 packages.
- Resolve with a 7-day cooldown (`npm --before`, `uv --exclude-newer`). In our case that skipped several releases from the past week.
- Use hashed pip and Poetry pins.
- Move off an end-of-life base: Debian 13 and distroless cc-debian13 once distroless stopped updating debian12, and Node 24 LTS instead of the distribution's out-of-support Node.
- Ship only what runs: no package manager or shell helpers in the final stage, and no RUN steps there.
- Verify cosign/sigstore signatures before copying a checksum into the Dockerfile.
- Some advisories exist only as GitHub repository advisories, so OSV reports the affected versions as clean.
- Prove the hardening changed nothing: compare outputs before and after across many inputs. The parallel check took minutes.
- Run untrusted input with `--cap-drop ALL`, `no-new-privileges`, a read-only filesystem, limits, and `--network none`.
- Ends with the free `dockerfile-hardening` skill in `streichsbaer/agent-skills`, a repo still to be created.

### 3. GitHub Actions

"Show what we use and why we use them, and then why this helps us as a very useful signal."

Points:
- secure the open-source actions in your pipeline: SHA pins, cooldowns, least-privilege tokens, `persist-credentials: false`;
- contribute fixes upstream;
- the signals we take from them.

### 5. Securing the accounts behind your site

Stefan, 2026-10-25: "how to configure GitHub securely for pages", "same for Cloudflare and Namecheap ... how to manage DNS". This could become one article or a short series.

Internal only, not for publication until Stefan says so: the platform will later help configure the services a customer uses, and keep them configured, through browser use or supported integrations.

GitHub, as read from this repo's settings on 2026-10-25:
- Already right:
  - default workflow token permissions are read-only;
  - workflows can't approve pull requests;
  - Dependabot alerts are on;
  - no secrets, deploy keys or webhooks; one collaborator.
- To fix:
  - **Allowed actions:** "all", and SHA pinning not required. Restrict to GitHub-owned plus selected actions, and turn on "require SHA pinning".
  - **Secret scanning and push protection:** off, though free for public repos. Turn them on.
  - **Dependabot security updates:** off.
  - **`main`:** no ruleset or branch protection. Block force pushes and deletion, and require the build check.
  - **Private vulnerability reporting:** off. Turn it on and add a SECURITY.md.
  - **`github-pages` environment:** allows deploys from `gh-pages` and `main`. After the switch to the Actions deploy, allow `main` only and delete `gh-pages`.
- Account level, to cover in the article:
  - 2FA with passkeys or security keys;
  - review SSH, signing and GPG keys, tokens and authorized OAuth apps;
  - verify the Pages domain.
  - Note: the local `gh` token can't read account keys without extra scopes. That's least privilege working; keep it that way.

Applied 2026-10-25 through the GitHub API, with Stefan's OK. Before → after:
- allowed actions: all → GitHub-owned only (`patterns_allowed: []`), and SHA pinning required;
- secret scanning: off → on, and push protection: off → on;
- Dependabot security updates: off → on;
- private vulnerability reporting: off → on;
- ruleset "Protect main" (id 25826999), new: blocks deletion and force pushes on the default branch, with no bypass.
- Side effect: the old tag-pinned workflow on `main` can't run anymore. Publish by merging the new workflow, then switch the Pages source.
- Not yet done: drop `gh-pages` from the `github-pages` environment, after the switch; add a SECURITY.md.

Cloudflare:
- account 2FA or passkeys, and an audit of members;
- scoped API tokens instead of the global key;
- DNSSEC and CAA records;
- notifications for DNS changes, and the audit log;
- Web Analytics as a cookieless counter (see Analytics below).

Namecheap:
- account 2FA;
- registrar lock and auto-renew (the domain expires 2027-11-17);
- the DNSSEC DS record for Cloudflare's key;
- domain privacy and account recovery details;
- remove the stale email-forwarding SPF.

## Analytics (decided 2026-10-25)

Stefan wants as much visitor information as possible, but readers choose:
- **Accept in the consent banner:** Google Analytics 4.
- **Reject:** only a cookieless, privacy-friendly counter. The candidate is Cloudflare Web Analytics, since DNS is already on Cloudflare; it needs Stefan's beacon token.

To check: how Zensical handles analytics and consent, before building this on Material.

### Notes from the AI review of this blog (2026-10-25)

Real, fixed:
- the old deploy ran unpinned actions and packages with `contents: write`;
- Giscus, Google Fonts and the GitHub avatar loaded before consent. Fixed in commit e7d7708; verified in a fresh browser with zero third-party requests before a click.

Lower risk:
- PR builds stay on `pull_request`;
- deploys are not cancelled (fixed);
- the Pages environment should accept `main` only, after the switch;
- add a meta CSP after the redesign;
- approval for outside contributors' workflow runs: a repo setting, to ask Stefan.

Material for the "how we review" posts, generic and with no platform names:
- with no server, every published URL became an entry point; about two dozen work items;
- a code review can't see settings outside the repo (DNS, Pages, branch protection);
- a static site should be one published-output review, not one review per URL.

### Zensical 0.0.71 review (2026-10-26). NOT for publication

The findings in Zensical itself are unverified model verdicts and haven't been reported to the maintainers. They need reproducing and private disclosure first, which is Stefan's call. If they hold up, they're a real "giving back" story.

Applied to this site:
- `make serve` binds 127.0.0.1 only;
- PR builds never publish;
- no contributor content;
- macro and URL include features are off. The snippets extension only auto-appends a local abbreviations file.

Safe to say in general terms: the review found the generator's lower-trust inputs on its own (contributor content, the preview server, build-time fetches). It recorded each finding with the conditions under which it applies to a site, not as an absolute.

### 6. What good looks like

Stefan, 2026-10-25: "what good would look like". He'll point to it on X, ask other people for feedback, and maybe publish it as an X article too.

Scope to confirm with Stefan. Likely reading: a reference picture of a well-secured setup, built from articles 1–5 (site, build, deploy, accounts, images, CI). It's written as a standard others can argue with, and readers' feedback feeds back into the series and the free skills.

### Giving back to open source

Stefan, 2026-10-25: write about this only when we actually bring something back, for example:
- security analysis of the tools we use, with fixes;
- improvements we contribute;
- working with an author.

Not every small upstream issue.

### 7. What took us so long (later)

Stefan, 2026-10-25. Almost three years of work, and why the scope kept creeping:
- a lot was going on at once, and we had to work out what is actually useful;
- looking only at code is no longer enough, so the product needs much more;
- but first we had to learn to analyse code very well: efficiently, reliably and repeatably.

The story behind the platform, told honestly. Timing and detail are Stefan's call; check against the never-share list.

### 4. CircleCI and registries (later)

Wait until the platform supports it. The angle: what to look for, how to optimise it, and how to cut pipeline time.

## Series ideas from Stefan (2026-10-25, relayed by the repository security session)

### A. Saving our firstborn

GuardRails is still live in production. We run the new platform on GuardRails' own code and compare the two:
- check that the new platform covers everything GuardRails ever found, and more;
- then retire GuardRails and move every customer over.

In his words: "how we save our old firstborn basically with the new platform and then we retire it eventually and get everybody on to the new one."

- Status: the coverage comparison is in progress, and there are no public numbers yet.
- Before any part goes out, Stefan decides:
  - when the retirement and migration plan can be public, since customers should hear it first;
  - which coverage numbers can be shared.
- A possible first installment that needs neither: how to prove a new scanner is a superset of an old one, the method without the numbers.
- Stefan, 2026-10-25: he will say when the retirement plan can go public. The story he wants to tell with the numbers:
  - the first comparison showed we had missed something;
  - the second pass brought coverage to 100%;
  - the new platform finds more, with less noise.

### B. How we run our own security and compliance

What we store and what we don't, and how we keep the platform safe and scalable.

- Stefan, 2026-10-25: be transparent enough that people see how we deal with security and how we think about it, and invite feedback on how to improve. Trust is the only priority, and we show that we manage it reliably.
- Publish principles and choices, not architecture details that would help an attacker.
- Stefan approves the scope of each piece.

## X threads and short posts

Each is a thread first; the strongest become articles. Generic wording only, with no model or internal names.

1. Two years after "The Rise of AI Security Engineers": review the application, not the findings list. This is the anchor post.
2. Why we stopped building call graphs for AI code review.
3. Facts before models: deterministic route, middleware and caller discovery before any agent starts.
4. Threat models as data: how a plan drives dozens of agents.
5. Your model remembers packages that don't exist: package behaviour only from the exact locked version.
6. A vulnerability in a library depends on who installs it: conditional findings.
7. Cheap classifier first, expensive reasoner second.
8. Reruns that don't start over: staleness from what each agent actually read.
9. Durable agent sessions, and forking an agent's memory to answer a question.
10. Public vs private package provenance, read from lock files.
11. Runtime detection: an SBOM lists packages, but what actually runs them?
12. A "failure of the week" series: loops, context overflow, readiness bugs, folder names that lie.
13. Subscription vs API economics, qualitative only.

## Video

- "What 50 agents do in 26 minutes": an anonymised timeline of one review run.
- Alternative: a public, deliberately vulnerable app (vulpy, pygoat, DVWA) reviewed end to end in about 3 minutes.
