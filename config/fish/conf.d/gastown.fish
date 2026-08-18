# Gas Town shell integration — fish port.
#
# Upstream `gt install --shell` only emits bash/zsh (internal/shell/integration.go
# DetectShell() knows zsh and bash and defaults to zsh), so this mirrors
# ~/.config/gastown/shell-hook.sh for fish. It keeps GT_TOWN_ROOT/GT_ROOT/GT_RIG
# in sync with the current directory.

function _gastown_enabled
    test -n "$GASTOWN_DISABLED"; and return 1
    test -n "$GASTOWN_ENABLED"; and return 0
    set -l state_file $HOME/.local/state/gastown/state.json
    test -f $state_file; and grep -q '"enabled":[[:space:]]*true' $state_file 2>/dev/null
end

function _gastown_ignored
    set -l dir $PWD
    while test "$dir" != /
        test -f "$dir/.gastown-ignore"; and return 0
        set dir (dirname "$dir")
    end
    return 1
end

function _gastown_clear
    set -e GT_TOWN_ROOT GT_ROOT GT_RIG
end

# Translate the POSIX `export VAR="val"` / `unset A B C` that `gt rig detect`
# emits into fish's set/set -e. This is the part fish cannot simply eval.
function _gastown_apply -a payload
    for line in (string split \n -- $payload)
        set -l line (string trim -- $line)
        test -n "$line"; or continue
        if set -l m (string match -r '^export ([A-Za-z_][A-Za-z0-9_]*)=(.*)$' -- $line)
            set -gx $m[2] (string trim -c '"\'' -- $m[3])
        else if set -l u (string match -r '^unset[ \t]+(.*)$' -- $line)
            for v in (string split -n ' ' -- $u[2])
                set -e $v
            end
        end
    end
end

function _gastown_already_asked -a repo_root
    set -l asked $HOME/.cache/gastown/asked-repos
    test -f $asked; and grep -qF -- "$repo_root" $asked 2>/dev/null
end

function _gastown_mark_asked -a repo_root
    set -l asked $HOME/.cache/gastown/asked-repos
    mkdir -p (dirname $asked)
    echo $repo_root >>$asked
end

# Offer-to-add is OPT-IN, matching upstream: set GASTOWN_OFFER_ADD=1 to enable.
function _gastown_offer_add -a repo_root
    test "$GASTOWN_OFFER_ADD" = 1; or return 0
    test "$GASTOWN_DISABLE_OFFER_ADD" = 1; and return 0
    _gastown_already_asked $repo_root; and return 0
    isatty stdin; or return 0

    # Mark before reading: an interrupted prompt must not re-offer forever.
    _gastown_mark_asked $repo_root

    echo ""
    read -P "Add '"(basename $repo_root)"' to Gas Town? [y/N/never] " -l response

    switch $response
        case y Y yes
            echo "Adding to Gas Town..."
            set -l output (gt rig quick-add $repo_root --yes 2>&1)
            set -l code $status
            printf '%s\n' $output
            if test $code -eq 0
                set -l crew (printf '%s\n' $output | string replace -rf '^GT_CREW_PATH=' '')
                if test -n "$crew"; and test -d "$crew"
                    echo ""
                    echo "Switching to crew workspace..."
                    cd $crew; or true
                    _gastown_hook
                end
            end
        case never
            touch $repo_root/.gastown-ignore
            echo "Created .gastown-ignore - won't ask again for this repo."
        case '*'
            echo "Skipped. Run 'gt rig quick-add' later to add manually."
    end
end

function _gastown_hook
    _gastown_enabled; or begin
        _gastown_clear
        return 0
    end
    _gastown_ignored; and begin
        _gastown_clear
        return 0
    end

    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$repo_root"
        _gastown_clear
        return 0
    end

    set -l cache_file $HOME/.cache/gastown/rigs.cache
    if test -f $cache_file
        set -l cached (grep "^$repo_root:" $cache_file 2>/dev/null)
        if test -n "$cached"
            _gastown_apply (string join \n -- (string replace -r '^[^:]*:' '' -- $cached))
            return 0
        end
    end

    if command -q gt
        _gastown_apply (gt rig detect $repo_root 2>/dev/null | string collect)
        if test -n "$GT_TOWN_ROOT"
            gt rig detect --cache $repo_root >/dev/null 2>&1 &
            disown 2>/dev/null
        else if test -n "$_GASTOWN_PWD_CHANGED"
            _gastown_offer_add $repo_root
            set -e _GASTOWN_PWD_CHANGED
        end
    end
end

# fish fires this only on a real directory change — the chpwd equivalent.
function _gastown_chpwd --on-variable PWD
    set -g _GASTOWN_PWD_CHANGED 1
    _gastown_hook
end

status is-interactive; and _gastown_hook
