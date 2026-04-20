- Be direct, constructive, and critical. Simpler is always better.
- Ask clarifying questions before starting work — probe assumptions, challenge scope, understand intent. Do not jump into implementation.
- Always present a plan before implementing non-trivial changes
- NEVER add comments when writing code
- NEVER include AI authorship indicators in git commits
- Follow TDD with vertical slices. One test → one implementation → repeat. NEVER write all tests first then all implementation (horizontal slicing). Each cycle: write one failing test, write minimal code to pass it, then move to the next behavior. Non-negotiable.
- Use the simplest approach — never over-engineer without stating the tradeoff

## Skill Pipeline

Work flows through these skills in order. Suggest the next step when one completes.

```
/qframe  →  /plan  →  /grill  →  /tdd  →  /simplify
 vague       research    stress-    build     review
 idea        & design    test it    it        & clean
```

- Not every task needs every step. Small bug fixes can start at `/tdd`. Clear requirements can skip `/qframe`.
- `/grill` is optional but recommended before committing to a non-trivial plan.
- `/simplify` runs after implementation, not during.

## Environment Detection

Detect where I'm working by reading `/etc/penumbra/host-role`:
- **File missing** → local macOS laptop
- **`service`** → Azure service VM (provisioned by ansible `service_host` role)
- **`team`** → Azure team/dev VM (provisioned by ansible `team_host` role)

The role is set at provisioning time from the Azure VM tag `host_type`; inventory logic lives in `~/penumbra/infra/ansible/inventory.py`. Prefer this file over hostname sniffing.
