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

![AI Security Engineers Rising Sun](../../assets/images/social/Thoughts/posts/the-rise-of-ai-security-engineers.png)

A few days ago at a [conference](https://devopsdays.org/events/2024-singapore/welcome/), I asked a room full of engineers three simple questions:

<!-- more -->

!!! question "3 Questions"

    1. Do you write code that's critical to your company's success?
    2. Do you worry about hackers exploiting vulnerabilities in your code?
    3. Are you frustrated by the growing list of security tasks in your backlog?

The response was a resounding "yes" to all three questions, confirming an inconvenient truth:

<ins>Dealing with security is a frustrating experience for engineers.(1)</ins>
{ .annotate}

1. And frankly, for everybody else, including security folks, as well.

Security is often seen as a necessary evil – a pesky thing that nobody enjoys dealing with, but everyone knows they must. Teams pour countless resources into securing their applications, yet they rarely feel confident in their efforts.

Despite the proliferation of security tools and services, the number of disclosed vulnerabilities and successful breaches continues to rise. This trend begs the question:

<center>**Why are our current approaches to security failing?**</center>

To understand the why, we have to look at how application security has evolved over the years.

## Previously on "AppSec"

If application security were a TV show, we would be at the end of season two. This is what happened so far.

### The Pilot

As software eats the world, companies rush to bring their businesses online. The digital economy booms, but web applications are riddled with vulnerabilities, exposing them to attacks. Security experts are few and far between, and tools to help them are virtually non-existent. They struggle to scale security reviews and build tools to keep pace with the growing threat.

Cliffhanger: Will teams secure their applications or will hackers prevail?

### Season 1 Recap

We are in the waterfall era, where every release has a dedicated phase to find and fix vulnerabilities. Automated tools scan source code but generate a lot of false positives, creating extra work. Developers struggle to context switch, understand vulnerabilities, and fix them correctly. Tension between security and development teams reaches a boiling point as release deadlines approach.

Despite the challenges, a process emerges for conducting security reviews before releasing software, which only happens a few times a year.

**Season 1 Finale**

As teams adapt to this approach, digital-first, cloud-native companies emerge. They build software iteratively, releasing changes multiple times a month, week, or even daily.

Cliffhanger: Will teams be able to "do security" at DevOps speed?

### Season 2 Recap

Agile and DevOps become the new norm, with security engineers outnumbered 100 to 1 by developers. Manually reviewing code fast enough is impossible. Security tools are integrated earlier in the software development lifecycle, with the hope of empowering developers to identify and fix vulnerabilities as they are introduced. However, the security tools slow down builds and overwhelm developers with thousands of alerts.

The security industry responds with innovations to make tools faster, more capable, and better integrated into workflows. [Taint tracking](https://codeql.github.com/docs/writing-codeql-queries/about-data-flow-analysis/#normal-data-flow-vs-taint-tracking), [secrets verification](https://www.guardrails.io/blog/preventing-and-managing-secrets-leaks/), and [reachability analysis](https://semgrep.dev/blog/2024/sca-reachability-analysis-methods) reduce false positives, saving teams countless hours of manual review.

**Season 2 Finale**

Generative AI is used to generate more code than ever before. Teams struggle to triage, prioritize, and fix the growing list of vulnerabilities. Hackers [start leveraging AI](https://www.microsoft.com/en-us/security/blog/2024/02/14/staying-ahead-of-threat-actors-in-the-age-of-ai/) to launch sophisticated, automated attacks.

Cliffhanger: Are human defenders a match for this new threat? Unlikely.

### Season 3 Teaser

As we enter the third and final season, the challenges faced by security teams and developers are far from resolved. With more software being created than ever and the threat of autonomous AI attackers rising, the question remains: 

<center>**How can we secure our applications at scale without causing all the frustration?**</center>

This is where AI Security Engineers are making their appearance, attempting to save the day (and where we end the TV show analogy).

## The Rise of AI Security Engineers

Generative AI has taken the world by storm. The release of GPT-4 was a wake-up call for many, myself included. Large Language Model (LLM) technology has pushed the boundaries of what can be achieved.

More and more code is being created with the help of co-pilots. From GitHub Copilot completing a few lines of code to [Devin](https://twitter.com/cognition_labs/status/1767548763134964000), an autonomous agent that can solve engineering tasks on its own. It's easier than ever to create code, even without being a trained developer.

However, the code generated by LLMs is [not necessarily secure](https://www.techtarget.com/searchsecurity/news/366571117/GitHub-Copilot-replicating-vulnerabilities-insecure-code). The ease of code generation, coupled with the potential security vulnerabilities in AI-generated code, means that more vulnerabilities are being introduced into software. As a result, engineering teams face a rapidly growing backlog of vulnerabilities that they need to address. At this inflection point, we must ask ourselves: 

<center>**How can AI be used by defenders in ways that weren't possible before?**</center>

We have seen the first promising applications of generative AI for security. LLMs are being used to reduce false positives and generate fixes for vulnerabilities, doing so much better than any previous tool.

The problem is that security engineers and developers still need to do a lot of manual work to keep up with all the vulnerabilities. The only solution is to increasingly automate this manual work by leveraging AI Security Engineers.

### What are AI Security Engineers?

AI Security Engineers are autonomous agents that leverage the power of Large Language Models (LLMs) to perform security tasks independently. LLMs are advanced AI models that can understand and generate language, enabling AI Security Engineers to comprehend the intent behind code in a more dynamic and human-like way.

Traditional security tools rely on static rulesets that generate a high number of false positives, flagging issues that aren't actually vulnerabilities. This leads to wasted time and resources as teams investigate and address these false alarms.

In contrast, AI Security Engineers understand the context and logic behind the code, allowing them to reduce false alerts and increase accuracy. They can also identify complex vulnerabilities that tools miss, such as business logic flaws and authorization weaknesses.

A common example is when tools detect cryptography-related issues, such as the use of MD5 or insecure random generators, but require a human to review whether they are used in a security-sensitive context or can be ignored. AI Security Engineers can more accurately assess the security impact without human intervention.

AI Security Engineers help developers reduce the growing backlog of vulnerabilities by providing tailored remediation advice. They can provide a developer with a list of recommended code changes to fix a vulnerability, along with an explanation of why those changes are necessary. The developer can then review the suggestions, make any necessary modifications, and implement the fixes more efficiently.

Furthermore, AI Security Engineers can learn from the feedback and preferences they receive from human security experts and adapt to each organization's unique environment. They can prioritize vulnerabilities based on the organization's risk appetite and suggest remediation strategies that align with the development team's practices.

AI Security Engineers are designed to augment and support human expertise, not replace it entirely. The goal is to create a synergistic relationship where AI and humans work together to achieve better security outcomes.

### Towards Full Autonomy

The benefits of creating fully autonomous AI Security Engineers cannot be overstated. I believe that the way we approach security in 5 years will be very different from today. Imagine a future where AI Security Engineers work tirelessly behind the scenes, continuously monitoring, analyzing, and improving the security posture of applications without slowing down development. (1)
{ .annotate }

1. And as can be anticipated, development will also increasingly be done by autonomous agents.

## Conclusion

The rise of AI Security Engineers represents a pivotal moment in the evolution of application security. By leveraging the power of Large Language Models, these autonomous agents have the potential to revolutionize the way we approach security. They will enable us to keep pace with the ever-increasing speed of software development and the growing sophistication of cyber threats.

AI Security Engineers need to be accessible to everyone who is building software. Autonomous agents equipped with the full context of a business are much more powerful than autonomous agents with limited context, which for the first time will put defenders at an advantage over attackers. If we fail to do so, and attackers create autonomous AI hackers first, the consequences will be devastating.

---

In the next piece, I will dive into the 6 levels of Application Security Automation and present a roadmap for achieving fully autonomous AI Security Engineers. Understanding these levels and the path forward is essential for anyone looking to stay ahead in this rapidly evolving field. 

---

If you found this useful, let me know in the comments. Also, [follow me on X](https://twitter.com/intent/follow?screen_name=s_streichsbier) for more content like this.

!!! tip "Join the conversation"

    What do you think?
  
      - Is security something that should only be done by humans?
      - How much should we automate, where do we draw the line, and why?

<!-- Choose the platform that works best for you and chime in:

      - [X]()
      - [Hacker News]()
      - [LinkedIn]()
-->