# workspace

Convention for this directory:

- **Each subdirectory is an independent code repository** with its own git
  history and its own MOI workspace (`moi init` run inside it). Exception:
  `dotfiles/` is not a MOI workspace — it only stores machine setup.
- **This root repo tracks MOI/workspace metadata only** — never child repo
  code or secrets. The root `.gitignore` is an allowlist: everything is
  ignored unless explicitly whitelisted, so new repos brought into this
  directory are excluded automatically.
- This repo is **local-only** (work machine) — do not add a remote.

## Adding a new project

```sh
git clone <repo> ~/workspace/<name>   # or move it in
cd ~/workspace/<name>
moi init && moi skill update

# beads (agent memory layer, invisible to repo collaborators)
bd init --stealth && bd setup claude --stealth
printf '/CLAUDE.md\n/.claude/\n' >> .git/info/exclude
mkdir -p ../.beads-remotes/<name>
bd dolt remote add origin file://$HOME/workspace/.beads-remotes/<name>
```

## Agent memory (beads)

Agent memory **never touches work git remotes**: each repo's beads database
pushes to a `file://` Dolt remote under `.beads-remotes/` here, which
Syncthing carries between machines (LOCK files excluded). Sync with
`bd dolt push` / `bd dolt pull`. Do not run bd's git-based sync against
a repo's origin. Telemetry is disabled globally (`~/.config/bd/config.yaml`,
rcm-linked from the dotfiles repo).

Then relocate its MOI objects into this repo (tracked here, invisible to
the child repo):

```sh
printf '/.moi\n/.claude/skills/moi-workspace/\n' >> .git/info/exclude
mv .moi ../.moi-objects/<name>
ln -s ../.moi-objects/<name> .moi
```

MOI's server is shared across all workspaces: `moi start` / `moi status`,
UI at `http://localhost:13337/workspace/<id>` (each `moi init` prints its
workspace URL). The server binds 127.0.0.1 only.

## Syncing (Syncthing)

The MOI layer syncs between machines with [Syncthing](https://syncthing.net/)
— peer-to-peer, no third-party server. The folder `workspace-moi` shares this
directory, and `.stignore` is an allowlist: only `.moi-objects/`, `README.md`,
and `.gitignore` travel. Codebases and repos sync via their own git remotes,
never through Syncthing. Staggered versioning is on as a conflict safety net
(Syncthing makes `.sync-conflict-*` files instead of merging — work on one
machine at a time, and this repo's local git history is the undo).

GUI: `http://127.0.0.1:8384`. Pair a new device there, then share the
`workspace-moi` folder with it and copy `.stignore` over (Syncthing does not
sync `.stignore` itself).

## Dotfiles

`dotfiles/` is the rcm-managed dotfiles repo (moved from `~/.dotfiles`;
`DOTFILES_DIRS` in `rcrc` points here). Manage with `mkrc <file>` /
`rcup` / `lsrc`.
