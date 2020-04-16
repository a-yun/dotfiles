" junegunn/vim-plug, install new plugins with :PlugInstall
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'scrooloose/nerdtree' " file explorere
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline' " status bar 
Plug 'vim-airline/vim-airline-themes'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-sleuth' " infer whitespace style
Plug 'pangloss/vim-javascript'
Plug 'tmhedberg/SimpylFold' " Python folding
Plug 'vim-pandoc/vim-pandoc' " markdown rendering with pandoc
call plug#end()
let g:pymode_python = 'python3'

" Colors and themes
let g:airline_theme='angr'
set background=dark
colorscheme solarized

" Mouse/keyboard and indent
set mouse+=a
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent

" Characters and display
set number
set colorcolumn=120
set ignorecase
set list " display invisible characters
set listchars=tab:>-
set laststatus=2 " turn statusbar on
set cursorline " highlight current line

" Folding and wrapping
" set foldlevel=99 " ???
set foldmethod=syntax
let typescript_fold=1
let javaScript_fold=1
autocmd BufWinEnter * normal zR
autocmd BufRead * normal zR

" Renaming for tmux
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
autocmd VimLeave * call system("tmux rename-window bash")

" ctags
set tags+=tags;/ " search parent directories for tag file

""""" PLUGINS
" NERDTree
autocmd VimEnter * NERDTree " open NERDTree on vim open
autocmd VimEnter * wincmd p " move cursor to main window
autocmd BufWinEnter * NERDTreeMirror " open NERDTree in each tab
let NERDTreeShowHidden=1

" vim-sleuth
" " Indenting defaults (does not override vim-sleuth's indenting detection)
" " Defaults to 4 spaces for most filetypes
if get(g:, '_has_set_default_indent_settings', 0) == 0
  " Set the indenting level to 2 spaces for the following file types.
  autocmd FileType typescript,javascript,jsx,tsx,css,html,ruby,elixir,kotlin,vim,plantuml
    \ setlocal expandtab tabstop=2 shiftwidth=2
  set expandtab
  set tabstop=4
  set shiftwidth=4
  let g:_has_set_default_indent_settings = 1
endif

" vim fugitive
set diffopt+=vertical " vertical diff splits

""""" MISC
" Remove all trailing whitespace with F5
set shell=/bin/zsh
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
