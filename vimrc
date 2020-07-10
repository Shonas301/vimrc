set number                      " show current line number even in relative mode
filetype off
syntax enable

imap ;; <ESC>
imap jj <ESC>

call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'digitaltoad/vim-jade'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'kchmck/vim-coffee-script'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nanotech/jellybeans.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'raimondi/delimitmate'
Plug 'roman/golden-ratio'
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-surround'
Plug 'wincent/Command-T'
Plug 'tomlion/vim-solidity'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'fatih/vim-go'
Plug 'aserebryakov/vim-todo-lists'
Plug 'sjl/vitality.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'dhruvasagar/vim-table-mode'
Plug 'psf/black', { 'tag': '19.10b0'}
call plug#end()
filetype plugin indent on       " fix html and js indenting

set autoindent
set autoread
set backspace=2                 " fix broken backspace in some setups
set clipboard=unnamed           " yank and paste with the system clipboard
set directory-=.                " don't store swapfiles in the current directory
set expandtab                   " expand tabs to spaces
set ignorecase                  " case-insensitive search
set incsearch                   " search as you type
set laststatus=2                " always show statusline
set ruler                       " show where you are
set scrolloff=3                 " show context above/below cursorline
set shiftwidth=4                " normal mode indentation commands use 2 spaces
set smartcase                   " case-sensitive search if any caps
set smartindent
set softtabstop=4               " insert mode tab and backspace use 2 spaces
set splitbelow
set splitright
set tabstop=8                   " actual tabs occupy 8 characters
set wildmode=longest:full
set wildchar=<Tab>
set wildmenu

" sets a colored column at 80 chars at a visual reference
set colorcolumn=80

" Add jellybean colorscheme
set t_Co=256
colorscheme jellybeans

let g:VimTodoListsMoveItems = 0 " disable .todo items moving upon completion

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" ############################ keyboard shortcuts ############################


"  vim splits
" easier mappings for switching panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" correct :W to :w, :Q to :q, & :Wq to :wq
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))

let mapleader = ','

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" fix my syntax highlightings
au BufNewFile,BufRead *.json.jbuilder set ft=ruby
au BufNewFile,BufRead *.ejs set ft=html
au BufNewFile,BufRead *.xm set filetype=objc
au BufNewFile,BufRead *.sol set ft=solidity
au BufNewFile,BufRead *.groovy set ft=groovy
au BufNewFile,BufRead *.tsx set ft=javascript

cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Set line ending on non-code files
au BufNewFile,BufRead *.txt set tw=80 spell
au BufNewFile,BufRead *.md set tw=80 spell
au BufNewFile,BufRead *.tex set tw=80

au BufNewFile,BufRead *.py setlocal foldmethod=indent
au BufNewFile,BufRead *.todo setlocal foldmethod=indent

" end go warnings
let g:go_version_warning = 0

" let g:syntastic_python_pylint_exec = 'python'
" let g:syntastic_python_pylint_args = ['-m', 'pylint']
autocmd Filetype gitcommit setlocal spell textwidth=72

au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w
let g:ycm_path_to_python_interpreter = '/usr/local/opt/python@3.8/bin/python3'
" let g:ycm_python_sys_path = []
" let g:ycm_extra_conf_vim_data = [
"   \  'g:ycm_python_interpreter_path',
"   \  'g:ycm_python_sys_path'
"   \]
" let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
let g:ycm_keep_logfiles = 0

set completeopt=menuone

au BufNewFile,BufRead *.yml set softtabstop=2 shiftwidth=2 " insert mode tab and backspace use 2 spaces
au BufNewFile,BufRead *.yml setlocal foldmethod=indent

" point black install to conda python
" let g:black_virtualenv = '/Users/jshipp6/anaconda3/envs/testconda/'
" auto run black on save
autocmd BufWritePre *.py execute ':Black'
