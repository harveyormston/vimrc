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
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'w0rp/ale'
Plugin 'sickill/vim-monokai'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'AndrewRadev/switch.vim'
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
Plugin 'plasticboy/vim-markdown'
Plugin 'rust-lang/rust.vim'
Plugin 'Valloric/ListToggle'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'samsaga2/vim-z80'
Plugin 'chrisbra/csv.vim'
Plugin 'sotte/presenting.vim'
call vundle#end()
filetype plugin indent on

" defaults ___________________________________________________________________
if v:version >= 800
	source $VIMRUNTIME/defaults.vim
endif
set nocompatible
filetype off

" plugin_config ______________________________________________________________
let g:switch_mapping = "+"
let g:airline_theme = 'dark'
let g:airline_powerline_fonts = 1
let g:vim_markdown_folding_disabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_python_pylint_use_global = 1
let g:ale_python_flake8_use_global = 1
let g:ale_python_mypy_use_global = 1
let g:presenting_top_margin = 2

" whitespace _________________________________________________________________
set tabstop=4
set softtabstop=0
set noexpandtab
set shiftwidth=4
set nowrap
" Filetype-specific options:
"" python
autocmd Filetype python setlocal ts=4 sts=4 sw=4 tw=79 cc=79 expandtab
autocmd Filetype python set makeprg=pylint\ --reports=n\ --output-format=parseable\ %
autocmd Filetype python set errorformat=%f:%l:\ %m
autocmd Filetype python autocmd QuickFixCmdPost [^l]* nested cwindow
"" other
autocmd Filetype markdown setlocal ts=4 sts=4 sw=4 tw=79 cc=79 expandtab spell
autocmd Filetype make setlocal ts=4 sts=0 sw=4 noexpandtab
autocmd Filetype tex setlocal ts=2 sts=2 sw=2 tw=79 cc=79 expandtab spell
autocmd Filetype plaintex setlocal ts=2 sts=2 sw=2 tw=79 cc=79 expandtab spell

" general ____________________________________________________________________
set nocompatible
set backspace=indent,eol,start
set autoindent
set incsearch
set ignorecase
set smartcase
set hlsearch
set ruler
syntax on
set number
set relativenumber
set showcmd
set laststatus=2
set swapfile
if has('mouse')
	set mouse=n
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
	set backupdir=%HOME%/vimfiles/swapfiles//
	set background=dark
	colorscheme monokai

elseif os =~ "Darwin"
	set directory=$HOME/.vim/swapfiles//
	set backupdir=$HOME/.vim/swapfiles//
	set background=dark
	colorscheme monokai
	hi Normal ctermbg=NONE
	hi nonText ctermbg=NONE
	hi Search cterm=NONE ctermfg=black ctermbg=white
	let &t_ti.="\e[2 q"
	let &t_SI.="\e[4 q"
	let &t_EI.="\e[2 q"
	let &t_te.="\e[4 q"

elseif os =~ "MSYS"
	colorscheme zellner
	set directory=$HOME/.vim/swapfiles//
	set backupdir=$HOME/.vim/swapfiles//

elseif os =~ "CYGWIN"
	command Open !cygstart %
	let g:ale_linters = {'python': ['pylint', 'flake8', 'mypy']}
	set directory=$HOME/.vim/swapfiles//
	set backupdir=$HOME/.vim/swapfiles//
	set background=dark
	colorscheme monokai
	hi Normal ctermbg=none
	hi nonText ctermbg=none
	hi Search cterm=NONE ctermfg=black ctermbg=white
	let &t_ti.="\e[1 q"
	let &t_SI.="\e[5 q"
	let &t_EI.="\e[1 q"
	let &t_te.="\e[0 q"

elseif os =~ "Linux"
	set directory=$HOME/.vim/swapfiles//
	set backupdir=$HOME/.vim/swapfiles//
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

" save/load session __________________________________________________________
fu! SaveSess()
	if filereadable(getcwd() . '/.session.vim')
		execute 'mksession! ' . getcwd() . '/.session.vim'
	endif
endfunction
fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
endfunction
autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()

fu! Present()
	set background=light
	colorscheme papercolor
	PresentingStart
	set cc=0
	set nospell
endfunction

fu! EndPresent()
	set background=dark
	colorscheme monokai
endfunction
