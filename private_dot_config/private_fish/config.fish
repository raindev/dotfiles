set --global --export --prepend PATH $HOME/bin $HOME/.local/bin /opt/homebrew/bin
set --global --export EDITOR nvim

# Use blinking block cursor for prompt
function on_fish_prompt --on-event fish_prompt
  echo -ne '\e[1 q'
end
