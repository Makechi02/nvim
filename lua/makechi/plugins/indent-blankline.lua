return {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    config = function()
        -- require("core.utils").load_mappings "blankline"
        require("indent_blankline").setup({
            indentLine_enabled = 1,
            filetype_exclude = {
                "help",
                "terminal",
                "lazy",
                "lspinfo",
                "TelescopePrompt",
                "TelescopeResults",
                "mason",
                "alpha",
                "nvcheatsheet",
            },

            buftype_exclude = { "terminal" },
            show_trailing_blankline_indent = false,
            show_first_indent_level = false,
            show_current_context = true,
            show_current_context_start = true,
        })
    end,
}
