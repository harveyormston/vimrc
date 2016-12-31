" vundle _____________________________________________________________________
let os = substitute(system('uname'), "\n", "", "")

if has("win32")
    set rtp+=%HOME%/vimfiles/bundle/Vundle.vim/
    call vundle#begin('%USERPROFILE%/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'L9'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'nvie/vim-flake8'
Plugin 'sickill/vim-monokai'
Plugin 'AndrewRadev/switch.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'fidian/hexmode'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dietsche/vim-lastplace'
Plugin 'jiangmiao/auto-pairs'
Plugin 'yegappan/mru'
Plugin 'junegunn/vim-easy-align'
Plugin 'will133/vim-dirdiff'
Plugin 'hdima/python-syntax'
Plugin 'lifepillar/vim-mucomplete'
Plugin 'PeterRincker/vim-argumentative'
Plugin 'severin-lemaignan/vim-minimap'
call vundle#end()
filetype plugin indent on

" defaults ___________________________________________________________________
if v:version >= 800
    source $VIMRUNTIME/defaults.vim
endif
set nocompatible
filetype off

" plugin_config ______________________________________________________________
let g:UltiSnipsExpandTrigger="<leader>l"
let g:switch_mapping = "+"
let g:airline_theme='dark'
let g:flake8_show_in_file=1
let g:flake8_show_in_gutter=1
autocmd BufWritePost *.py call Flake8()
" make YCM compatible with UltiSnips (using supertab)
let g:SuperTabDefaultCompletionType = '<C-n>'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let python_highlight_all = 1
" mucomplete
set noshowmode shortmess+=c
setl infercase
setl completeopt-=preview
setl completeopt+=longest,menu,menuone
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0

" whitespace _________________________________________________________________
set tabstop=4
set softtabstop=0
set noexpandtab
set shiftwidth=4
" Filetype-specific options:
autocmd Filetype python setlocal ts=4 sts=4 sw=4 tw=79 cc=79 expandtab
autocmd Filetype markdown setlocal ts=4 sts=4 sw=4 tw=79 cc=79 expandtab spell
autocmd Filetype make setlocal ts=4 sts=0 sw=4 noexpandtab

" general ____________________________________________________________________
set nocompatible
set backspace=indent,eol,start
set autoindent
set incsearch
set smartcase
set hlsearch
set ruler
syntax on
set number
set relativenumber
set showcmd
set laststatus=2
if has('mouse')
  set mouse=a
endif
if has('persistent_undo')
  set undofile
  set undodir=$HOME/.vim/undo
endif
set tags=~/.tags;./.tags
autocmd CursorHold * checktime

" keymap _____________________________________________________________________
let mapleader=","
inoremap jk <esc>
inoremap <esc> <nop>

" os-specific ________________________________________________________________
if has("win32")
    set directory=%HOME%/vimfiles/swapfiles//
    set background=dark
    colorscheme monokai

elseif os =~ "Darwin"
    set directory=$HOME/.vim/swapfiles//
    set background=dark
	colorscheme monokai
	hi Normal ctermbg=NONE
	hi nonText ctermbg=NONE
    hi Search cterm=NONE ctermfg=black ctermbg=white
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"

elseif os =~ "MSYS"
    colorscheme zellner
    set directory=$HOME/.vim/swapfiles//

elseif os =~ "CYGWIN"
    set directory=~/.vim/swapfiles//
    set background=dark
    colorscheme monokai
    hi Normal ctermbg=none
	hi nonText ctermbg=NONE
    hi Search cterm=NONE ctermfg=black ctermbg=white
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"

elseif os =~ "Linux"
    set directory=~/.vim/swapfiles//
    set background=dark
    colorscheme monokai
    hi Normal ctermbg=none
	hi nonText ctermbg=NONE
    hi Search cterm=NONE ctermfg=black ctermbg=white
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"
endif
