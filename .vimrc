" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
"  set backup           " keep a backup file
endif
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set hlsearch
set incsearch           " do incremental searching
set expandtab

" Pathogen
call pathogen#infect() 


"Filetype
set filetype=on
filetype plugin indent on

"set t_Co=256
"set t_AB=[48;5;%dm
"set t_AF=[38;5;%dm

set ai
set ts=4
set sts=4
set et
set sw=4
set textwidth=79

" HTML (tab width 2 chr, no wrapping)
autocmd FileType html set sw=2
autocmd FileType html set ts=2
autocmd FileType html set sts=2
autocmd FileType html set textwidth=0
autocmd BufRead,BufNewFile *.html,*.htm,*.soy set sw=2 ts=2 sts=2 tw=0
" XML (tab width 2 chr, no wrapping)
autocmd FileType xml set sw=2
autocmd FileType xml set ts=2
autocmd FileType xml set sts=2
autocmd FileType xml set textwidth=0
autocmd BufRead,BufNewFile *.xml set sw=2 ts=2 sts=2 tw=0
" Python (tab width 4 chr, wrap at 79th char)
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
autocmd FileType python set textwidth=79
" CSS (tab width 2 chr, wrap at 79th char)
autocmd FileType css set sw=2
autocmd FileType css set ts=2
autocmd FileType css set sts=2
autocmd FileType css set textwidth=79
" JavaScript (tab width 4 chr, wrap at 79th)
autocmd FileType javascript set sw=2
autocmd FileType javascript set ts=2
autocmd FileType javascript set sts=2
autocmd FileType javascript set textwidth=81
autocmd BufRead,BufNewFile *.js,*.coffee set sw=2 ts=2 sts=2 tw=0
" rst (tab width 3 chr, wrap at 79th)
autocmd FileType rst set sw=3
autocmd FileType rst set ts=3
autocmd FileType rst set sts=3
autocmd FileType rst set textwidth=79
autocmd FileType javascript,python set colorcolumn=80
autocmd WinEnter,BufWinEnter *.py,*.js silent! let w:m2=matchadd(
    \ 'ErrorMsg', printf('\%%>%dv.\+', &tw ? &tw + 1: 79), -1, 1001)

"syntax enable
set background=dark
"let g:solarized_termcolors=256
let g:solarized_termtrans=1
"let g:solarized_degrade=1
"let g:solarized_bold=0
"let g:solarized_underlin=0
"let g:solarized_italic=0
"let g:solarized_contrast="high"
"let g:solarized_visibility="low"
colorscheme solarized
" colorscheme desert256
" colorscheme ksplat
" colorscheme torte
" colorscheme koehler
" colorscheme default

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")

set ruler
set wildmenu
set wildmode=list:longest
set title
set titlestring=vim\ %t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
if &term =~ '^screen'
    set t_ts=k
    set t_fs=\
endif

let python_highlight_all = 1
let python_slow_sync = 1

let netrw_list_hide = '\.pyc$'
let netrw_browse_split = 3
let netrw_keepdir = 0
let netrw_liststyle = 3

" Paste Mode On/Off
map <F8> :call Paste_on_off()<CR>
set pastetoggle=<F8>
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
        if g:paste_mode == 0
                set paste
                let g:paste_mode = 1
        else
                set nopaste
                let g:paste_mode = 0
        endif
        return
endfunc


" Tagbar
" let g:tagbar_ctags_bin = '/usr/local/Cellar/ctags/5.8/bin/ctags'
" nmap <Tab> :TagbarToggle<CR>
nnoremap <silent> <TAB> :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1


" Signatures
com! Sign call SignMessage()

func! SignMessage()
    normal G
    let s:tempt = @t
    let @t = "\n-- \n"
    put t
    normal G
    let sig = system("/usr/home/wiqd/random_signature")
    put =sig
    exe "normal ?^-- $\<CR>jgq$"
endfunc

set secure
set modeline

" Remove all whitespace to the end of the line
" :%s/\s\+$//g

" /* vim: set et ts=4 sts=4 sw=4: */
