set runtimepath^=~/.vim
let &packpath = &runtimepath

syntax on
set statusline=%f
set statusline+=%{fugitive#statusline()}
set noswapfile
set mouse=a
set scrolloff=1
set number
set cursorline

" Set to auto read when a file is changed from the outside
set autoread

" Tab and space formatting
set tabstop=2
set expandtab
set autoindent
set shiftwidth=2
set shiftround
set copyindent
set smarttab
set smartindent
set nowrap

set encoding=utf8
set completeopt-=preview

" git gutter update time
set updatetime=100

" makes tab completion in vim console insanely better
set wildmode=longest,list

" automatically un-highlights when you do anything
let g:incsearch#auto_nohlsearch = 1

let NERDTreeShowHidden = 1
let g:jsx_ext_required = 0
let g:closetag_filenames = '*.html,*.js'
let g:closetag_shortcut = '>'

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tenderplus'

" Use deoplete (auto-complete)
let g:deoplete#enable_at_startup = 1

" Tab from the top of autocomplete
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}"

" Autocomplete across buffers
set complete=.,b,u,w,t,]

" Javascript linting
let g:ale_linters = {
\  'javascript': ['eslint'],
\}

call plug#begin('~/.config/nvim/plugged')
Plug 'fatih/vim-go'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'neoclide/vim-jsx-improve'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale'
Plug 'jreybert/vimagit'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'

" Colorschemes
Plug 'mkarmona/colorsbox'
Plug 'exitface/synthwave.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'jacoborus/tender.vim'
call plug#end()

" Go format
let g:go_fmt_options = "-tabs=false -tabwidth=8"
" Format Go on save
autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd FileType go setlocal shiftwidth=8 tabstop=8 softtabstop=8
autocmd FileType go setlocal noexpandtab


" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#softRefresh()
endif

" Set color
colo tender

filetype plugin on

if (has("termguicolors"))
  set termguicolors
endif

" Fast saving
nmap <leader>w :w<CR>

" Search files and commits
nnoremap <C-A> :Ag<CR>
nnoremap <C-F> :FZF<CR>
nnoremap <C-G> :GFiles<CR>
nnoremap <C-G><C-E> :GFiles?<CR>
nnoremap <C-M> :Commit<CR>
nnoremap <C-T> :Windows<CR>

" Trim white space
nnoremap <C-S><C-T> :StripWhitespace<CR>

" Delete trailing white space on save
fun! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

if has("autocmd")
  autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"makes nerdtree close if it's the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Search for text in files
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map # <Plug>(incsearch-nohl-*)
map * <Plug>(incsearch-nohl-#)
map g/ <Plug>(incsearch-stay)

" highlights all found search terms
set hlsearch

" Go to word or line
map <Space>k <Plug>(easymotion-b)
map <Space>j <Plug>(easymotion-w)

" Buffer settings
set splitbelow
set splitright
set hid
nnoremap <Space>h :bp<CR>
nnoremap <Space>l :bn<CR>
nnoremap <C-B> :Buffers<CR>
nnoremap <C-X> :bd!<CR>

nnoremap rr :source ~/.config/nvim/init.vim<CR>
nnoremap <C-N> :NERDTreeToggle<CR>

" Inserts new line where cursor is without entering insert mode
nnoremap <CR> i<CR><Esc><BS>

" clear previous search on start
let @/ = ''
