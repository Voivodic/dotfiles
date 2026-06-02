return {
    'rebelot/terminal.nvim',
    name = 'terminal',
    config = function()
        -- Terminal mappings
        local term_map = require("terminal.mappings")
        vim.keymap.set({ "n", "x" }, "<leader>ts", term_map.operator_send, { expr = true, desc = 'Terminal: Send' })
        vim.keymap.set("n", "<leader>to", term_map.toggle, { desc = 'Terminal: Toggle' })
        vim.keymap.set("n", "<leader>tO", term_map.toggle({ open_cmd = "enew" }), { desc = 'Terminal: Toggle (New Buffer)' })
        vim.keymap.set("n", "<leader>tr", term_map.run, { desc = 'Terminal: Run' })
        vim.keymap.set("n", "<leader>tR", term_map.run(nil, { layout = { open_cmd = "enew" } }), { desc = 'Terminal: Run (New Buffer)' })
        vim.keymap.set("n", "<leader>tk", term_map.kill, { desc = 'Terminal: Kill' })
        vim.keymap.set("n", "<leader>t]", term_map.cycle_next, { desc = 'Terminal: Cycle Next' })
        vim.keymap.set("n", "<leader>t[", term_map.cycle_prev, { desc = 'Terminal: Cycle Prev' })
        vim.keymap.set("n", "<leader>tl", term_map.move({ open_cmd = "belowright vnew" }), { desc = 'Terminal: Move (V-Split Below Right)' })
        vim.keymap.set("n", "<leader>tL", term_map.move({ open_cmd = "botright vnew" }), { desc = 'Terminal: Move (V-Split Bottom Right)' })
        vim.keymap.set("n", "<leader>th", term_map.move({ open_cmd = "belowright new" }), { desc = 'Terminal: Move (H-Split Below Right)' })
        vim.keymap.set("n", "<leader>tH", term_map.move({ open_cmd = "botright new" }), { desc = 'Terminal: Move (H-Split Bottom Right)' })
        vim.keymap.set("n", "<leader>tf", term_map.move({ open_cmd = "float" }), { desc = 'Terminal: Move (Float)' })

        -- Create a new terminal window in the bottom quarter of the screen
        local function open_quarter_terminal()
            -- 1. Calculate 25% height of the screen
            local total_height = vim.o.lines - vim.o.cmdheight
            local quarter_height = math.floor(total_height * 0.25)

            -- 2. Create an empty scratch buffer first (unlisted, scratchpad)
            local buf = vim.api.nvim_create_buf(false, true)

            -- 3. Open that specific buffer in a full-width bottom split layout
            local win = vim.api.nvim_open_win(buf, true, {
                split = "below",
                height = quarter_height,
                win = -1, -- Global layout framework (acts like 'botright')
            })

            -- 4. Spawn the interactive shell process inside that exact buffer window
            -- This guarantees no duplicate windows can pop up
            vim.fn.termopen(vim.o.shell)

            -- 5. Drop straight into terminal insert mode so you can type immediately
            vim.cmd("startinsert")
        end
        vim.keymap.set("n", "<leader>tt", open_quarter_terminal, { desc = "Clean 1/4 Bottom Terminal" })


        -- Remap to go from terminal mode to normal mode
        vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Terminal: Normal Mode' })

        -- Remaps for window navigation from terminal mode
        vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Terminal: Window Left' })
        vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Terminal: Window Down' })
        vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Terminal: Window Up' })
        vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Terminal: Window Right' })

        require("terminal").setup({})
    end
}
