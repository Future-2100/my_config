" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

syntax on
set background=dark
filetype plugin indent on
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

setlocal noswapfile
set bufhidden=hide
set number
set rnu
set cursorline
set ruler
set shiftwidth=2
set softtabstop=2
set tabstop=2
set mouse=a
set expandtab
set nobackup
set autochdir
set backupcopy=yes
set hlsearch
set noerrorbells
set novisualbell
set vb t_vb= 
set matchtime=2
set magic
set smartindent
set backspace=indent,eol,start
set cmdheight=1
set laststatus=2
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ Ln\ %l,\ Col\ %c/%L%)
"set foldenable
"set foldmethod=syntax
"set foldcolumn=0
"setlocal foldlevel=1
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
nnoremap <C-k> <C-v>
nnoremap <F1> <C-T> 
nnoremap <F2> <C-]> 
nnoremap <F3> :tnext<ENTER>
nnoremap <F5> :set mouse=<ENTER>
nnoremap <F6> :set mouse=a<ENTER>
set tags=~/ysyx-workbench/tags
"set tags=~/xv6-labs-2022/tags

