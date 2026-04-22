set --global --export --prepend PATH $HOME/bin $HOME/.local/bin /opt/homebrew/bin
set --global --export EDITOR nvim

# Use blinking block cursor for prompt
function on_fish_prompt --on-event fish_prompt
  echo -ne '\e[1 q'
end

# bun
set --global --export BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

source $__fish_config_dir/config.local.fish 2>/dev/null
