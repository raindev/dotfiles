local wezterm = require('wezterm')

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'OneDark (base16)'
  else
    return 'One Light (base16)'
  end
end

return {
  font_size = 16,
  font = wezterm.font('Source Code Pro'),
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  keys = {
    {
      key = 'F11',
      action = wezterm.action.ToggleFullScreen
    }
  },
  hide_tab_bar_if_only_one_tab = true,
  -- the system log from systemd-core-dump includes \u{1f855} prefix
  warn_about_missing_glyphs = false
}
