call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sbdchd/neoformat'
Plug 'zchee/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-clang'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/SimpylFold'
Plug 'ajmwagar/vim-deus'
Plug 'scrooloose/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
call plug#end()

let g:airline_theme='deus'
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
colorscheme deus
:set number

let g:rustfmt_autosave=1

let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'cpp': ['clang'],
    \ 'c': ['clang']
\}

let g:rustfmt_autosave=1
let g:neoformat_c_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4, BreakBeforeBraces: Allman}"']
\}
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4, BreakBeforeBraces: Allman}"'],
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
set mouse=c
:set tabstop=4
:set shiftwidth=4
:set expandtab
:command WQ wq
:command Wq wq
:command W w
:command Q q
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l
:tnoremap <Esc> <C-\><C-n>
