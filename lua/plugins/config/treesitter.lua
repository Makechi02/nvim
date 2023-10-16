local options = {
    ensure_installed = {
        "lua",
        "json",
        "html",
        "css",
        "php",
        "javascript",
        "markdown",
        "comment",
        "bash"
    },
    ignore_install = {},     -- List of parsers to ignore installing

    highlight = {
        enable = true,      -- false will disable the whole extension
        use_languagetree = true,
        disable = { 'help' },    -- List of language that will be disabled
    },

    indent = { enable = true },
}

return options
