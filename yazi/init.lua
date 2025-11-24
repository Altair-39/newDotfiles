require("full-border"):setup {
  -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
  type = ui.Border.ROUNDED,
}
require("starship"):setup({
  -- Hide flags (such as filter, find and search). This is recommended for starship themes which
  -- are intended to go across the entire width of the terminal.
  hide_flags = false,                      -- Default: false
  -- Whether to place flags after the starship prompt. False means the flags will be placed before the prompt.
  flags_after_prompt = true,               -- Default: true
  -- Custom starship configuration file to use
  config_file = "~/.config/starship.toml", -- Default: nil
})
require("simple-status"):setup()
require("no-status"):setup()
require("git"):setup {}
-- DuckDB plugin configuration
require("duckdb"):setup({
  mode = "standard",        -- Default: "summarized"
  row_id = "dynamic",       -- Default: false
  minmax_column_width = 21, -- Default: 21
  column_fit_factor = 10.0  -- Default: 10.0
})
