"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gustavo Cortez
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" PLUGINS

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'yegappan/mru'
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'morhetz/gruvbox'
Plug 'justinmk/vim-sneak'
Plug 'github/copilot.vim'
Plug 'airblade/vim-rooter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'vimwiki/vimwiki'
" Initialize plugin system.
call plug#end()

" Do not make vim compatible with vi.
set nocompatible

" Allow plugins to be used.
filetype plugin indent on

" Use syntax highlighting.
syntax on

" Always leave 10 rows below cursor.
set scrolloff=10

" Show cursor line.
set cursorline

" Not Show cursor column.
set nocursorcolumn

" Set title of window to the name of the file.
set title

" Backup files.
set backup

" Backup directory.
set backupdir=~/.vim/backup/

" Hide mouse when typing.
set mousehide

" Check to see if an external file has changed.
set autoread

" Split window with cursor in bottom window.
set splitbelow splitright

" Leave windows uneven after split or close.
set noequalalways

" Switch buffers without saving.
set hidden

" Show error bell visually.
set visualbell

" Set the text width.
set textwidth=80

" Allow backspacing to work as expected.
set backspace=indent,eol,start

" Tabbing over moves four spaces.
set tabstop=2

" Number of spaces to use in automatically indent.
set shiftwidth=2

" Copy indent from current line when starting a new line.
set autoindent

" Use C style indentation
set cindent

" Use space characters instead of tabs.
set expandtab

" Incremental search an you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for captial letters.
set smartcase

" Show the line and column position of cursor.
set ruler

" Show partial command in the last line of the screen.
set showcmd

" Show matching words.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the character enconding when writing file.
set fileencoding=utf8

" Set the character encoding.
set encoding=utf8

" Show auto complete menus.
set wildmenu

" Make wildmenu behave like bash completion.
set wildmode=longest:full,full

" Ignore files with these extentions.
set wildignore=*.odt,*.doc*,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.JPG,*.exe,*.bmp,*.flv,*.gz,*.tgz,*.zip,*.iso,*.gzip,*.mov,*.xz,*.tar,*.img,*.docx,*.xlsx,*.xls

" Temporary files.
set directory=/tmp

" Show popup documentation
set completeopt=menu,menuone,popup,noselect,noinsert

" Do not show -- INSERT ---
set noshowmode

" MAPPINGS

" Set the leader to '-' instead of the default '\'.
let mapleader = " "

" Enable syntax highlighting in markdown code blocks.
let g:markdown_fenced_languages = ['html', 'python', 'css', 'vim', 'rust', 'c', 'txt']

" Paste a block of code without formatting it.
nnoremap <mousemiddle> <esc>"*P

if has("gui_running")
  nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
else
  map <silent> <leader><cr> :noh<cr>
endif

noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>
nnoremap <silent> <leader>s :update<CR>
nnoremap <silent> <leader>q :x<CR>
nnoremap <up> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <down> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <right> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <left> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>

" Close the current buffer
map <leader>xx :bd<cr>

" Close all the buffers
map <leader>xa :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Close a buffer and switching to another buffer, do not close the
" window, see https://goo.gl/Wd8yZJ
nnoremap <silent> \d :bprevious <bar> bdelete #<CR>

" Map Ctrl-<Space> to / (search)
map <leader>f /

