" Neovim configuration file
"
" ~/.config/nvim/init.vim
"

"" Enter the 21st Century
if &compatible
  set nocompatible
endif
syntax enable
filetype plugin on

" Set default encoding and localizations
set encoding=utf-8
set fileencoding=utf-8
set spelllang=en_us

"" Personnal preferences

" Setup color scheme
colorscheme murphy

" Allow :find and gf to use recursive sub-folders
set path+=**
set hidden

" More powerful backspacing
set backspace=indent,eol,start

" Make tab completion in command mode more efficient
set wildmenu
:q
set wildmode=longest:full,full

" Set default tabstops and replace tabs with spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Misc. configurations
set history=10000   " Number lines of command history to keep
set mouse=n         " Enable mouse for normal mode only
set scrolloff=3     " Keep cursor away from top/bottom of window
set nowrap          " Don't wrap lines
set sidescroll=1    " Horizontally scroll nicely
set sidescrolloff=5 " Keep cursor away from side of window
set splitbelow      " Horizontally split below
set splitright      " Vertically split to right
set ruler           " Show line/column info
set laststatus=2    " Allows show the status line
set hlsearch        " Highlight / search results after <return>
set incsearch       " Highlight / search matches as you type
set ignorecase      " Case insensitive search, unless
set smartcase       " ... unless query has caps
set nrformats=bin,hex,octal " bases used for <ctrl-a> & <ctrl-x>,
set nrformats+=alpha        " also single letters too

"" Setup plugins

" Setup the Plug plugin manager
"
" Bootstrap manually by installing it into the right place:
"
"   $ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
"
" and then from within nvim run
"
"   :PlugInstall
"
" Plug Commands:
"   :PlugInstall [name ...] [#threads] Install plugins
"   :PlugUpdate [name ...] [#threads]  Install or update plugins
"   :PlugClean[!]           Remove unlisted plugins
"   :PlugUpgrade            Upgrade Plug itself
"   :PlugStatus             Check the status of plugins
"   :PlugDiff               Diff previous update and pending changes
"   :PlugSnapshot[!] [path] Generate script to restore current plugin state
"
call plug#begin('~/.local/share/nvim/plugged')

" Provide syntax checking for a variety of languages
Plug 'vim-syntastic/syntastic'

" Provide Rust file detection, syntax highlighting,
" formatting, syntastic integration, and more
Plug 'rust-lang/rust.vim'

" Extend */# functionality while in visual mode
Plug 'nelstrom/vim-visual-star-search'

" Surrond text objects with matching (). {}. '', etc
Plug 'tpope/vim-surround'

" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Indent text objects; defines 2 new text objects
" based on indentation levels, i and I
Plug 'michaeljsmith/vim-indent-object'

" Visualizes undo history; switch between undo branches
Plug 'mbbill/undotree'

" Shows what is in registers
" extends " and @ in normal mode and <ctrl-r> in insert mode
Plug 'junegunn/vim-peekaboo'

" Extend <ctrl-a> and <ctrl-x> to work
" with dates and not just numbers.
Plug 'tpope/vim-speeddating'

call plug#end()

" Configure user settings for Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cursor_column = 0
let g:syntastic_enable_balloons = 0

" Force all files ending in .md, besides just README.md,
" to be intepreted as MarkDown and not Modula-2
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"" Set up key mappings

" Define <Leader> explicitly as a space
nnoremap <space> <nop>
let mapleader = "\<space>"

" Clear search highlighting
nnoremap <leader><space> :nohlsearch<return>

" Toggle Synastic into and out of passive mode
nnoremap <leader>st :SyntasticToggleMode<return>

" Reassign Q in normal mode to apply macro stored in register q
" note: default behavior of Q causes EX-mode
nnoremap Q @q

" Get rid of all trailing spaces for entire buffer
nnoremap <leader>w :%s/ \+$//<return>

" Toggle between 3 line numbering states via <leader>n
set nonumber
set norelativenumber

function! MyLineNumberToggle()
  if(&relativenumber == 1)
    set nonumber
    set norelativenumber
  elseif(&number == 1)
    set nonumber
    set relativenumber
  else
    set number
    set norelativenumber
  endif
endfunction

nnoremap <leader>n :call MyLineNumberToggle()<return>

