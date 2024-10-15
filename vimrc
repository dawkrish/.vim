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
filetype plugin indent on
syntax on

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'

Plug 'dense-analysis/ale'
call plug#end()

set background=dark
colo habamax

" autocmd InsertEnter * call deoplete#enable()
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_virtualtext_cursor = 'current'



let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader>pq :q<CR>
nnoremap <leader><CR> :so ~/.vim/vimrc<CR>
nnoremap % ggVG
nnoremap <leader>f :Files<Cr>
nnoremap <leader>b :Buffers<Cr>

