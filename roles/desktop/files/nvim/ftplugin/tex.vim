set wrap
set spell spelllang=de

set breakindent   " keep indent when wrapping
set linebreak     " respect words when wrapping
set showbreak=+   " show a symbol if the line is wrapped

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

let g:vimtex_latexmk_build_dir="build"
let g:vimtex_view_method="zathura"
autocmd FileType tex :VimtexCompile
