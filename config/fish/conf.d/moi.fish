# moi-open — open the current directory's moi workspace in the browser.
# The moi server is a launchd service (always running); this just resolves
# the workspace id for (a parent of) the cwd from moi's registry.
function moi-open -d "Open the current moi workspace in the browser"
    set -l reg "$HOME/Library/Application Support/moi/workspaces.json"
    test -f "$reg"; or begin
        echo "moi registry not found — is moi installed?" >&2
        return 1
    end
    set -l dir (pwd)
    while test "$dir" != /
        set -l id (jq -r --arg p "$dir" '.[] | select(.path == $p) | .id' <"$reg")
        if test -n "$id"
            open "http://localhost:13337/workspace/$id"
            return 0
        end
        set dir (dirname "$dir")
    end
    echo "no moi workspace covers "(pwd)" — run: moi init --harness=<claude-code|hermes|...>" >&2
    return 1
end
