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
Plugin 'jiangmiao/auto-pairs'
Plugin 'preservim/nerdcommenter'
Plugin 'tpope/vim-fugitive' " Git
Plugin 'junegunn/gv.vim' " Show commits
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Disabled Plugins
" Plugin 'neoclide/coc.nvim', {'branch': 'release'}
" Plugin 'ycm-core/YouCompleteMe.git'
" Plugin 'lervag/vimtex'
" Plugin 'Xuyuanp/nerdtree-git-plugin'
" Plugin 'mbbill/undotree'
" Plugin 'cakebaker/scss-syntax.vim'
" Plugin 'ryanoasis/vim-devicons'
" Plugin 'mattn/emmet-vim'
" Plugin 'kamykn/spelunker.vim'
" Plugin 'tomlion/vim-solidity'
" Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'vimwiki/vimwiki'
" Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plugin 'junegunn/fzf.vim'
" Plugin 'Valloric/MatchTagAlways.git'

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
set fileencoding=utf8
set encoding=utf8

" List all items and start selecting matches in cmd completion
if has("gui_macvim")
  set wildmode=long:full:full
endif

" Use mouse to select and resize windows, etc.
if has('mouse')
    set mouse=nv          " Enable mouse in several mode
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
set belloff=all

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
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

" Spell EN, ES
set spelllang=en,es  " Spell languages

" Increment search
set incsearch

" Keep more info in memory to speed things up
set hidden
set history=100

" Scroll off
set scrolloff=8

" Fix syntax highlight
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

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
"#######################################################################

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

" Disable vimwiki format for json files
" augroup noformat_json_file
  " autocmd!
  " autocmd BufEnter,BufRead,BufNewFile *.md setlocal filetype=markdown nonumber
  " autocmd BufEnter,BufRead,BufNewFile *.json setlocal filetype=json nonumber
" augroup END

" Return to last edit position when opening a file
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END

" Create own custom autogroup to enable spelunker.vim for specific filetypes.
" augroup spelunker
  " autocmd!
  " " Setting for g:spelunker_check_type = 1:
  " autocmd BufWinEnter,BufWritePost *.txt,*.md,vimrc call spelunker#check()

  " " Setting for g:spelunker_check_type = 2:
  " autocmd CursorHold *.txt,*.md,vimrc call spelunker#check_displayed_words()
" augroup END
"#######################################################################

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

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Decrease indent level in insert mode with shift+tab
inoremap <S-Tab> <ESC><<i

nnoremap <up> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <down> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <right> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <left> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>

" Adds current datetime
nnoremap <F5> "=strftime("%a %d %b %Y")<CR>P
inoremap <F5> <C-R>=strftime("%a %d %b %Y")<CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>

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
    set guifont=Hack\ Nerd\ Font:h14
  elseif has("gui_win32")
    set guifont=Source\ Code\ Pro:h12
  endif
endif
"#######################################################################

"#################### Plugins Configurations ###########################

" ========== Lightline =========="
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'readonly': 'LightlineReadonly',
      \   'filename': 'LightlineFilename',
      \   'mode': 'LightlineMode'
      \ },
      \ }

function! LightlineReadonly()
  return &readonly && &filetype !~# '\v(help|vimfiler|unite)' ? 'RO' : ''
endfunction

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

function! LightlineMode()
  return expand('%:t') =~# '^__Tagbar__' ? 'Tagbar':
        \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
        \ &filetype ==# 'unite' ? 'Unite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ lightline#mode()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" Do not show mode on command line since vim-airline can show it
set noshowmode
" ========== End Lightline =========="

" ========== NerdTree =========="
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-m> :NERDTreeFind<CR>
" nnoremap <leader>t :NERDTreeToggle<CR>
" nnoremap <leader>m :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="right"
let NERDTreeWinSize=40
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', 'node_modules']
" Close the tab if NERDTree is the only window remaining in it.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
      \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
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
let MRU_Max_Entries = 20
map <leader>f :MRU<CR>
" ======== End MRU ========"