" Highlight words but do not jump
nnoremap * :keepjumps normal! mi*`i<CR>

" Fix syntax highlighting
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" PLUGINS CONFIGURATION

" MRU
let MRU_Max_Entries = 20
map <leader>r :MRU<CR>

" NerdTree
let NERDTreeIgnore=['\.jpg$', '\.mp4$', '\.zip$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.svg$', '\.gif$', '\.tar$', '\.gz$', '\.xz$', '\.bz2$', '\.db$', '\.vim$', '\~$', '\.pyc$', 'node_modules']
nnoremap <leader>0 :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-m> :NERDTreeFind<CR>
let NERDTreeMinimalUI=1
let NERDTreeShowBookmarks=1
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" BufExplorer
map <leader><tab> :b#<CR> " switch to latest buffer
nnoremap <silent> <leader>e :BufExplorer<CR>

" Vim rooter
" set autochdir and disable auto-vim-rooter
" let g:rooter_use_lcd = 1
let g:rooter_cd_cmd="lcd"
let g:rooter_manual_only = 1
set autochdir

" ALE
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['prettier', 'eslint'],
\   'typescriptreact': ['prettier', 'eslint'],
\   'scss': ['prettier'],
\   'css': ['prettier']
\}
let g:ale_fix_on_save = 1
nmap <silent> ge :ALEDetail<CR>
nmap <silent> gr :ALEFindReferences<CR>
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gy :ALEGoToTypeDefinition -vsplit<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
augroup VimDiff
  autocmd!
  autocmd VimEnter,BufEnter,FilterWritePre * if &diff | ALEDisable | endif
augroup END

" New format error msg
let g:ale_echo_msg_format = '[%severity%] %s'
" ALE completion
let ale_completion_enabled = 1
" Hide error details as Comment
let g:ale_virtualtext_cursor = 'highlight link ALEVirtualTextError'
" Remove left column with sign errors
"let g:ale_set_signs = 0
"set signcolumn=no


" Use Tab to select ALE suggestions
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Typescript
let g:typescript_indent_disable = 1
let g:typescript_opfirst='\%([<>=,?^%|*/&]\|\([-:+]\)\1\@!\|!=\|in\%(stanceof\)\=\>\)'
let g:vim_jsx_pretty_colorful_config = 1

" TSX plugin
let g:vim_jsx_pretty_template_tags = ['html', 'jsx', 'tsx']
let g:vim_jsx_pretty_highlight_close_tag = 1

" Nerdcommenter
let g:NERDSpaceDelims = 1

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gP :Git push<CR>
nnoremap <leader>gl :GV!<CR>
nnoremap <leader>gL :GV<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gm :Git checkout master<CR>

" Gitgutter
nmap <Leader>gn <Plug>(GitGutterNextHunk)  " git next
nmap <Leader>gp <Plug>(GitGutterPrevHunk)  " git previous
nmap <Leader>ga <Plug>(GitGutterStageHunk) " git add (chunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)  " git undo (chunk)
"set signcolumn=yes
"let g:gitgutter_override_sign_column_highlight = 2
highlight SignColumn guibg=fg
highlight link GitGutterChangeLine DiffText
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '>>'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = '<<'

" Copilot: use C-l to accept the current suggestion
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Podfile
autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby

" VIM Wiki
" let g:vimwiki_list = [{'path': '~/MEGA/vimwiki/',
                      " \ 'syntax': 'default', 'ext': 'txt'}]
" au BufRead,BufNewFile *.txt setlocal textwidth=80
" hi VimwikiHeader1 guifg=#FF0000
" hi VimwikiHeader2 guifg=#00FF00
" hi VimwikiHeader3 guifg=#0000FF
" hi VimwikiHeader4 guifg=#FF00FF
" hi VimwikiHeader5 guifg=#00FFFF
" hi VimwikiHeader6 guifg=#FFFF00

" VIMSCRIPT FILE SETTINGS

" Auto set current file directory
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" Turn on cursorline and cursorcolumn only in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
augroup END

" Set indentation of HTML to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If vim version is equal to or greater than 7.3 enable undofile.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END

function! InsertConsoleLog()
  let word = expand("<cword>")
  let linenumber = line(".")
  execute "normal A \<BS>\<CR>\<ESC>0Aconsole.log('[" . expand('%:t'). ":" .linenumber. "]', ".word."); \/* TODO *\/"
endfunction
map <silent> <leader>v :call InsertConsoleLog()<CR>bbbbi

" Set terminal color
set t_Co=256

" Set the background tone.
set background=dark

" Set the color scheme.
colorscheme gruvbox

if has("gui_running")
    " Set font
    set guifont=MesloLGM\ Nerd\ Font:h12

    " Hide the toolbar.
    set guioptions-=T

    " Hide the the left-side scroll bar.
    set guioptions-=L

    " Hide the the left-side scroll bar.
    set guioptions-=r

    " Hide the the menu bar.
    set guioptions-=m

    " Hide the the bottom scroll bar.
    set guioptions-=b

    " Map the F4 key to toggle the menu, tool, and scroll bar.
    nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR>

endif

" FZF
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.4, 'relative': v:true } }
let $BAT_THEME = 'gruvbox-dark'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Search'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Visual'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'StatusLineNC'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . shellescape(<q-args>), 1, {'dir': FindRootDirectory(), 'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-g> :Rg<CR>
nnoremap <silent> <C-h> :History<CR>
nnoremap <silent> <C-l> :Buffers<CR>

command! MyProjects call fzf#run(fzf#wrap({
    \ 'source': 'rg --files $HOME/GitHub/',
    \ 'sink': 'read',
    \ 'options': ['--multi', '--pointer', '→', '--marker', '♡', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']
    \ }))

nnoremap <leader>a :MyProjects<cr>

" STATUS LINE
let g:airline_powerline_fonts = 1
