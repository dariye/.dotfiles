---
name: beads-onboard
description: >-
  Onboard a git repository onto beads (bd) issue tracking with Cursor
  integration. Use when a project has no .beads/ directory and needs task
  tracking, or when the user says "set up beads", "onboard this project",
  or "add bd to this repo".
---

# Onboard a Project onto Beads

Sets up beads issue tracking plus Cursor session wiring in a git repository. The result: every Cursor session in that repo gets `bd prime` context injected automatically, and all task tracking flows through bd.

## Preconditions

- `bd` is installed (`bd --version`; install with `brew install beads` if missing)
- The target directory is a git repository (main checkout, not a worktree — worktrees inherit the setup once it lands on their branch)
- The repo does not already have `.beads/` (check first; if it does, run `bd setup cursor --check` and repair instead)

## Procedure

Run from the repo root:

```bash
bd init --non-interactive  # creates .beads/ database + AGENTS.md managed block (prefix derived from dir name)
bd setup cursor            # writes .cursor/rules/beads.mdc (always-applied rule)
bd setup cursor --check    # verify installation status
```

Notes:

- Pass `--prefix <name>` to `bd init` if the directory name makes a poor issue prefix.
- Since beads 1.2.2 the Cursor integration is **rules-only**: `.cursor/rules/beads.mdc` is applied every turn and instructs the agent to run `bd prime` for workflow context and persistent memories. There is no `bd cursor-hook` anymore — if you find `.cursor/hooks.json` entries calling `bd cursor-hook`, remove them (they fail on every event).
- `bd init` appends a managed block to AGENTS.md between `BEGIN/END BEADS INTEGRATION` markers; leave the markers intact.

## After setup

1. **Leave the changes uncommitted** for the user to review, unless they asked you to commit. Summarize what was created: `.beads/`, `.cursor/rules/beads.mdc`, `.cursor/hooks.json`, AGENTS.md block.
2. Optionally seed the tracker from any existing TODO markdown: `bd create "title" -t task -p 2` per item, then delete the markdown list (beads owns operational state; markdown narrates).
3. Remind: durable gotchas go to `bd remember "fact" --key slug`, injected into every future session.
