""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My Ultimate Vim Configuration
" https://github.com/cmgustavo/dotfiles/blob/main/vimrc
" 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"####################### Plugins Settings ##############################
set nocompatible   " be iMproved, required
filetype off       " required

if has("gui_win32")
  set shellslash
  set rtp+=$HOME/vimfiles/bundle/Vundle.vim
  call vundle#begin('$HOME/vimfiles/bundle')
else
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
endif

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Active Plugins
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree.git'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'itchyny/lightline.vim'
Plugin 'yegappan/mru'
Plugin 'dense-analysis/ale'
Plugin 'ycm-core/YouCompleteMe.git'
Plugin 'jiangmiao/auto-pairs'
Plugin 'preservim/nerdcommenter'
Plugin 'tpope/vim-fugitive' " Git
Plugin 'junegunn/gv.vim' " Show commits
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'lervag/vimtex'
Plugin 'Valloric/MatchTagAlways.git'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'  

" Disabled Plugins
" Plugin 'mbbill/undotree'
" Plugin 'cakebaker/scss-syntax.vim'
" Plugin 'Xuyuanp/nerdtree-git-plugin'
" Plugin 'ryanoasis/vim-devicons'
" Plugin 'mattn/emmet-vim'
" Plugin 'kamykn/spelunker.vim'
" Plugin 'tomlion/vim-solidity'
" Plugin 'vimwiki/vimwiki'

call vundle#end()
"#######################################################################

"############################## Basic ###################################
filetype plugin indent on
syntax enable

" Set height of status line
set laststatus=2

" Auto readload file if it changed
set autoread

" General tab settings
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" Show matching parenthesis
set showmatch

" Show line number
set number

" Highlight search
set hlsearch

" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase

" File and script encoding settings for vim
set fileencoding=utf-8
set encoding=utf-8

" List all items and start selecting matches in cmd completion
if has("gui_macvim")
  set wildmode=long:full:full
endif

" Show current line where the cursor is
set cursorline

" Use mouse to select and resize windows, etc.
if has('mouse')
    set mouse=nv          " Enable mouse in several mode
    set mousemodel=popup  " Set the behaviour of mouse
endif

" Fileformats to use for new files
set fileformats=unix,dos

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Disable all blinking:
set guicursor+=a:blinkon0

" Wildmenu completion
set wildmenu

" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled speolling world list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX SHIT"
set wildignore+=*.luac "Lua byte code"
set wildignore+=migrations "Django migrations"
set wildignore+=*.pyc "Python Object codes"
set wildignore+=*.orig "Merge resolution files"
set wildignore+=package-lock.json "Javascript"
set wildignore+=*/node_modules "Javascript"
set wildignore+=*/plugins "Javascript"
set wildignore+=*/platforms "Javascript"
set wildignore+=*/coverage "Javascript"
set wildignore+=*/desktop "NW.js"
set wildignore+=*/cache "NW.js"
set wildignore+=*/resources "Copay"
set wildignore+=*/www "Copay"
set wildignore+=*/dist "Copay"
set wildignore+=*/tmp/*,*.so,*.zip

" Do not use visual and error bells
set novisualbell noerrorbells

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Allow delete with backspace
set backspace=indent,eol,start

" Persistent undo even after you close a file and re-open it.
" For vim, we need to set up an undodir so that $HOME is not cluttered with
" undo files.
if !has('nvim')
    if !isdirectory($HOME . '/.local/vim/undo')
        call mkdir($HOME . '/.local/vim/undo', 'p', 0700)
    endif
    set undodir=~/.local/vim/undo
endif
set undofile

" Completion behaviour
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt-=preview  " Disable the preview window

" Scan files given by `dictionary` option
set complete+=k,kspell complete-=w complete-=b complete-=u complete-=t

set spelllang=en  " Spell languages

" Increment search
set incsearch

" Keep more info in memory to speed things up
set hidden
set history=50

"#######################################################################

"############################ Functions #################################
function! InsertConsoleLog()
  let word = expand("<cword>")
  let linenumber = line(".")
  execute "normal A \<BS>\<CR>\<ESC>0Aconsole.log('[" . expand('%:t'). ":" .linenumber. "]',".word."); \/* TODO *\/"
endfunction

map <silent> ,v :call InsertConsoleLog()<CR>bbbbi

"############################ Variables #################################
let mapleader = ','
#######################################################################

"########################## Auto commands ###############################
" Set textwidth for text file types
augroup text_file_width
    autocmd!
    " Sometimes, automatic filetype detection is not right, so we need to
    " detect the filetype based on the file extensions
    autocmd BufNewFile,BufRead *.md,*.MD,*.markdown,*.txt setlocal textwidth=79
augroup END

" No line number for txt
augroup noline_number_txt
  autocmd!
  autocmd BufNewFile,BufRead *.txt setlocal nonumber
augroup END

" Return to last edit position when opening a file
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END
#######################################################################

"####################### Custom key mappings ############################
" used by vim-sneak
nnoremap ; :
xnoremap ; :

" Quicker way to open command window
nnoremap q; q:

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Shortcut for faster save and quit
nnoremap <silent> <leader>w :update<CR>
" Saves the file if modified and quit
nnoremap <silent> <leader>q :x<CR>
" Quit all opened buffers
nnoremap <silent> <leader>Q :qa<CR>

" Close a buffer and switching to another buffer, do not close the
" window, see https://goo.gl/Wd8yZJ
nnoremap <silent> \d :bprevious <bar> bdelete #<CR>

" Switch to latest buffer opened
if has("gui_win32")
  map <M-*> :b#<CR>
else
  map <D-*> :b#<CR>
endif

" Toggle spell checking
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>

" Decrease indent level in insert mode with shift+tab
inoremap <S-Tab> <ESC><<i

nnoremap <up> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <down> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <right> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <left> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>

" Adds current datetime
nnoremap <F5> "=strftime("%a %d %b %Y")<CR>P
inoremap <F5> <C-R>=strftime("%a %d %b %Y")<CR>

" Tabs window
if has("gui_macvim")
  " Press Ctrl-Tab to switch between open tabs (like browser tabs) to
  " the right side. Ctrl-Shift-Tab goes the other way.
  noremap <C-Tab> :tabnext<CR>
  noremap <C-S-Tab> :tabprev<CR>

  " Switch to specific tab numbers with Command-number
  noremap <D-1> :tabn 1<CR>
  noremap <D-2> :tabn 2<CR>
  noremap <D-3> :tabn 3<CR>
  noremap <D-4> :tabn 4<CR>
  noremap <D-5> :tabn 5<CR>
  noremap <D-6> :tabn 6<CR>
  noremap <D-7> :tabn 7<CR>
  noremap <D-8> :tabn 8<CR>
  noremap <D-9> :tabn 9<CR>
  " Command-0 goes to the last tab
  noremap <D-0> :tablast<CR>
endif

" Disable highlight or Cancel search with ESC
if has("gui_running")
  nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
else
  map <silent> <leader><cr> :noh<cr>
endif

"#######################################################################

"######################### UI Settings #################################
colorscheme gruvbox
set background=dark

if has("gui_running")
  set cursorline
" Removing scrollbars
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set guioptions+=a
  set guioptions-=m
else
  set t_Co=256
endif

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Monospace\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h12
  elseif has("gui_win32")
    set guifont=Consolas:h12:cANSI
  endif
endif
"#######################################################################

"#################### Plugins Configurations ###########################

" ========== Lightline =========="
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Do not show mode on command line since vim-airline can show it
set noshowmode
" ========== End Lightline =========="

" ========== NerdTree =========="
map <leader>nn :NERDTreeToggle<cr>
map <leader>nc :NERDTreeToggle Copay<cr>
map <leader>nf :NERDTreeFocus<cr>
nnoremap <silent> <Leader>mm :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', 'node_modules']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" ========== End NerdTree =========="
"
" ========== BufExplorer =========="
if has("gui_win32")
  nnoremap <silent> <M-+> :BufExplorer<CR>
else
  nnoremap <silent> <D-+> :BufExplorer<CR>
endif
" ======== End BufExplorer ========"

" ========== MRU =========="
let MRU_Max_Entries = 50
map <leader>f :MRU<CR>
" ======== End MRU ========"

" ========== ALE =========="
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['prettier']
\}
let g:ale_fix_on_save = 1
nnoremap <leader>aa :ALEGoToDefinition<CR>
nnoremap <leader>av :ALEGoToDefinitionInVSplit<CR>
nmap ]w :ALENextWrap<CR>
nmap [w :ALEPreviousWrap<CR>
augroup VimDiff
  autocmd!
  autocmd VimEnter,BufEnter,FilterWritePre * if &diff | ALEDisable | endif
augroup END
let g:ale_pattern_options = {
\   '.*\.json$': {'ale_enabled': 0},
\   '.*\.java$': {'ale_enabled': 0},
\   '.*\.m$': {'ale_enabled': 0},
\   '.*\.h$': {'ale_enabled': 0},
\   '.*\.xml$': {'ale_enabled': 0},
\   '.*\.md$': {'ale_enabled': 0},
\   '.*\.txt$': {'ale_enabled': 0},
\   '.*www/.*\.js$': {'ale_enabled': 0},
\}
" ======== End ALE ========"

" ========== YouCompleteMe =========="
" ======== End YouCompleteMe ========"

" ========== NerdCommenter =========="
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" ======== End NerCommenter ========="

" ========== Auto-Pairs =========="
au Filetype html let b:AutoPairs = AutoPairsDefine({'<!--' : '-->'})
au Filetype txt let b:AutoPairs = {"(": ")"}
" ======== End Auto-Pairs ========"
 
" ========== Ctrl P =========="
if has("gui_win32")
  set runtimepath^=$HOME/vimfiles/bundle/ctrlp.vim
  let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows
else
  let g:ctrlp_user_command = 'find %s -type f'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
endif
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" ======= End Ctrl P ========"

" ========== UltiSnip - Snippets =========="
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<C-b>'
let g:UltiSnipsJumpBackwardTrigger     = '<C-z>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
" ======== End UltiSnip - Snippets ========"

" ========== Vimtex =========="
let g:tex_flavor = 'latex'
" ======= End Vimtex ========"

" ========== Fugitive =========="
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gC :Gcommit -n<CR> " commit but ignore hooks
nnoremap <leader>gP :Gpush<CR>
nnoremap <leader>gfP :Gpush --force-with-lease<CR>
nnoremap <leader>gp :Gpull<CR>
nnoremap <leader>gf :Gfetch<CR>
nnoremap <leader>gl :GV!<CR> " Git log for the current file
nnoremap <leader>gL :GV<CR> " Full git log
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gm :Git checkout master<CR>
nnoremap <leader>g- :Git checkout -<CR>
nnoremap <leader>grm :Grebase -i master<CR>
" ======== End Fugitive ========"

"#######################################################################
