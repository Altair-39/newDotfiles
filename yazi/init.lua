require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})
require("simple-status"):setup()
require("no-status"):setup()
require("git"):setup({})
-- DuckDB plugin configuration
require("duckdb"):setup({
	mode = "standard", -- Default: "summarized"
	row_id = "dynamic", -- Default: false
	minmax_column_width = 21, -- Default: 21
	column_fit_factor = 10.0, -- Default: 10.0
})
