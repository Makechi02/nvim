return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count
        local fn = vim.fn

        local diff = function()
            local git_status = vim.b.gitsigns_status_dict
            if git_status == nil then
                return
            end

            local modify_num = git_status.changed
            local remove_num = git_status.removed
            local add_num = git_status.added

            local info = { added = add_num, modified = modify_num, removed = remove_num }
            return info
        end

        local function spell()
            if vim.o.spell then
                return string.format("[SPELL]")
            end

            return ""
        end

        local function trailing_space()
            if not vim.o.modifiable then
                return ""
            end

            local line_num = nil

            for i = 1, fn.line("$") do
                local linetext = fn.getline(i)
                -- To prevent invalid escape error, we wrap the regex string with `[[]]`.
                local idx = fn.match(linetext, [[\v\s+$]])

                if idx ~= -1 then
                    line_num = i
                    break
                end
            end

            local msg = ""
            if line_num ~= nil then
                msg = string.format("[%d]trailing", line_num)
            end

            return msg
        end

        local function mixed_indent()
            if not vim.o.modifiable then
                return ""
            end

            local space_pat = [[\v^ +]]
            local tab_pat = [[\v^\t+]]
            local space_indent = fn.search(space_pat, "nwc")
            local tab_indent = fn.search(tab_pat, "nwc")
            local mixed = (space_indent > 0 and tab_indent > 0)
            local mixed_same_line
            if not mixed then
                mixed_same_line = fn.search([[\v^(\t+ | +\t)]], "nwc")
                mixed = mixed_same_line > 0
            end
            if not mixed then
                return ""
            end
            if mixed_same_line ~= nil and mixed_same_line > 0 then
                return "MI:" .. mixed_same_line
            end
            local space_indent_cnt = fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
            local tab_indent_cnt = fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
            if space_indent_cnt > tab_indent_cnt then
                return "MI:" .. tab_indent
            else
                return "MI:" .. space_indent
            end
        end

        lualine.setup({
            options = {
                icons_enabled = true,
                theme = "ayu",
                section_separators = "",
                component_separators = "",
                disabled_filetypes = {},
                always_divide_middle = true,
            },

            sections = {
                lualine_a = { "mode" },

                lualine_b = {
                    "branch",
                    {
                        "diff",
                        source = diff,
                    },
                },

                lualine_c = {
                    "filename",
                    {
                        spell,
                        color = { fg = "black", bg = "#a7c080" },
                    },
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = "🆇 ", warn = "⚠️ ", info = "ℹ️ ", hint = " " },
                    },
                },

                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                },

                lualine_y = {
                    "location",
                    "progress",
                },

                lualine_z = {
                    {
                        trailing_space,
                        color = "WarningMsg",
                    },
                    {
                        mixed_indent,
                        color = "WarningMsg",
                    },
                },
            },

            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },

            tabline = {},
            extensions = { "quickfix", "fugitive", "nvim-tree" },
        })
    end,
}
