set runtimepath^=~/.vim
let &packpath = &runtimepath


call plug#begin('~/.config/nvim/plugged')

" Syntax / Autocomplete Plugs
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'neoclide/vim-jsx-improve'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Go Plugs
Plug 'fatih/vim-go'
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Search Plugs
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'haya14busa/incsearch.vim'

" Git Plugs
Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'

" Shortcut Plugs
Plug 'Raimondi/delimitMate'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'

" Statusline / Filetree Plugs
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Style Plugs
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'

" Linting / Cleaning Plugs
Plug 'w0rp/ale'
Plug 'ntpeters/vim-better-whitespace'

" Colorschemes
Plug 'mkarmona/colorsbox'
Plug 'exitface/synthwave.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'jacoborus/tender.vim'

call plug#end()

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

set encoding=UTF-8
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
let g:airline_theme = 'jellybeans'

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#softRefresh()
endif


" Use deoplete (auto-complete)
let g:deoplete#enable_at_startup = 1

" Tab from the top of autocomplete
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Autocomplete across files
set complete=.,b,u,w,t,]

" ALE SETTINGS
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Javascript linting
let g:ale_linters = {
\  'javascript': ['eslint'],
\}
" END ALE SETTINGS

" Set color
colo jellybeans

filetype plugin on

if (has("termguicolors"))
  set termguicolors
endif

" Fast saving
nmap <leader>w :w<CR>
nmap <leader>wa :wa<CR>

" Search files and commits
nnoremap <C-A> :Ag<CR>
nnoremap <C-F> :FZF<CR>
nnoremap <C-G> :GFiles<CR>
nnoremap <C-G><C-E> :GFiles?<CR>
nnoremap <C-M> :Commit<CR>
nnoremap <C-T> :Windows<CR>

" Trim white space
nnoremap <C-S><C-T> :StripWhitespace<CR>

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
set smartcase
set ignorecase

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

" Indent guide
let g:indentLine_char = '⎸'
let g:indentLine_enabled = 1
let g:indentLine_color_gui = '#345260'

" Go SETTINGS
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

" Go HIGHLIGHT
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" Highlights same ID use
let g:go_auto_sameids = 1

" snakecase to json tags in Go
let g:go_addtags_transform = "snakecase"

" Go auto import deps
let g:go_fmt_command = "goimports"

" Go show type info in status line
let g:go_auto_type_info = 1

" Go extra lint buffer silence
let g:go_fmt_fail_silently = 1

" clear previous search on start
let @/ = ''


