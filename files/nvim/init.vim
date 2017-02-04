set nowrap        " disable wrapping
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab     " convert tabs to spaces
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set hidden        " allows switching modified buffers
set noshowmode    " hide mode because of lightline
set mouse-=a      " disable mouse
set undofile      " enable persistent undo
set undolevels=1000

augroup autocmds
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e                " Remove trailing whitespace
    autocmd BufRead,BufNewFile *.tex set filetype=tex " set latex filetype
    autocmd BufWritePost * Neomake
    autocmd BufNewFile,BufRead /dev/shm/pass.* setlocal noswapfile nobackup noundofile
augroup END

" Setup some default ignores
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|build)$',
			\ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
			\}

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ }

let g:vim_search_pulse_mode = 'pattern'

set encoding=utf-8      " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.

" Show unsaved changes
command! Diff w !diff % -

" Save file with root permissions
command! -bar Sudo exec 'w !sudo tee % > /dev/null' <bar> e! <bar> redraw! <bar> echo "Sudo has granted you your wish"
cabbrev w!! Sudo
cabbrev wq!! Sudo <bar> q

" Clear last search highlighting
noremap <silent> <Space> :noh<cr>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Toggle Undotree
nnoremap <F5> :UndotreeToggle<cr>

" Copy and paste
vnoremap <C-c> "+y
inoremap <C-v> <esc>"+pa

" Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

func! Focus(comando,vim_comando)
  let oldw = winnr()
  silent exe 'wincmd ' . a:vim_comando
  let neww = winnr()
  if oldw == neww
    silent exe '!i3-msg -q focus ' . a:comando
    if !has("gui_running")
        redraw!
    endif
  endif
endfunction

let &titlestring = "nvim:" . $NVIM_LISTEN_ADDRESS
set title

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
" Fuzzy file opener
Plug 'ctrlpvim/ctrlp.vim'
" Enable repeating support for plugins
Plug 'tpope/vim-repeat'
" base16 colors
Plug 'chriskempson/base16-vim'
" Pulse search result
Plug 'inside/vim-search-pulse'
Plug 'neomake/neomake'
Plug 'itchyny/lightline.vim'

call plug#end()

" Must load after plugins: https://github.com/altercation/vim-colors-solarized/issues/104
set background=dark
colorscheme base16-eighties
highlight Search guibg=NONE guifg=NONE gui=underline
set termguicolors