" ========== ALE =========="
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['prettier']
\}
let g:ale_fix_on_save = 1
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gy :ALEGoToTypeDefinition -vsplit<CR>
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
" let g:ycm_auto_hover = -1
" let s:ycm_hover_popup = -1
" function s:Hover()
  " let response = youcompleteme#GetCommandResponse( 'GetDoc' )
  " if response == ''
    " return
  " endif

  " call popup_hide( s:ycm_hover_popup )
  " let s:ycm_hover_popup = popup_atcursor( balloon_split( response ), {} )
" endfunction
" nnoremap <silent> <leader>D :call <SID>Hover()<CR>
" " set previewpopup=height:10,width:60,highlight:PMenuSbar " I see error here
" set completeopt+=popup
" set completepopup=height:25,width:80,border:on,highlight:PMenuSbar
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
" let g:ycm_key_list_select_completion   = ['<C-j>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
" ======== End UltiSnip - Snippets ========"

" ========== Vimtex =========="
" let g:tex_flavor = 'latex'
" ======= End Vimtex ========"

" ========== Fugitive =========="
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gC :Gcommit -n<CR> " commit but ignore hooks
nnoremap <leader>gP :Git push<CR>
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

" ========== Coc =========="
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? "\<C-n>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
  " let col = col('.') - 1
  " return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> to trigger completion.
" if has('nvim')
  " inoremap <silent><expr> <c-space> coc#refresh()
" else
  " inoremap <silent><expr> <c-@> coc#refresh()
" endif

" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              " \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" let g:coc_global_extensions = ['coc-tsserver', 'coc-html', 'coc-css' , 'coc-json', 'coc-git', 'coc-snippets']
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      " \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
  " if (index(['vim','help'], &filetype) >= 0)
    " execute 'h '.expand('<cword>')
  " elseif (coc#rpc#ready())
    " call CocActionAsync('doHover')
  " else
    " execute '!' . &keywordprg . " " . expand('<cword>')
  " endif
" endfunction

" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? coc#_select_confirm() :
      " \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ coc#refresh()

" function! s:check_back_space() abort
  " let col = col('.') - 1
  " return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" let g:coc_snippet_next = '<tab>'
" ========== End Coc =========="

" ========== Vim Wiki =========="
" let g:vimwiki_list = [{'path': '~/.vimwiki/', 'syntax': 'default', 'ext': '.txt'}]
"let g:vimwiki-option-auto_toc = 1
"let g:vimwiki-option-list_margin = 0
" let g:vimwiki_hl_headers=1
" let g:vimwiki_hl_cb_checked=1
" hi VimwikiCode term=bold ctermfg=Cyan guifg=#80a0ff gui=bold
" hi VimwikiPre term=bold ctermfg=Cyan guifg=#80a0ff gui=bold
" hi VimwikiBold term=bold ctermfg=Cyan guifg=#80a0ff gui=bold
" hi VimwikiItalic term=italic ctermfg=Red guifg=#cc0000 gui=italic
" ======== End Vim Wiki ========"

" ========== UndoTree ==========
" nnoremap <F5> :UndotreeToggle<CR>
" ======== End UndoTree ========"

" ========== Spelunker ==========
" let g:spelunker_check_type = 2
" let g:spelunker_disable_uri_checking = 1
" let g:spelunker_disable_email_checking = 1
" let g:spelunker_disable_account_name_checking = 1
" let g:spelunker_disable_acronym_checking = 1
" let g:spelunker_disable_backquoted_checking = 1
" let g:spelunker_spell_bad_group = 'SpelunkerSpellBad'
" let g:spelunker_complex_or_compound_word_group = 'SpelunkerComplexOrCompoundWord'
" highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
" highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE
" ======== End Spelunker ========"

