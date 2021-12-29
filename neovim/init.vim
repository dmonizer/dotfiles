" USAGE:
" 
" install vim-plug from 'https://github.com/junegunn/vim-plug' 
" for linux: 
"   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" if nvim --version is old (ie raspberry with debian buster having 0.3.x
" something) use snap to install newer (https://snapcraft.io/install/nvim/raspbian#install)
"
" install required utils:
" - sudo apt install fd-find

"   for python code reformatting
" - pip install autopep8

"   for javascript linting
" - sudo npm i eslint -g
" copy this file to ~/.config/nvim/init.vim
" run nvim (getting errors), exit, run again (still errors) 
" type :PlugInstall
" restart nvim, 
" type :checkhealth and see if any errors appear, resolve these.
" enjoy!
" sourced partly from https://github.com/zyedidia/dotvim/blob/master/init.vim
"
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
    let g:tern_request_timeout = 1
    let g:tern_request_timeout = 6000

    Plug 'ludovicchabant/vim-gutentags'
    " Docs https://github.com/neoclide/coc.nvim/blob/master/doc/coc.txt
    " https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'rebelot/kanagawa.nvim'
    " :CocList commands
    let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-snippets']  " list of CoC extensions needed
    " coc-prettier docs: https://prettier.io/docs/en/vim.html
    
    Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {
    Plug 'itchyny/lightline.vim'
    Plug 'taohexxx/lightline-buffer'

    " :colorscheme landscape
    Plug 'itchyny/landscape.vim'
    
    " javascript stuff
    Plug 'yuezk/vim-js'

    " :Telescope
    Plug 'BurntSushi/ripgrep'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    Plug 'sharkdp/fd'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    
    " Find files using Telescope command-line sugar.
    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>

    " :Cheatsheet
    " https://github.com/sudormrfbin/cheatsheet.nvim/blob/master/README.md
    Plug 'sudormrfbin/cheatsheet.nvim'
    Plug 'nvim-lua/popup.nvim'

    Plug 'neomake/neomake'

call plug#end()

syntax on 		" Turn on syntax highlighting

filetype on " make nvim try to detect file types and load plugins for them
filetype plugin on
filetype indent on

set encoding=utf-8
set fileencoding=utf-8

set fileformat=unix
set fileformats=unix,dos,mac
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set number  
set ruler               " Show the line and column numbers of the cursor.

" if coc displays warning on startup on old version, and you cannot upgrade
" for some reason, uncomment next line

" let g:coc_disable_startup_warning = 1

if &t_Co >= 256 || has("gui_running")
    colorscheme kanagawa
endif

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" :h hidden
set hidden

set showmatch         " Show matching braces
set mat=1             " Set the time to show matching braces to 1 second
set hlsearch          " switch on highlighting for the last used search pattern
set showcmd           " Show the current command in the bottom right
set number            " Show line numbers
set autoindent        " Use autoindentation
set wrap              " Wrap long lines
set omnifunc=syntaxcomplete#Complete " Enable omnicompletion
set autowrite         " Automatic save

set backup
if !isdirectory($HOME . "/.config/nvim/backup")
    call mkdir($HOME . "/.config/nvim/backup", "p")
endif
set backupdir=~/.config/nvim/backup

" saves undo information over restarts/closings
set undofile

"  'p' to paste, 'gv' to re-select what was originally selected. 'y' to copy it again.
"  from: https://stackoverflow.com/questions/7163947/paste-multiple-times
xnoremap p pgvy 


let g:neomake_javascript_enabled_makers = ['eslint']
call neomake#configure#automake('w') " When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750) " When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000) 
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrwi', 500)
let g:neomake_open_list = 2 " make Neomake to open the list automatically

" key re-mappings
" see https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)#Introduction

" shift+arrow selection
" from: https://stackoverflow.com/questions/9721732/mapping-shift-arrows-to-selecting-characters-lines
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>

" remapping of copy/paste to ctrl-c/v, undo with ctrl-z
vmap <C-c> y<Esc>i
vmap <C-x> d<Esc>i
map <C-v> pi
imap <C-v> <Esc>pi
imap <C-z> <Esc>ui

" remapping of intendation (tab, shift-tab) in all modes
nnoremap <Tab> >><Right>
nnoremap <S-Tab> <<<W>
inoremap <S-Tab> <C-D>
vnoremap <S-Tab> <gv

" read: 
" https://dev.to/iggredible/using-buffers-windows-and-tabs-efficiently-in-vim-56jc
" https://stackoverflow.com/questions/53664/how-to-effectively-work-with-multiple-files-in-vim
" map ctrl-alt-left/right to prev/next buffer
noremap <C-M-Left> :bp<CR>
noremap <C-M-Right> :bn<CR>
noremap <C-M-Home> :bfirst<CR>
noremap <C-M-End> :blast<CR>

" control-shift-E - show list of opened (historically) files
noremap <C-S-E> :Telescope oldfiles<CR>

" control-e - show list of currently open buffers
noremap <C-E> :Telescope buffers<CR>

" map control-shift-up/down to move line(s) (of block) up or down
nnoremap <C-S-Down> :m .+1<CR>==
nnoremap <C-S-Up> :m .-2<CR>==
inoremap <C-S-Down> <Esc>:m .+1<CR>==gi
inoremap <C-S-Up> <Esc>:m .-2<CR>==gi
vnoremap <C-S-Down> :m '>+1<CR>gv=gv
vnoremap <C-S-Up> :m '<-2<CR>gv=gv

" create command Prettier to reformat current file
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" map Alt-Control-L to Prettier command
noremap <M-C-L>  :Prettier<CR>

" documentation of symbol under cursor (default <leader> is \)
nnoremap <silent> <C-Q> :call CocActionAsync('doHover')<cr>

noremap <C-O> :E<CR>
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis
                 \ | wincmd p | diffthis
endif

nnoremap <F9> :make %<CR>

augroup runcommand
    au BufEnter,BufNew *.js setlocal makeprg="npm start"
    au BufEnter,BufNew *.py setlocal makeprg=python

augroup END
