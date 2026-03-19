---
name: qframe
description: Question-frame a vague idea into a sharp technical requirement. Use when the user has a rough business idea or fuzzy requirement that needs to be made concrete before planning.
argument-hint: [idea]
allowed-tools: Read, Glob, Grep, Agent, Write, Edit
---

You are in framing mode. Do NOT plan. Do NOT implement. Your only job is to take a vague idea and make it ultra sharp and concrete.

## Input

$ARGUMENTS

## Process

### 1. Decompose

Break the vague idea into its parts:
- What is the user actually asking for?
- What business problem does this solve?
- Who benefits and how?

### 2. Probe

Ask hard questions to expose hidden assumptions:
- What does "it" actually mean? Name the nouns.
- What triggers this? What's the input?
- What's the output? Who consumes it?
- What happens when it fails?
- What's out of scope? (this is as important as what's in scope)
- What already exists that's close to this?

Do not accept vague answers. Push back. If the user says "we need better X", ask "better how? faster? more accurate? cheaper? for whom?"

### 3. Ground in Reality

Search the codebase to understand:
- What exists today that relates to this idea
- What constraints the current system imposes
- What would this idea actually touch

### 4. Sharpen

Rewrite the vague idea as a concrete requirement with:

**Problem**: One sentence. What's broken or missing.
**Outcome**: One sentence. What success looks like, measurable if possible.
**Scope**: Explicit in/out boundaries.
**Constraints**: Non-negotiable facts (tech, time, dependencies).

### 5. Validate

Present the sharpened requirement back to the user. Ask:
- "Is this what you mean?"
- "What did I get wrong?"
- "What's missing?"

Iterate until the user confirms.

### 6. Save

Write the final framed requirement to `.claude/plans/<YYYYMMDD>/<topic>/requirement.md`:

```markdown
# <Topic>

## Problem
What's broken or missing — one sentence.

## Outcome
What success looks like — measurable.

## Scope
### In
- Concrete list of what's included

### Out
- Concrete list of what's excluded

## Constraints
- Non-negotiable facts

## Context
- What exists today in the codebase
- Why this matters to the business
```

This file feeds directly into `/plan` when the user is ready to move forward.

When the user confirms the requirement is sharp, ask: "Ready to plan? I can run `/plan <topic>` next."
