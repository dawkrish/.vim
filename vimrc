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
filetype plugin on
syntax on

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'sainnhe/everforest'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

set background=dark
colo everforest

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> K <plug>(lsp-hover)

    nmap <buffer> ga <plug>(lsp-code-action-preview)
    nmap <buffer> S <plug>(lsp-document-format)
    nmap <buffer> gy <plug>(lsp-document-diagonistics)

    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)

    nmap <buffer> <leader>rn <plug>(lsp-rename)

    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_document_highlight_enabled = 0
let g:asyncomplete_auto_popup = 0

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader>pq :q<CR>
nnoremap <leader><CR> :so ~/.vim/vimrc<CR>
nnoremap % ggVG
"nnoremap <leader>f :Files<Cr>
"nnoremap <leader>b :Buffers<Cr>

imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

