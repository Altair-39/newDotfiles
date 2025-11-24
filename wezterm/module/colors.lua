-- colors.lua
local M = {}

-- Function to read pywal colors using `jq` via shell
function M.read_pywal()
	local wal_path = os.getenv("HOME") .. "/.cache/wal/colors.json"
	local handle =
	    io.popen("jq -r '.special.foreground, .special.background, .special.cursor, (.colors[])?' " .. wal_path)
	if not handle then
		return nil
	end

	local result = {}
	for line in handle:lines() do
		table.insert(result, line)
	end
	handle:close()

	return {
		foreground = result[1],
		background = result[2],
		cursor = result[3],
		colors = { table.unpack(result, 4) },
	}
end

M.wal = M.read_pywal()

return M
