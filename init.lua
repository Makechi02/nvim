require "core"
require "plugins"
require "mappings"

local core_conf_files = {
    "colorschemes.lua"
}

-- for _, file_name in ipairs(core_conf_files) do
--     if vim.endswith(file_name, 'vim') then
--         local path = string.format("%s/lua/core/%s", vim.fn.stdpath('config'), file_name)
--         local source_cmd = "source" .. path
--         vim.cmd(source_cmd)
--     else
--         local module_name, _ = string.gsub(file_name, "%.lua", "")
--         package.loaded[module_name] = nil
--         require(module_name)
--     end
-- end
