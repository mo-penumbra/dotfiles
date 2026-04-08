---
name: audit
description: Run git-audit on a repo, investigate the findings, and present a structured diagnosis of where the problems cluster and what to do about them.
argument-hint: [time range, e.g. "6 months ago"]
allowed-tools: Bash, Read, Glob, Grep, Agent
---

# Repo Audit

Run `git audit` on the current repo, investigate the results, and deliver a diagnosis.

## Argument

`$ARGUMENTS` is the optional lookback window passed to `git audit` (default: "1 year ago").

## Process

### 1. Collect

Run `git audit $ARGUMENTS` and capture the full output.

### 2. Investigate

Launch parallel investigations using the Agent tool (subagent_type: Explore). Focus on the top signals from each section. Skip any section where git-audit returned no meaningful data.

**Churn hotspots** — The file at the top is almost always the one people warn you about. High churn on a file doesn't mean it's bad — sometimes it's just active development. But high churn on a file that nobody wants to own is the clearest signal of codebase drag. That's the file where every change is a patch on a patch and the blast radius of a small edit is unpredictable.

For the top 5 most-changed files:
- What kind of changes are being made? (`git log --oneline --since=<window> -- <file>`)
- Are they feature work, patches, config tweaks, or churn-on-churn?
- Cross-reference against the bug hotspot list — a file that's high-churn AND high-bug is the single biggest risk.

**Bus factor** — Every contributor ranked by commit count. If one person accounts for 60% or more, that's the bus factor. If they left six months ago, it's a crisis. Look at the tail too — thirty contributors but only three active in the last year means the people who built this system aren't the people maintaining it.

- Does the top overall contributor appear in the recent window?
- What areas do they own exclusively? (`git log --author=<name> --name-only --format=''` piped through sort/uniq)
- Are there files only one person has ever touched?

One caveat: squash-merge workflows compress authorship. If the team squashes every PR, this reflects who merged, not who wrote.

**Bug clustering** — Compare the bug list against churn hotspots. Files on both lists are highest-risk: they keep breaking and keep getting patched, but never get properly fixed. This depends on commit message discipline — if the team writes "update stuff" for every commit, you'll get nothing. But even a rough map of bug density is better than no map.

For files on both lists:
- Read the file and assess complexity (size, nesting depth, coupling)
- Check recent bug-fix commits for patterns — is the same root cause recurring?

**Velocity** — Commit count by month for the entire history. Scan the output looking for shapes. A steady rhythm is healthy. A count that drops by half in a single month — usually someone left. A declining curve over 6-12 months means the team is losing momentum. Periodic spikes followed by quiet months means the team batches work into releases instead of shipping continuously. This is team data, not code data.

**Firefighting** — Revert and hotfix frequency. A handful over a year is normal. Reverts every couple of weeks means the team doesn't trust its deploy process — unreliable tests, missing staging, or a deploy pipeline that makes rollbacks harder than they should be. Zero results is also a signal: either the team is genuinely stable, or nobody writes descriptive commit messages.

For any reverts/hotfixes found:
- What was reverted and why?
- Was the fix re-applied later or is the feature still missing?

### 3. Report

Present findings in this format:

```markdown
# Repo Audit: <repo name>
> Window: <time range> | Generated: <today's date>

## Summary
2-3 sentences. The difference between spending your first day reading the codebase methodically and spending it wandering.

## Findings

### 1. <Finding Title>
**Signal**: What the data showed
**Diagnosis**: Why this is happening
**Risk**: What goes wrong if ignored
**Next step**: One concrete action

### 2. ...

## Health Indicators
| Metric              | Value          | Assessment |
|---------------------|----------------|------------|
| Active contributors | N              | ...        |
| Bus factor          | N people       | ...        |
| Monthly velocity    | trend          | ...        |
| Firefighting rate   | N in window    | ...        |
| Top churn file      | path (N edits) | ...        |

## What to Read First
The top 3-5 files to open, in order, and what to look for when you get there.
```

Be direct and specific. Name files, people, and commits. Don't hedge — if something looks bad, say so.
