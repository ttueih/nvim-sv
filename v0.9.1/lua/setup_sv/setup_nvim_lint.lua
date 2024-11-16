return {
    {
        'mfussenegger/nvim-lint',
        -- While all of these events are set, only a few
        -- seem to actually trigger the linting process currently.
        -- This seems to be a bug/missing feature in nvim-lint itself.

        -- Long story short: you will most likely need to save to re-lint the file
        event = {
            'BufReadPre',
            'BufNewFile',
            'BufWritePost',
            'TextChanged', 
            'InsertLeave'
        },
        config = function()
            local lint = require 'lint'

            -- Include languages here
            -- require('setup_systemverilog').setupLinter(lint)
	    lint.linters_by_ft = {
		systemverilog = { 'verilator' },
		verilog = { 'verilator' },
	    }

	    local verilator = lint.linters.verilator

	    -- Add/change arguments for Verilator here.
	    -- You can also use or re-use a verilator.f file (see example\verilator.f)
	    -- placed anywhere between CWD and your home dir and it
	    -- will be read by Verilator
	    
	    -- The arguments below are the default provided by nvim-lint
	    -- (https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/verilator.lua)
	    -- with the exception of the '-f' and corresponding path to verilator.f
	    verilator.args = {
		"-sv",
		"-Wall",
		"--bbox-sys",
		"--bbox-unsup",
		"--lint-only",
		'-f',
		vim.fs.find('verilator.f', {upward = true, stop = vim.env.HOME})[1],
	    }

	    lint.linters.verilator = verilator

            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
                group = vim.api.nvim_create_augroup('nvim_lint', { clear = true }),
                callback = function()
                    vim.defer_fn(function()
                        -- try_lint() will run every linter configured with linters_by_ft().
                        -- See lua\setup_systemverilog.lua
                        lint.try_lint()
                    end, 1)
                end,
            })
        end,
    },
}
