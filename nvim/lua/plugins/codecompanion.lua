return {
    "olimorris/codecompanion.nvim",
    name = "codecompanion",
    opts = {},
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        {
            "MeanderingProgrammer/render-markdown.nvim",
            ft = { "markdown", "codecompanion" }
        },
        {
            "echasnovski/mini.diff",
            config = function()
                local diff = require("mini.diff")
                diff.setup({
                    -- Disabled by default
                    source = diff.gen_source.none(),
                })
            end,
        },
        {
            "HakonHarnes/img-clip.nvim",
            opts = {
                filetypes = {
                    codecompanion = {
                        prompt_for_file_name = false,
                        template = "[Image]($FILE_PATH)",
                        use_absolute_path = true,
                    },
                },
            },
        },
    },
    config = function()
        require("codecompanion").setup({
            -- Set some new adapters to be used in the strategies
            adapters = {
                opts = {
                    show_defaults = false,
                },

                openrouter_mistral = function()
                    return require("codecompanion.adapters").extend("openai_compatible", {
                        env = {
                            url = "https://openrouter.ai/api",
                            api_key = "OPENROUTER_API_KEY",
                            chat_url = "/v1/chat/completions",
                        },
                        schema = {
                            model = {
                                default = "mistralai/mistral-small-3.1-24b-instruct:free",
                            },
                        },
                    })
                end,
            },

            display = {
                diff = {
                    enabled = true,
                    close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
                    layout = "vertical", -- vertical|horizontal split for default provider
                    opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
                    provider = "mini_diff", -- default|mini_diff
                },
            },

            -- Strategies used for each part
            strategies = {
                -- Configure the chat part
                chat = {
                    adapter = "openrouter_mistral",
                },
                inline = {
                    adapter = "openrouter_mistral",
                },
                cmd = {
                    adapter = "openrouter_mistral",
                }
            },

        })

        -- Custom keymaps
        vim.keymap.set("n", "<leader>cc", ":CodeCompanionChat<CR>", {})
        vim.keymap.set("n", "<leader>ca", ":CodeCompanionActions<CR>", {})
        vim.keymap.set({"n", "v"}, "<leader>ce", ":CodeCompanion<CR>", {})
    end,
}
