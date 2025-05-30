return {
    "ravitemer/mcphub.nvim",
    name = "mcphub",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("mcphub").setup({
            extensions = {
                avante = {
                    make_slash_commands = true, -- make /slash commands from MCP server prompts
                }
            }
        })
    end
}
