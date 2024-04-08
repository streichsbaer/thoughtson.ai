---
title: The Rise of AI Security Engineers
description: Are AI Security Engineers the paradigm shift we need?
icon: material/robot-love-outline
draft: false
comments: true
date: 2024-04-08
hide:
  - feedback
authors:
  - Stefan
categories:
  - AI &amp; Security
tags:
  - Application Security
  - AI Security Engineering
  - Autonomous Agents
---

# The Rise of AI Security Engineers

A few days ago, I gave a talk at DevOpsDays Singapore, where I asked a room full of engineers three simple questions:

!!! question "3 Questions"

    1. Do you write code that's critical to your company's success?
    2. Do you worry about hackers exploiting vulnerabilities in your code?
    3. Are you frustrated by the growing list of security tasks in your backlog?

The response was a resounding "yes" to all three questions, confirming an inconvenient truth: dealing with security is a frustrating experience for most engineers.

Security is often seen as a necessary evil – a pesky thing that nobody enjoys dealing with, but everyone knows they must. Teams pour countless resources into securing their applications, yet they rarely feel confident in their efforts.

Despite the proliferation of security tools and services, the number of disclosed vulnerabilities and successful breaches continues to rise. This trend begs the question: 
> Why are our current approaches to security failing, and could AI Security Engineers be the paradigm shift that we need?

<!-- more -->

To answer the why, we first have to look at how application security has evolved over the years.

## Previously on "AppSec"

If application security were a TV show, we'd be at the end of season two.

### The Pilot

As software eats the world, companies rush to bring their businesses online. The digital economy booms, but web applications are riddled with vulnerabilities, exposing them to attacks. Security experts are few and far between, and tools to help them are virtually non-existent. They struggle to scale security reviews and build tools to keep pace with the growing threat.

Cliffhanger: Will they secure applications or will hackers prevail?

### Season 1 Recap

In the waterfall era, every release has a dedicated phase to find and fix vulnerabilities. Automated tools scan source code but generate a lot of false positives, creating extra work. Tension between security and development teams reaches a boiling point as release deadlines approach. Developers struggle to context switch, understand vulnerabilities, and provide fixes, only to find that their solutions don't work. Releases are delayed, and frustration grows.

Despite the challenges, a process emerges for conducting security reviews before releasing software once or twice a year.

**Season 1 Finale**

As teams adapt to this approach, digital-first, cloud-native companies emerge. They build software iteratively, releasing changes multiple times a month, week, or even daily.

Cliffhanger: Can teams "do security" at DevOps speed?

### Season 2 Recap

Agile and DevOps become the new norm, with security engineers outnumbered 100 to 1 by developers. Reviewing code fast enough is impossible. The solution? Integrate security earlier in the software development lifecycle, empowering developers to identify and fix vulnerabilities as they're introduced. Security tools integrate into CI/CD pipelines, slowing down builds and overwhelming developers with thousands of alerts.

The security industry responds with innovations to make tools faster, more capable, and better integrated into workflows. Data flow analysis, secrets verification, and reachability analysis for dependencies reduce false positives, saving teams countless hours of manual review.

**Season 2 Finale**

Every code change is automatically scanned for vulnerabilities. Generative AI starts helping developers fix them. However, teams still struggle to triage, prioritize, and fix the continuous stream of vulnerabilities.

Attackers begin leveraging AI to launch sophisticated, automated attacks.

Cliffhanger: Are human defenders a match for this new threat? Unlikely.

### Coming up on "AppSec"

As we enter the third and final season, the challenges faced by security teams and developers are far from resolved. With more software being created than ever and the threat of autonomous AI attackers rising, the question remains: How can we secure our applications at scale and avoid all the frustration?

This is where AI Security Engineers are making their appearance, attempting to save the day. And where we end the TV show analogy.

## The Rise of AI Security Engineers

Generative AI has taken the world by storm. The release of GPT-4 was a wake-up call for many, myself included. Large Language Model (LLM) technology has pushed the boundaries of what can be achieved.

