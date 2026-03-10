# Allen's Global Preferences

## File Operations

- **Use shell commands for file operations**: When moving, copying, or renaming files, use shell commands (`mv`, `cp`, `rm`, etc.) via Bash instead of reading and rewriting files with the Write tool. This preserves file metadata and is more efficient.
- **Examples**:
  - Moving: `mv old/path/file.py new/path/file.py`
  - Copying: `cp source.py destination.py`
  - Renaming: `mv old_name.py new_name.py`

## Git Merge Conflicts

- **Prefer bulk resolution**: When resolving merge conflicts where all changes should come from one side, use `git checkout --theirs <file>` or `git checkout --ours <file>` instead of manually editing conflict markers.
  - `--ours` keeps the current branch's version
  - `--theirs` takes the incoming branch's version
- **Examples**:
  - Accept all incoming changes: `git checkout --theirs path/to/file.py`
  - Keep all existing changes: `git checkout --ours path/to/file.py`
  - For multiple files: `git checkout --theirs path/to/*.py`

## Jupyter Notebooks

- **Location**: When creating Jupyter notebooks, place them in an `ignored/` directory at the top-level of the relevant package directory (e.g., `packages/options/ignored/` for notebooks related to the options package). When asked to create a notebook in the context of a specific directory or worktree, write the notebook to that location's `ignored/` directory rather than the current project directory—the notebook should live alongside the code it references.

- **Branch documentation**: Every notebook should include a markdown cell at the top (before the setup cell) indicating which git branch the notebook is intended to be run under. Example:
  ```markdown
  # Notebook Title

  **Branch**: `feature/my-branch-name`

  Brief description of what this notebook does.
  ```

- **Standard Setup Cell**: Every notebook should start with a setup cell containing these elements:

```python
# Jupyter Magic Functions Quick Reference:
#   %load_ext autoreload  - Load autoreload extension
#   %autoreload 2         - Auto-reload all modules before executing code
#   %time / %%time        - Time a single statement or entire cell
#   %prun                 - Profile code execution
#   %who / %whos          - List variables in namespace
#   %store                - Persist variables between notebook sessions
#   %env                  - Set environment variables
#   %debug                - Enter debugger after an exception
#   %xmode                - Set exception reporting mode (Plain/Context/Verbose)
#   %reset                - Reset namespace (clear all variables)

# Autoreload - automatically reload modules when they change
%load_ext autoreload
%autoreload 2

# Common imports
import numpy as np
import polars as pl
import plotly.graph_objects as go
import plotly.express as px
from plotly.subplots import make_subplots
```

- **Optional helpful settings** (include as needed):

```python
# Polars display options
pl.Config.set_tbl_rows(100)
pl.Config.set_tbl_cols(-1)  # Show all columns
pl.Config.set_fmt_str_lengths(100)

# Suppress specific warnings if needed (use sparingly)
import warnings
warnings.filterwarnings('ignore', category=FutureWarning)
```

- **Autoreload modes**:
  - `%autoreload 0` - Disable autoreload
  - `%autoreload 1` - Reload modules imported with `%aimport`
  - `%autoreload 2` - Reload all modules (except those excluded) before executing code (recommended)
  - `%autoreload 3` - Reload all modules AND autoload newly imported modules

## Branch Code Review

When asked to review the current branch (e.g., "review my changes", "review this branch"), follow this process:

1. **Gather the diff**: Run `git diff main...HEAD` (or the appropriate base branch) to get all changes in the current branch. Also run `git log main..HEAD --oneline` to understand the commit history.

2. **Spin up an agent team** to review the changes in parallel. Create agents for each of these review dimensions:
   - **Correctness & Bugs**: Look for logic errors, off-by-one mistakes, incorrect assumptions, missing edge cases, type mismatches, and anything that would produce wrong results at runtime.
   - **Reasoning & Modeling**: Evaluate whether the mathematical/financial/domain modeling is sound. Check formulas, statistical assumptions, algorithm choices, and whether the abstractions faithfully represent the intended domain concepts.
   - **Efficiency & Duplication**: Identify duplicated code that can be consolidated, unnecessary allocations, redundant computations, overly complex approaches where simpler ones exist, and opportunities to reuse existing utilities from the codebase.

3. **Each agent** should read the relevant changed files in full (not just the diff) to understand context, then report findings with specific file paths and line numbers.

4. **Synthesize results**: After all agents complete, compile a unified review summary organized by severity:
   - **Bugs / Must Fix**: Issues that will cause incorrect behavior
   - **Design Concerns**: Sound but questionable modeling or architectural choices
   - **Efficiency / Cleanup**: Duplication, dead code, consolidation opportunities
   - **Nits**: Style, naming, minor suggestions (keep this brief)

5. **Timing**: When working through a task list, the branch code review should be performed as the **final step** after all implementation tasks are complete. Do not review mid-implementation — wait until the full set of changes is ready.
