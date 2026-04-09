" Bootstrap vim-plug (auto-install if missing)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

" Search and Files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'yegappan/mru'

" Theme
Plug 'morhetz/gruvbox'

" Statusline
Plug 'vim-airline/vim-airline'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'lambdalisue/nerdfont.vim'

" Git and Edition
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Lint/Format
Plug 'dense-analysis/ale'

" AI
Plug 'github/copilot.vim'

call plug#end()

" --- GENERAL ---

set nocompatible
filetype plugin indent on
syntax on

set number relativenumber
set ignorecase smartcase
set tabstop=2 shiftwidth=2 expandtab
set autoindent cindent
set clipboard=unnamedplus
set hidden
set updatetime=300
set signcolumn=yes

set scrolloff=10
set cursorline nocursorcolumn
set title
set mousehide
set autoread
set splitbelow splitright
set noequalalways
set visualbell
set textwidth=80
set backspace=indent,eol,start
set incsearch hlsearch
set ruler showcmd showmatch
set noshowmode
set wildmenu
set wildmode=longest:full,full
set wildignore=*.odt,*.doc*,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.JPG,*.exe,*.bmp,*.flv,*.gz,*.tgz,*.zip,*.iso,*.mov,*.xz,*.tar,*.img,*.docx,*.xlsx,*.xls
set directory=/tmp
set completeopt=menu,menuone,popup,noselect,noinsert
set fileencoding=utf8 encoding=utf8
set t_Co=256
set background=dark

set backup
set backupdir=~/.vim/backup/

if version >= 703
  set undodir=~/.vim/backup
  set undofile
  set undoreload=10000
endif

colorscheme gruvbox

" --- MAPPINGS ---

let mapleader = " "

nnoremap <mousemiddle> <esc>"*P

if has("gui_running")
  nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
else
  map <silent> <leader><cr> :noh<cr>
endif

noremap  <F12>   <Esc>:syntax sync fromstart<CR>
inoremap <F12>   <C-o>:syntax sync fromstart<CR>
nnoremap <silent> <leader>s :update<CR>
nnoremap <silent> <leader>q :x<CR>
nnoremap <up>    :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <down>  :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <right> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <left>  :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>

map  <leader>xx :bd<cr>
map  <leader>xa :bufdo bd<cr>
map  <leader>l  :bnext<cr>
map  <leader>h  :bprevious<cr>
nnoremap <silent> \d :bprevious <bar> bdelete #<CR>

map <leader>f /

nnoremap * :keepjumps normal! mi*`i<CR>

" Split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Terminal
nnoremap <leader>` :terminal<CR>
tnoremap <Esc> <C-\><C-n>

" --- PLUGIN CONFIGURATION ---

" MRU
let MRU_Max_Entries = 20
map <leader>r :MRU<CR>

" NerdTree
let NERDTreeIgnore=['\.jpg$','\.mp4$','\.zip$','\.iso$','\.pdf$','\.pyc$','\.odt$','\.png$','\.svg$','\.gif$','\.tar$','\.gz$','\.xz$','\.bz2$','\.db$','\.vim$','\~$','node_modules']
let NERDTreeMinimalUI=1
let NERDTreeShowBookmarks=1
nnoremap <leader>0 :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-m> :NERDTreeFind<CR>
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" BufExplorer
map <leader><tab> :b#<CR>
nnoremap <silent> <leader>e :BufExplorer<CR>

" FZF
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }
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
command! -bang -nargs=* Rg call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case " . shellescape(<q-args>), 1,
  \ {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :GFiles?<CR>
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-g> :Rg<CR>
nnoremap <silent> <C-h> :History<CR>

" ALE
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_echo_msg_format = '[%severity%] %s'
let g:ale_linters = {
\  'typescript': ['eslint'],
\  'javascript': ['eslint']
\}
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint'],
\  'typescriptreact': ['prettier', 'eslint'],
\  'scss': ['prettier'],
\  'css': ['prettier']
\}
nmap <silent> ge :ALEDetail<CR>
nmap <silent> gr :ALEFindReferences<CR>
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gy :ALEGoToTypeDefinition -vsplit<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"
augroup VimDiff
  autocmd!
  autocmd VimEnter,BufEnter,FilterWritePre * if &diff | ALEDisable | endif
augroup END

" Fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gP :Git push<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gb :Git blame<CR>

" Copilot: use C-l to accept the current suggestion
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Airline
let g:airline_powerline_fonts = 1

" --- AUTOCMDS ---

" Auto set current file directory
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" Cursorline only in active window
augroup cursor_off
  autocmd!
  autocmd WinLeave * set nocursorline
  autocmd WinEnter * set cursorline
augroup END

" Resume last edit position
augroup resume_edit_position
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ | execute "normal! g`\"zvzz"
    \ | endif
augroup END

" TSX/JSX filetype
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" --- FUNCTIONS ---

function! InsertConsoleLog()
  let word = expand("<cword>")
  let linenumber = line(".")
  execute "normal A \<BS>\<CR>\<ESC>0Aconsole.log('[" . expand('%:t') . ":" . linenumber . "]', " . word . "); \/* TODO *\/"
endfunction
map <silent> <leader>v :call InsertConsoleLog()<CR>bbbbi

" --- GUI ---

if has("gui_running")
  set guifont=MesloLGM\ Nerd\ Font:h14
  set guioptions-=T
  set guioptions-=L
  set guioptions-=r
  set guioptions-=m
  set guioptions-=b
endif
