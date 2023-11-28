return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
        },
    },

    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            vim.defer_fn(function()
                local nvim_notify = require("notify")

                nvim_notify.setup({
                    stages = "fade_in_slide_out",
                    timeout = 1500,
                    background_colour = "#2E3440",
                })

                vim.notify = nvim_notify
            end, 2000)
        end,
    },
}
