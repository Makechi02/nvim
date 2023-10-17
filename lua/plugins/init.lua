
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

    "nvim-lua/plenary.nvim",

    -- Colorschemes
    {
        "navarasu/onedark.nvim",
        -- lazy = true,
        config = function()
            require("onedark").setup({
                style = 'darker'
            })
            require('onedark').load()
        end
    },

    { "sainnhe/edge", lazy = true },
    { "sainnhe/sonokai", lazy = true },
    { "sainnhe/gruvbox-material", lazy = true },
    { "shaunsingh/nord.nvim", lazy = true },
    { "sainnhe/everforest", lazy = true },
    { "EdenEast/nightfox.nvim", lazy = true },
    { "rebelot/kanagawa.nvim", lazy = true },
    { "catppuccin/nvim", name = "catppuccin", lazy = true },
    { "olimorris/onedarkpro.nvim", lazy = true },
    { "tanvirtin/monokai.nvim", lazy = true },
    { "marko-cerovac/material.nvim", lazy = true },

    {
        "NvChad/nvim-colorizer.lua",
        -- init = function()
           -- require("core.utils").lazy_load "nvim-colorizer.lua"
        -- end,
        config = function(_, opts)
            require("colorizer").setup(opts)

            -- execute colorizer as soon as possible
            vim.defer_fn(function()
                require("colorizer").attach_to_buffer(0)
            end, 0)
        end,
    },

    -- File managing, Picker
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        --init = function()
          --  require("core.utils").load_mappings "nvimtree"
        --end,
        opts = function()
            return require "plugins.config.nvimtree"
        end,
        config = function(_, opts)
            require("nvim-tree").setup(opts)
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        cmd = "Telescope",
        --init = function()
          --  require("core.utils").load_mappings "telescope"
        --end,
        opts = function()
            return require "plugins.config.telescope"
        end,
        config = function(_, opts)
            local telescope = require "telescope"
            telescope.setup(opts)

            -- load extensions
            for _, ext in ipairs(opts.extensions_list) do
                telescope.load_extension(ext)
            end
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        version = "2.20.7",
        --init = function()
            --require("core.utils").lazy_load "indent-blankline.nvim"
        --end,
        opts = function()
            return require("plugins.config.indent_blankline")
        end,
        config = function(_, opts)
            -- require("core.utils").load_mappings "blankline"
            -- dofile(vim.g.base46_cache .. "blankline")
            require("indent_blankline").setup(opts)
        end,
    },

    -- Highlight URLs inside vim
    { "itchyny/vim-highlighturl", event = "VeryLazy" },

    -- notification plugin
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            vim.defer_fn(function()
                require("plugins.config.nvim_notify")
            end, 2000)
        end,
    },

    -- Snippet engine and snippet template
    {
        "SirVer/ultisnips",
        dependencies = { "honza/vim-snippets" },
        event = "InsertEnter"
    },

    -- Automatic insertion and deletion of a pair of characters
    { "Raimondi/delimitMate", event = "InsertEnter" },

    -- Comment plugin
    { "tpope/vim-commentary", event = "VeryLazy" },

    -- Multiple cursor plugin
    'mg979/vim-visual-multi',

    -- Autosave files on certain events
    -- { "907th/vim-auto-save", event = "InsertEnter" },
    {
        "pocco81/auto-save.nvim",
        opts = function()
            return require "plugins.config.auto_save"
        end,
        config = function(_, opts)
            require("auto-save").setup(opts)
        end,
    },

    -- Show undo history visually
    { "simnalamburt/vim-mundo", cmd = { "MundoToggle", "MundoShow" } },

    -- better UI for some nvim actions
    { "stevearc/dressing.nvim" },

    -- showing keybindings
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            vim.defer_fn(function()
                require("plugins.config.which_key")
            end, 2000)
        end,
     },

    -- show and trim trailing whitespaces
    { "jdhao/whitespace.nvim", event = "VeryLazy" },

    -- The missing auto-completion for cmdline!
    {
        "gelguy/wilder.nvim",
        build = ":UpdateRemotePlugins",
    },

    {
        'gen740/SmoothCursor.nvim',
        opts = function()
            return require "plugins.config.smooth_cursor"
        end,
        config = function(_, opts)
            require('smoothcursor').setup(opts)
        end
    },

     {
        "nvim-treesitter/nvim-treesitter",
        -- init = function()
           -- require("core.utils").lazy_load "nvim-treesitter"
        -- end,
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = function()
            return require "plugins.config.treesitter"
        end,
        config = function(_, opts)
            -- dofile(vim.g.base46_cache .. "syntax")
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- git stuff
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                    callback = function()
                        vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
                        if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                        vim.schedule(function()
                            require("lazy").load { plugins = { "gitsigns.nvim" } }
                        end)
                    end
                end,
            })
        end,
        opts = function()
            return require("plugins.config.gitsigns")
        end,
        config = function(_, opts)
            -- dofile(vim.g.base46_cache .. "git")
            require("gitsigns").setup(opts)
        end,
    },

    -- lsp stuff
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        opts = function()
            return require "plugins.config.mason"
        end,
        config = function(_, opts)
            -- dofile(vim.g.base46_cache .. "mason")
            require("mason").setup(opts)

            -- custom nvchad cmd to install all mason binaries listed
            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end, {})

            vim.g.mason_binaries_list = opts.ensure_installed
        end,
    },

    {
        "neovim/nvim-lspconfig",
        --init = function()
          --  require("core.utils").lazy_load "nvim-lspconfig"
        --end,
        config = function()
            require "plugins.config.lspconfig"
        end,
    },

     -- load luasnips + cmp related in insert mode only
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    require("plugins.config.luasnip").luasnip(opts)
                end,
            },

            -- autopairing of (){}[] etc
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },

            -- cmp sources plugins
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "onsails/lspkind-nvim",
            },
        },

        opts = function()
            return require "plugins.config.cmp"
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        -- cond = firenvim_not_active,
        config = function()
            require("plugins.config.statusline")
        end,
    },

    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        event = { "BufEnter" },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = function()
            return require('plugins.config.barbar')
        end,
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
        config = function(_, opts)
            require('barbar').setup(opts)
        end
    },

    -- Manage your yank history
    {
        "gbprod/yanky.nvim",
        cmd = { "YankyRingHistory" },
        config = function()
            require("config.yanky")
        end,
    },

}

-- Configurations for lazy itself
local lazy_options = {
    ui = {
        border = "rounded",
        title = "Plugin Manager",
        title_pos = "center"
    },

}

require("lazy").setup(plugins, lazy_options)

