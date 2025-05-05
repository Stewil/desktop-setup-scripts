-- https://neovim.io/doc/user/lua-guide.html
-- lua basics for nvim setup
-- vim.g.mapleader = "," is eq to local g:mapleader = ','
-- vim.g is a table for global variables
-- vim.fn is a table for functions
-- vim.api is a collection of api functions

-- begin lazynvim package manager
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            'theniceboy/nvim-deus',
        },
        {
            'windwp/windline.nvim',
            config = function()
                require('wlsample.airline')
            end,
        },
        {
            'neovim/nvim-lspconfig',
        },
        {
            "nvim-treesitter/nvim-treesitter",
            dependencies = {
                "nvim-treesitter/nvim-treesitter-refactor",
                "HiPhish/rainbow-delimiters.nvim"
            },
            build = ":TSUpdate",
            config = function()
                local configs = require("nvim-treesitter.configs")
                configs.setup({
                    ensure_installed = {
                        "c", "cpp", "lua", "python", "rust", "toml", "yaml",
                        "javascript", "css", "bash",
                    },
                    sync_install = false,
                    auto_install = true,
                    ignore_install = {},
                    modules = {},
                    highlight = {
                        enable = true,
                        disable = function(_lang, buf)
                            local max_filesize = 100 * 1024 -- 100 KB
                            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                            if ok and stats and stats.size > max_filesize then
                                return true
                            end
                        end,
                        additional_vim_regex_highlighting = false,
                    },
                    indent = { enable = true },
                    refactor = {
                        highlight_definitions = {
                            enable = true,
                            clear_on_cursor_move = true,
                        },
                    },
                    rainbow = {
                        enable = true,
                        query = "rainbow-parens",
                        strategy = {
                            [''] = 'rainbow-delimiters.strategy.global',
                        },
                    },
                })
            end
        },
        -- add your plugins here
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "deus" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
    rocks = { enabled = false },
})
-- end lazynvim

-- begin opts
-- vim.opt.encoding="utf-8" is eq to set encoding=utf-8
-- vim.o for global options, vim.wo for window options, vim.bo for buffer options
vim.opt.encoding = "utf-8"
vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
vim.opt.updatetime = 300
vim.opt.wildignorecase = true
vim.opt.number = true
--vim.opt.mouse = ''
vim.opt.mousescroll = 'ver:8,hor:1'
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.foldlevel = 100
-- foldmethods scoped to window
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- begin mappings
-- vim.keymap.set(MODE, TRIGGER, EXEC(or '' for nop)) for key maps
--  -> see :map-modes or :map! or :map
-- ->nav
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<C-h', '<Left>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<C-j', '<Down>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<C-k', '<Up>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<C-l', '<Right>', { noremap = true, silent = true })
-- -> normal
--vim.keymap.set({'n','i','c','v', 't'}, '<ScrollWheelUp>', '<Up>')
--vim.keymap.set({'n','i','c','v', 't'}, '<ScrollWheelDown>', '<Down>')
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<LeftMouse>', '')
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<LeftDrag>', '')
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<LeftRelease>', '')
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<RightMouse>', '')
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<RightDrag>', '')
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<RightRelease>', '')
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<MiddleMouse>', '')
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<MiddleDrag>', '')
vim.keymap.set({ 'n', 'i', 'c', 'v', 't' }, '<MiddleRelease>', '')
-- -> terminal
-- <C-\><C-N>
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l')
vim.keymap.set('t', '<ESC>', '<C-\\><C-N>')


-- begin autocommands
-- close completion preview
vim.api.nvim_create_autocmd(
    { 'InsertLeave', 'CompleteDone' },
    {
        pattern = { '*' },
        callback = function()
            vim.api.nvim_command('silent! pclose!')
        end
    })
-- disable coloscheme BG
vim.api.nvim_create_autocmd(
    { 'ColorScheme' },
    {
        pattern = { '*' },
        callback = function()
            vim.api.nvim_command('highlight Normal ctermbg=NONE guibg=NONE')
        end
    }
)
vim.cmd [[ colorscheme deus ]]

-- begin user commands
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})

vim.lsp.config['lua_ls'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
    },
    -- server-specific settings
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                -- recognise these globals
                globals = {
                    'vim',
                    'require'
                },
            },
            workspace = {
                checkThirdParty = false,
                -- make server aware of runtime files
                library = {
                    vim.api.nvim_get_runtime_file("", true),
                    "${3rd}/luv/library"
                }
            },
        },
    },
}

vim.lsp.config('clangd', {
    cmd = { 'clangd', '--enable-config=1' }
})

vim.lsp.config('pylsp', {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {
                        'C0301', -- line too long WAH
                    },
                },
                pyflakes = {
                    enabled = true,
                },
                pylint = {
                    enabled = true,
                },
            },
        }
    },
})

vim.lsp.enable('bashls')
vim.lsp.enable('clangd')
vim.lsp.enable('lua_ls')
--vim.lsp.enable('neocmake')
vim.lsp.enable('pylsp')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('taplo')

vim.api.nvim_create_user_command('DiagNext', function()
    vim.diagnostic.goto_next()
end, {})

vim.api.nvim_create_user_command('DiagPrev', function()
    vim.diagnostic.goto_prev()
end, {})

vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
function OpenDiagnosticIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
            return
        end
    end
    -- THIS IS FOR BUILTIN LSP
    vim.diagnostic.open_float(0, {
        scope = "cursor",
        focusable = false,
        close_events = {
            "CursorMoved",
            "CursorMovedI",
            "BufHidden",
            "InsertCharPre",
            "WinLeave",
        },
    })
end

-- IMPORTANT noselect with the completion or i will kill everything.
vim.cmd [[set completeopt+=menuone,noselect,popup]]
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then
            return
        end
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
        vim.diagnostic.config({
            virtual_text = false,
            underline = true,
            signs = true,
        })
        --vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        --    vim.lsp.diagnostic.on_publish_diagnostics, {
        --	    virtual_text = false,
        --	    underline = true,
        --	    signs = true,
        --})
        vim.api.nvim_create_user_command('LspFix', function()
            vim.lsp.buf.code_action({
                filter = function(a) return a.isPreferred end,
                apply = true
            })
        end, {})
        vim.api.nvim_create_user_command('LspFormat', function()
            vim.lsp.buf.format()
        end, {})
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI', 'CursorMoved' }, {
            callback = function()
                vim.diagnostic.open_float(nil, { focus = false })
                --vim.lsp.diagnostic.show_line_diagnostics()
            end
        })
        vim.api.nvim_create_autocmd('CursorHoldI', {
            callback = function()
                --vim.cmd [[ silent! lua vim.lsp.buf.signature_help() ]]
            end
        })
        -- Show diagnostics under the cursor when holding position
        vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold" }, {
            pattern = "*",
            command = "lua OpenDiagnosticIfNoFloat()",
            group = "lsp_diagnostics_hold",
        })
    end
})
