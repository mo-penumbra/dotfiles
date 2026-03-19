---
name: tdd
description: Test-driven development with vertical-slice red-green-refactor loop. Use when user wants to build features or fix bugs using TDD, mentions "red-green-refactor", wants test-first development, or says "tdd".
argument-hint: [feature or bug description]
---

# TDD — Vertical Slices

One test. One implementation. Repeat. Never horizontal.

## Anti-Pattern: Horizontal Slicing

```
WRONG:
  RED:   test1, test2, test3, test4, test5
  GREEN: impl1, impl2, impl3, impl4, impl5

RIGHT:
  RED→GREEN: test1→impl1
  RED→GREEN: test2→impl2
  RED→GREEN: test3→impl3
```

Writing all tests first produces bad tests — you test imagined behavior instead of actual behavior. Tests become insensitive to real changes.

## Workflow

### 1. Plan

Before writing any code:

- Confirm with user what interface changes are needed
- List the behaviors to test (not implementation steps) — prioritize with user
- Identify opportunities for deep modules (small interface, large implementation)

You can't test everything. Confirm which behaviors matter most.

### 2. Tracer Bullet

Write ONE test that confirms ONE thing:

```
RED:   Write test for first behavior → test fails
GREEN: Write minimal code to pass → test passes
```

This proves the path works end-to-end.

### 3. Incremental Loop

For each remaining behavior:

```
RED:   Write next test → fails
GREEN: Minimal code to pass → passes
```

Rules:
- One test at a time
- Only enough code to pass current test
- Don't anticipate future tests

### 4. Refactor

After all tests pass:

- Extract duplication
- Deepen modules (move complexity behind simple interfaces)
- Run tests after each refactor step
- Never refactor while RED — get to GREEN first

## What Makes a Good Test

**Good**: Tests behavior through public interfaces. Survives internal refactors. Reads like a spec.

```
test("user can checkout with valid cart", async () => {
  const cart = createCart();
  cart.add(product);
  const result = await checkout(cart, paymentMethod);
  expect(result.status).toBe("confirmed");
});
```

**Bad**: Coupled to implementation. Mocks internal collaborators. Breaks when you refactor but behavior hasn't changed.

```
test("checkout calls paymentService.process", async () => {
  const mockPayment = jest.mock(paymentService);
  await checkout(cart, payment);
  expect(mockPayment.process).toHaveBeenCalledWith(cart.total);
});
```

## When to Mock

Mock at system boundaries only: external APIs, databases (prefer test DB), time/randomness.

Never mock your own modules. If you need to mock an internal to test something, the interface needs redesigning.

## Per-Cycle Checklist

```
[ ] Test describes behavior, not implementation
[ ] Test uses public interface only
[ ] Test would survive internal refactor
[ ] Code is minimal for this test
[ ] No speculative features added
```

When all tests pass and refactoring is done, ask: "Implementation complete. Want me to run `/simplify` on the changed files?"
