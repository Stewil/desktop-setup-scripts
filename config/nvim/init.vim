call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sbdchd/neoformat'
Plug 'zchee/deoplete-jedi'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/SimpylFold'
Plug 'ajmwagar/vim-deus'
Plug 'scrooloose/syntastic'
Plug 'rust-lang/rust.vim'
call plug#end()

let g:airline_theme='deus'
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
colorscheme deus
:set number

let g:rustfmt_autosave=1
