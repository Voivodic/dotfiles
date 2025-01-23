return {
    'codota/tabnine-nvim',
    name = "tabnine",
    build = "./dl_binaries.sh",
    config = function()
        local tabnine = require("tabnine")
        tabnine.setup({
            disable_auto_comment = true,
            accept_keymap = "<C-c>",
            dismiss_keymap = "<C-d>",
            debounce_ms = 800,
            suggestion_color = { gui = "#808080", cterm = 244 },
            exclude_filetypes = { "TelescopePrompt", "NvimTree" },
            log_file_path = nil, -- absolute path to Tabnine log file
            ignore_certificate_errors = false,
        })
    end
}
