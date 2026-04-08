---
name: audit
description: Run git-audit on a repo, investigate the findings, and present a summary.
argument-hint: [time range, e.g. "6 months ago"]
allowed-tools: Bash, Read, Glob, Grep, Agent
---

# Repo Audit

Run `git audit` on the current repo, investigate the results, and summarize.

## Argument

`$ARGUMENTS` is the optional lookback window passed to `git audit` (default: "1 year ago").

## Process

### 1. Collect

Run `git audit $ARGUMENTS` and capture the full output.

### 2. Investigate

Launch parallel investigations using the Agent tool (subagent_type: Explore). Skip any section where git-audit returned no meaningful data.

**Churn hotspots** — For the top 5 most-changed files:
- What kind of changes are being made? (`git log --oneline --since=<window> -- <file>`)
- Cross-reference against the bug hotspot list.

**Contributors** — Compare all-time vs recent contributors.
- Does the top overall contributor appear in the recent window?
- What areas do they own exclusively? (`git log --author=<name> --name-only --format=''` piped through sort/uniq)

**Bug clustering** — For files appearing in both churn and bug lists:
- Read the file and assess size, nesting depth, coupling.
- Check recent bug-fix commits for recurring patterns.

**Firefighting** — For any reverts/hotfixes found:
- What was reverted and why?

### 3. Report

```markdown
# Repo Audit: <repo name>
> Window: <time range> | Generated: <today's date>

## Summary
2-3 sentences.

## Findings

### 1. <Finding Title>
**Signal**: What the data showed
**Next step**: One concrete action

### 2. ...

## Health Indicators
| Metric              | Value          |
|---------------------|----------------|
| Active contributors | N              |
| Bus factor          | N people       |
| Firefighting rate   | N in window    |
| Top churn file      | path (N edits) |

## What to Read First
Top 3-5 files to open and what to look for.
```

Name files, people, and commits. Report what the data shows, don't editorialize.
