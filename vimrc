" --- Leader key (must be before any <leader> mappings) ---
let mapleader = " "

" --- General settings ---
set scrolloff=8          " keep 8 lines visible above/below cursor
set nu                   " show line numbers
set laststatus=2         " always show status line
set tabstop=2 softtabstop=2
set shiftwidth=2         " 2-space indentation
set expandtab            " spaces instead of tabs
set smartindent          " auto-indent new lines
set wildmenu             " command-line tab completion menu
set cursorline           " highlight current line
set hidden               " allow unsaved buffers in background
set path+=**             " recursive file search with :find
set clipboard+=unnamed   " use system clipboard
set termguicolors        " enable 24-bit colors
set backspace=indent,eol,start  " backspace works everywhere in insert mode
set undofile             " persistent undo across sessions
set undodir=~/.vim/undodir
if !isdirectory(expand('~/.vim/undodir'))
  call mkdir(expand('~/.vim/undodir'), 'p')
endif
set autoread             " reload files changed outside vim

" --- Search ---
set hlsearch             " highlight search matches
set incsearch            " show matches as you type
set ignorecase           " case-insensitive search...
set smartcase            " ...unless you use uppercase

filetype plugin on
syntax on

" --- Netrw (built-in file explorer) ---
let g:netrw_winsize = 30
let g:netrw_banner = 0   " hide banner in netrw

" --- Airline (status bar) ---
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" --- Auto-install vim-plug if missing ---
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- Plugins ---
call plug#begin("~/.vim/plugged")

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" utilities
Plug 'rhysd/vim-healthcheck'
Plug 'tpope/vim-commentary'   " gcc to toggle comments
Plug 'tpope/vim-surround'     " cs'" to change surrounding quotes
Plug 'tpope/vim-repeat'       " make surround/commentary dot-repeatable
Plug 'jiangmiao/auto-pairs'   " auto-close brackets and quotes
Plug 'tpope/vim-fugitive'     " git commands inside vim (:Git blame, :Git diff)
Plug 'airblade/vim-gitgutter' " show git diff markers in sign column

" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" colorschemes
Plug 'sts10/vim-pink-moon'
Plug 'NLKNguyen/papercolor-theme'
Plug 'altercation/vim-colors-solarized'

" LSP (language server protocol)
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" snippets (uncomment to enable)
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'
" Plug 'rafamadriz/friendly-snippets'
call plug#end()

" --- Colorscheme ---
colorscheme PaperColor
set background=light

" --- LSP keybindings (active only in LSP-supported buffers) ---
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    " navigation
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    " search symbols
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    " actions
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>s <plug>(lsp-document-format)
    nmap <buffer> ga <plug>(lsp-code-action)
    " diagnostics
    nmap <buffer> <leader>d <plug>(lsp-document-diagnostics)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    " hover and scroll
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" --- Completion (Tab/Shift-Tab to navigate, Enter to confirm) ---
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

" --- LSP settings ---
let g:lsp_document_highlight_enabled = 1   " highlight symbol under cursor
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_semantic_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1      " show diagnostic in command line
let g:lsp_inlay_hints_enabled = 0

" --- Custom keymaps ---
" file explorer, quit, reload vimrc
nnoremap <leader>pv :Vex<CR>
nnoremap <leader>pq :q<CR>
nnoremap <leader><CR> :so ~/.vim/vimrc<CR>
" select all, fuzzy find
nnoremap <leader>a ggVG
nnoremap <leader>f :Files<Cr>
nnoremap <leader>b :Buffers<Cr>
