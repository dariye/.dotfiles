if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set --local BREW_PREFIX (brew --prefix)

set -g fish_user_paths "/usr/local/opt/gettext/bin" (yarn global bin) $fish_user_paths

[ -f $BREW_PREFIX/opt/asdf/asdf.fish ]
and source $BREW_PREFIX/opt/asdf/asdf.fish

if type nvim >/dev/null 2>/dev/null
  alias vim='nvim'
  alias vi='nvim'
end

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
