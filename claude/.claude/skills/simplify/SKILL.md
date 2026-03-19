---
name: simplify
description: Review changed code for reuse, quality, and efficiency. For Rust files, runs cargo clippy with complexity and pedantic lints, then acts on findings.
argument-hint: [file or area to review]
---

Review the recently changed code for opportunities to simplify.

For Rust projects (detected by presence of Cargo.toml):
1. Identify which `.rs` files were recently changed (`git diff --name-only HEAD` or files edited in this session).
2. Run `cargo clippy -- -W clippy::complexity -W clippy::pedantic -W clippy::nursery -W clippy::redundant_clone -W clippy::needless_pass_by_value 2>&1` and filter output to only warnings in changed files.
3. For each finding, either fix it or explain why it should stay.

For all languages:
1. Look for unnecessarily verbose patterns, redundant logic, or over-abstraction.
2. Check if any new code duplicates existing code nearby.
3. Suggest concrete simplifications — don't just flag, fix.
