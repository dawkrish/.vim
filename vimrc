set scrolloff=8
set nu
set laststatus=2
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent 
set wildmenu
set cursorline
set hidden
set path+=**
set clipboard+=unnamed 
set termguicolors
set backspace=indent,eol,start
filetype plugin on
syntax on

let g:netrw_winsize = 30
let g:netrw_banner = 0
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rhysd/vim-healthcheck'
Plug 'tpope/vim-commentary'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'sts10/vim-pink-moon'
Plug 'NLKNguyen/papercolor-theme'
Plug 'altercation/vim-colors-solarized'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'
" Plug 'rafamadriz/friendly-snippets'
call plug#end()

colo desert
set background=dark
colorscheme solarized

function! s:on_lsp_buffer_enabled() abort
      setlocal omnifunc=lsp#complete
      setlocal signcolumn=yes

    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>s <plug>(lsp-document-format)
    nmap <buffer> ga <plug>(lsp-code-action)
    nmap <buffer> <leader>d <plug>(lsp-document-diagnostics)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

let g:lsp_document_highlight_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_semantic_enabled = 0
"" let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_inlay_hints_enabled =0


let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader>pq :q<CR>
nnoremap <leader><CR> :so ~/.vim/vimrc<CR>
nnoremap % ggVG
nnoremap <leader>f :Files<Cr>
nnoremap <leader>b :Buffers<Cr>
