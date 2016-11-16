set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
filetype off

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

let g:airline#extensions#tabline#enabled = 1

set rtp+=c:/users/jspataro/.vim/bundle/Vundle.vim
call vundle#begin('c:/users/jspataro/.vim/bundle/')

                  " required

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jdonaldson/vaxe'
Plugin 'tpope/vim-fugitive'
Plugin 'vimwiki/vimwiki'
Plugin 'kien/ctrlp.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'neilagabriel/vim-geeknote'

call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
set background=dark
colorscheme solarized

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>
map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

colorscheme luna

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
set rnu

set tabstop=4

noremap <F8> :Geeknote<cr>
let g:GeeknoteScratchDirectory='c:\temp'
let g:GeeknoteFormat="plain"
let g:GeeknoteNotebooks=
\    [
\        '852cb3f6-587a-4b6e-a418-529e41100d2d', 
\    ]

" air-line
let g:airline_powerline_fonts=1
let g:Powerline_symbols='unicode'
let g:airline_theme='badwolf'
set encoding=utf-8 
set guifont=DejaVu_Sans_Mono_for_Powerline:h10:cANSI

" this makes air-line not disappear when nerd tree is hidden
set laststatus=2

" vim-notes
let g:notes_directories = ['C:\Users\jspataro\desktop\Notes', '\\netstore01\jspataro\notes']
let g:notes_suffix = '.txt'

let g:vimwiki_list = [{'path': '\\netstore01\jspataro\wiki'}]

" insert timestamp
nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>

" move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

