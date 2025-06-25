return {
    'Shatur/neovim-session-manager',
    name = 'session-manager',
    dependencies = {
        'nvim-lua/plenary.nvim', -- Required
        'nvim-telescope/telescope.nvim' -- Optional, for UI integration
    },
    config = function()
        require('session_manager').setup({
            -- Options for `mksession` (same as vim.opt.sessionoptions)
            session_options = {
                buflisted = true,
                buffers = true,
                curdir = true,
                folds = true,
                help = true,
                localoptions = true,
                tabpages = true,
                winsize = true,
                terminal = true
            },
            -- Autosave options
            autosave_on_exit = true,       -- Auto save current session when Neovim quits
            autosave_on_change_dir = true, -- Auto save current session when directory changes
            autosave_on_session_substitute = true, -- Auto save current session before loading another
            autosave_on_switch_buffer = false, -- Auto save when switching buffers (can be noisy, disable if not needed)
            autosave_ignore_not_normal = true,

            -- Directory where sessions are saved
            session_dir = vim.fn.stdpath('data') .. '/sessions/',

            -- Naming strategy for sessions
            -- 'basename': uses the directory name (e.g., 'my-project')
            -- 'current_dir': uses the full path (e.g., '~/projects/my-project')
            -- 'git_branch': uses the git branch name (if in a git repo)
            dir_name_source = 'basename', -- or 'current_dir', 'git_branch'

            -- Custom session names (useful for non-project sessions)
            -- { 'name': 'custom-session-1', 'path': '/some/path' }
            -- { 'name': 'scratchpad', 'path': vim.fn.expand('~') }
            whitelist_dir = nil, -- Table of directories to explicitly allow creating sessions
            blacklist_dir = nil, -- Table of directories to explicitly disallow creating sessions
            -- For example:
            -- blacklist_dir = { vim.fn.expand('~'), vim.fn.expand('~') .. '/Downloads' }

            -- UI for session selection (if Telescope is installed)
            load_on_startup = true, -- Load the last session on startup
            autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Autoload mode for session

            -- Telescope integration
            -- If true, it will integrate with Telescope. You'll use :Telescope sessions
            -- If false, it will provide its own simple UI.
            telescope_integration = true,
            -- ... other options, check plugin docs
        })

        -- Optional: Keybindings for convenience
        vim.keymap.set('n', '<leader>ss', '<cmd>SessionManager save_current_session<CR>', { desc = 'Save current session' })
        vim.keymap.set('n', '<leader>sl', '<cmd>SessionManager load_last_session<CR>', { desc = 'Load last session' })
        vim.keymap.set('n', '<leader>so', '<cmd>SessionManager load_session<CR>', { desc = 'Open session picker' })
        vim.keymap.set('n', '<leader>sd', '<cmd>SessionManager delete_session<CR>', { desc = 'Delete session' })
    end
}
