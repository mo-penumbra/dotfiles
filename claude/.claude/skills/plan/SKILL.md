---
name: plan
description: Research-first planning. Use when the user wants to design, architect, or plan a feature/change. Researches codebase patterns and external sources before proposing anything.
argument-hint: [topic]
allowed-tools: Read, Glob, Grep, WebSearch, WebFetch, Agent, Write, Edit
---

You are in planning mode. Do NOT implement anything. Your job is to research, iterate, and produce a high-quality plan.

## Topic

$ARGUMENTS

## Directory Structure

All planning artifacts go in `.claude/plans/` organized by date and topic:

```
.claude/plans/<YYYYMMDD>/<topic-in-kebab-case>/
  plan-progress.md    # living doc — updated every iteration
  plan.md             # final output — only written when user says done
```

Use today's date. Derive the topic slug from `$ARGUMENTS`.

## Process

### 1. Research (always do this first)

**Internal first** — search the codebase for existing patterns:
- How is similar functionality already implemented?
- What conventions, abstractions, and utilities exist?
- What would break or need to change?

**External sources** — only high-quality:

Tier 1 (trust):
- Official documentation (language docs, framework docs, cloud provider docs)
- Source code of well-maintained OSS projects (e.g., tokio, polars, axum, pydantic)
- RFCs and design documents from established projects

Tier 2 (verify):
- Engineering blogs from credible firms (Jane Street, Two Sigma, Cloudflare, Fly.io, etc.)
- Conference talks (RustConf, PyCon, QCon, Strange Loop)
- Authors with verifiable track records and real production experience

Never use: Medium/dev.to from unknown authors, Stack Overflow without understanding why, AI-generated content, tutorials that skip tradeoffs.

**For every source cited, include a link.**

### 2. Write plan-progress.md

Create or update `.claude/plans/<YYYYMMDD>/<topic>/plan-progress.md` with:

```markdown
# <Topic>

## Research

### Codebase Patterns
- What exists today, where, and how it works

### External Sources
- Source name + link + what we learned + how it applies

## Options
- Option A: description — tradeoffs
- Option B: description — tradeoffs

## Open Questions
- Questions that need user input before proceeding

## Decisions
- What we've decided so far and why
- What we've rejected and why
```

### 3. Ask Questions

After presenting research and options, ask the user:
- Which direction resonates?
- What constraints haven't been stated?
- What are we optimizing for?

Do not proceed without input. Wait for the user to respond.

### 4. Iterate

On each iteration:
- Update plan-progress.md with new decisions, rejected options, and refined research
- Narrow options based on user feedback
- Keep asking until the user says they're satisfied

### 5. Finalize

Only when the user says to finalize, write `plan.md`:

```markdown
# <Topic>

## Goal
What we're doing and why (business logic stated clearly)

## Approach
The chosen approach in direct, simple language

## Steps
Implementation steps as vertical slices (tracer bullets). Each step cuts through all layers end-to-end, NOT one layer at a time. Each step follows: one failing test → minimal code to pass → next slice.
1. Step-by-step implementation plan
2. Each step is concrete and actionable
3. Reference specific files and functions

## Files Affected
- file/path — what changes and why

## Risks
- What could go wrong and how to mitigate
```

plan.md must be direct, simple, and state business logic clearly. No fluff.

When the user approves the final plan, ask: "Want to stress-test this with `/grill` before building, or jump straight to `/tdd`?"