More and more code is being created with the help of co-pilots, which are rapidly improving. From GitHub Copilot autocompleting a few lines of code to [Devin](https://twitter.com/cognition_labs/status/1767548763134964000), an autonomous agent that can solve engineering tasks on its own. The progress in just one year is amazing!

However, it's not all sunshine and rainbows. The code generated by LLMs is [not necessarily secure](https://www.techtarget.com/searchsecurity/news/366571117/GitHub-Copilot-replicating-vulnerabilities-insecure-code). It's easier than ever to create code, even without being a trained developer. This ease of code generation, coupled with the potential security vulnerabilities in AI-generated code, means that more vulnerabilities are being introduced into software systems. As a result, engineering teams face a growing backlog of vulnerabilities to address, leading to increased frustration and a tilt in favor of attackers.

At this inflection point, we must ask ourselves: How can AI be used by defenders in ways that weren't possible before?

We have seen the first promising applications of generative AI for security. LLMs are being used to reduce false positives and generate fixes for vulnerabilities, doing so much better than any previous tool. This is already an enormous value add.

However, security engineers and developers still need to do a lot of manual work to keep up with all the vulnerabilities. The only solution is to increasingly automate this manual work by leveraging AI Security Engineers.

### What are AI Security Engineers

AI Security Engineers are autonomous agents that leverage the power of Large Language Models (LLMs) to perform security tasks independently. LLMs are advanced AI models that can understand and generate language, enabling AI Security Engineers to comprehend the context and intent behind code. By utilizing LLMs, AI Security Engineers can adapt to new coding patterns, frameworks, and attack vectors, providing a more dynamic and human-like approach to application security compared to traditional tools.

Traditional security tools rely on static rulesets that generate a high number of false positives, flagging issues that aren't actually vulnerabilities. This leads to wasted time and resources as teams investigate and address these false alarms.

In contrast, AI Security Engineers understand the context and logic behind the code, allowing them to reduce false alerts and increase accuracy. They can identify complex vulnerabilities that tools miss, such as business logic flaws or authentication weaknesses.

A common example is when tools detect cryptography-related issues, such as the use of MD5 or insecure random generators, but require a human to review whether they are used in a security-sensitive context or can be ignored. Similarly, AI Security Engineers can identify vulnerabilities such as missing authorization checks, that are difficult for traditional tools to detect. In both cases, AI Security Engineers can more accurately assess the security impact without human intervention.

Furthermore, AI Security Engineers can learn from the feedback and preferences they receive from human security experts. This allows them to refine their vulnerability detection and remediation capabilities over time, adapting to each organization's unique environment. For instance, AI Security Engineers can prioritize vulnerabilities based on the organization's risk appetite, provide contextual information to help human experts make informed decisions, and suggest remediation strategies that align with the development team's practices.

By collaborating with AI Security Engineers, teams can significantly reduce the growing backlog of potential vulnerabilities and improve the overall security posture of their applications. AI Security Engineers can save developers significant time and effort in addressing these issues by providing tailored remediation advice. For example, an AI Security Engineer can provide a developer with a list of recommended code changes to fix a vulnerability, along with an explanation of why those changes are necessary. The developer can then review the suggestions, make any necessary modifications, and implement the fixes more efficiently.

However, it's crucial to recognize that human expertise remains essential in certain situations, such as evaluating the business impact of a vulnerability or deciding on the appropriate remediation strategy in complex scenarios. AI Security Engineers are designed to augment and support human expertise, not replace it entirely. The goal is to create a synergistic relationship where AI and humans work together to achieve better security outcomes.

### Towards Full Autonomy

The first uses of AI in security are promising, but we are only at the beginning of the journey towards fully autonomous AI Security Engineers. AI Security Engineers have to be made accessible to defenders as quickly as possible. If we fail to do so, attackers might create autonomous AI hackers first, which could have devastating consequences.

The potential impact of fully autonomous AI Security Engineers cannot be overstated. I believe that the way we approach security 5 years from now will be unrecognizable compared to today. Imagine a future where security is effortless for teams, where the frustration and friction associated with application security are a thing of the past. In this future, AI Security Engineers work tirelessly behind the scenes, continuously monitoring, analyzing, and improving the security posture of applications without slowing down development.

To make this a reality, AI Security Engineers need to be accessible to everyone building software. This means developing AI-powered security solutions that are affordable, easy to integrate, and scalable to meet the needs of organizations of all sizes. Autonomous agents equipped with the full context of a business are much more powerful than autonomous agents with limited context, which for the first time will put defenders at an advantage over attackers.

Bridging the gap between our current state and fully autonomous AI Security Engineers is a complex challenge. It requires a strategic approach and a deep understanding of both AI and application security. But it's a challenge we must tackle head-on.

In the next piece, I will dive into the 6 levels of Application Security Automation and present a roadmap for achieving fully autonomous AI Security Engineers. Get ready to explore the key milestones, technical challenges, and potential implications of this transformative journey. Understanding these levels and the path forward is essential for anyone looking to stay ahead in the rapidly evolving world of application security.

!!! tip "Join the conversation"

    What do you think?
  
      - Is security something that should only be done by humans?
      - How much should we automate, where do we draw the line, and why?

	  Choose the platform that works best for you and chime in:

      - [X]()
      - [Hacker News]()
      - [LinkedIn]()

