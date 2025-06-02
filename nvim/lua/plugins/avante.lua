return {
    "yetone/avante.nvim",
    name = "avante",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },

    config = function()
        require("avante").setup({
            mode = "base",
            provider = "gemini",
            ollama = {
                endpoint = "https://eminent-superb-elephant.ngrok-free.app", -- Note that there is no /v1 at the end.
                model = "deepcoder:14b"
            }, 
            gemini = {
                model = "gemini-2.5-flash-preview-05-20",
            },
            vendors = {
                openrouter_mistral = {
                    __inherited_from = "openai",
                    endpoint = "https://openrouter.ai/api/v1",
                    api_key_name = "OPENROUTER_API_KEY",
                    model = "mistralai/devstral-small:free",
                },
                 openrouter_deepseekR1 = {
                    __inherited_from = "openai",
                    endpoint = "https://openrouter.ai/api/v1",
                    api_key_name = "OPENROUTER_API_KEY",
                    model = "deepseek/deepseek-r1-0528:free",
                    disable_tools = true,
                },
                openrouter_deepseekV3 = {
                    __inherited_from = "openai",
                    endpoint = "https://openrouter.ai/api/v1",
                    api_key_name = "OPENROUTER_API_KEY",
                    model = "deepseek/deepseek-chat-v3-0324:free",
                    disable_tools = true,
                },
                openrouter_olympic = {
                    __inherited_from = "openai",
                    endpoint = "https://openrouter.ai/api/v1",
                    api_key_name = "OPENROUTER_API_KEY",
                    model = "open-r1/olympiccoder-32b:free",
                    disable_tools = true,
                },
           },

            -- system_prompt as function ensures LLM always has latest MCP server state
            -- This is evaluated for every message, even in existing chats
            system_prompt = function()
                local hub = require("mcphub").get_hub_instance()
                return hub and hub:get_active_servers_prompt() or ""
            end,
            -- Using function prevents requiring mcphub before it's loaded
            custom_tools = function()
                return {
                    require("mcphub.extensions.avante").mcp_tool(),
                }
            end,

            -- Diasble some tools because of the conflicts with mcphub
            disabled_tools = {
                "list_files",    -- Built-in file operations
                "search_files",
                "read_file",
                "create_file",
                "rename_file",
                "delete_file",
                "create_dir",
                "rename_dir",
                "delete_dir",
                "bash",         -- Built-in terminal access
            },

        })
    end,
}
