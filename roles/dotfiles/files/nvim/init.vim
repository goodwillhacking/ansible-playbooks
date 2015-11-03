set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab     " convert tabs to spaces
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set hidden        " allows switching modified buffers
set mouse-=a      " disable mouse
set undofile      " enable persistent undo

set undolevels=1000      " use many muchos levels of undo

filetype plugin indent on

" LATEX
let g:vimtex_latexmk_build_dir="build"
let g:vimtex_view_method="zathura"
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead *.tex :VimtexCompile

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|build)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.

" Show unsaved changes
command! Diff w !diff % -

" Save file with root permissions
command! -bar Sudo exec 'w !sudo tee % > /dev/null' <bar> e! <bar> redraw! <bar> echo "Sudo has granted you your wish"
cabbrev w!! Sudo
cabbrev wq!! Sudo <bar> q

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Toggle Undotree
nnoremap <F5> :UndotreeToggle<cr>

" Copy and paste
vnoremap <C-c> "+y
inoremap <C-v> <esc>"+pa

" Tmux navigation
inoremap <C-h> <C-o>:TmuxNavigateLeft<cr>
inoremap <C-l> <C-o>:TmuxNavigateRight<cr>
inoremap <C-j> <C-o>:TmuxNavigateDown<cr>
inoremap <C-k> <C-o>:TmuxNavigateUp<cr>

let g:neomake_tex_enabled_makers        = ['chktex']
let g:neomake_puppet_enabled_makers     = ['puppet','puppet-lint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_json_enabled_makers       = ['jsonlint']
let g:neomake_python_enabled_makers     = ['frosted']
let g:neomake_ruby_enabled_makers       = ['robocop']

autocmd! BufWritePost * silent! Neomake

augroup pencil
    autocmd!
    autocmd FileType markdown,tex call pencil#init()
augroup END

" Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Load vim-plug
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'Raimondi/delimitMate'
" Replace and add brackets and quotes
Plug 'tpope/vim-surround'
" Show git signs in gutter
Plug 'airblade/vim-gitgutter'
" Align common seperators
Plug 'junegunn/vim-easy-align'
" Make commenting easy
Plug 'tpope/vim-commentary'
" Syntax highlight ansible playbooks
Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }
" Puppet syntax highlighting
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
" Latex compiler
Plug 'lervag/vimtex', { 'for': 'tex' }
" Improved javascript indentation and syntax
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" List buffers
Plug 'jeetsukumaran/vim-buffergator'
" Fuzzy file opener
Plug 'ctrlpvim/ctrlp.vim'
" Undo tree visualizer
Plug 'mbbill/undotree'
" Enable repeating support for plugins
Plug 'tpope/vim-repeat'
" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'
" Solarized colors
Plug 'altercation/vim-colors-solarized'
" Async syntax checker
Plug 'benekastah/neomake', { 'for': ['javascript', 'json', 'python', 'ruby', 'tex', 'puppet']}
" Better line wrapping for prose
Plug 'reedes/vim-pencil'
" Distraction free writing
Plug 'junegunn/goyo.vim'
" Better search
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'

call plug#end()

" Must load after plugins: https://github.com/altercation/vim-colors-solarized/issues/104
syntax enable
set background=dark
colorscheme solarized
