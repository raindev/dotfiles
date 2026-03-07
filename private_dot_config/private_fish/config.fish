set --global --export --prepend PATH $HOME/bin $HOME/.local/bin /opt/homebrew/bin
set --global --export EDITOR nvim

# Use blinking block cursor for prompt
function on_fish_prompt --on-event fish_prompt
  echo -ne '\e[1 q'
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

fish_add_path /Users/abarchuk/.pyenv/versions/3.11.11/bin
