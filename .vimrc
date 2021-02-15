" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

Plug 'junegunn/seoul256.vim'

Plug 'fisadev/vim-isort'

Plug 'psf/black', { 'branch': 'stable' }

Plug 'dense-analysis/ale'
Plug 'deoplete-plugins/deoplete-jedi'


if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1


Plug 'flebel/vim-mypy', { 'for': 'python', 'branch': 'bugfix/fast_parser_is_default_and_only_parser' }

Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


Plug 'lambdalisue/fern.vim'

" Initialize plugin system
call plug#end()

let mapleader=" "

" Managing Inkscape figures 
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

" Turn on line numbers
set number

" Save file
nnoremap <Leader>s :update<CR> 

" Run mypy
nnoremap <Leader>mp :Mypy<CR>

" Format on save
autocmd BufWritePre *.py 
      \ execute ':Black' |
      \ execute ':Isort' 

" Fix tabs
set expandtab " Use spaces instead of tabs
set tabstop=2 " 1 tab = 2 spaces
set smarttab " Use tabstop

" Following two are to get the correct # of spaces to be insert on hitting Tab
set shiftwidth=2
set softtabstop=2

" Set color scheme
colo seoul256

" Edit file
nnoremap <Leader>e :e<Space>

" Save and quit
nnoremap <Leader>wq :wq!<CR>
" Quit
nnoremap <Leader>q :q!<CR>

" Remove preview after completion.
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Move between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" Kill all other windows but this one
nnoremap <C-X> <C-W>o

" Open fern.vim
nnoremap <Leader>f :Fern . -drawer<CR>
function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  nmap <buffer> <Plug>(fern-action-trash) <Plug>(fern-action-remove)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END




" Shortcuts reference

" I - go to start of line and insert
" A - go to end of line and insert
" C - delete from cursor to end of line and insert
" Alt-O - move to next line and insert
" C-u - delete from cursor to start of line (while in Insert mode)
" C-w = - set size of all windows equal
