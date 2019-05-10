"" Vundle
"set nocompatible              " be iMproved, required
"filetype off                  " required
"
"" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"" alternatively, pass a path where Vundle should install plugins
""call vundle#begin('~/some/path/here')
"
"" let Vundle manage Vundle, required
"" git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"" Then in vim, run :PluginInstall
"Plugin 'VundleVim/Vundle.vim'
"
"" third_party/ycmd/build.py
"" third_party/ycmd/cpp
"" ./third_party/ycmd/clang_archives => http://llvm.org/releases/clang+llvm-3.9.0-x86_64-opensuse13.2.tar.xz
""Plugin 'Valloric/YouCompleteMe'
"
""Plugin 'davidhalter/jedi-vim'
"Plugin 'Shougo/neocomplete'
"
"" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
"" To ignore plugin indent changes, instead use:
""filetype plugin on
""
"" Brief help
"" :PluginList       - lists configured plugins
"" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
"" :PluginSearch foo - searches for foo; append `!` to refresh local cache
"" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
""
"" see :h vundle for more details or wiki for FAQ
"" Put your non-Plugin stuff after this line

set mouse=	" disable mouse
colorscheme aulddays
set scrolloff=4	" center cursor when scroll
set nu
set textwidth=0
set splitright splitbelow	" vs puts the new buffer on the right/below
set wildmode=longest:full,full	" tab completion mode
set wildmenu
if !&diff
	set cursorline	" Use cursorline if not in vimdiff
	set lazyredraw
endif
set writebackup " use a backup file for saving
if has('persistent_undo')
	set nobackup        " drop backup files when we use undo
	set undofile    " keep an undo file (undo changes after closing)
	set undodir=~/.cache/vim//
	set backupdir=.
else
	set backup        " keep a backup file (restore to previous version)
	set backupdir=~/.cache/vim//,.
endif

if match($LANG, 'utf8') >= 0
	set encoding=utf8
	set termencoding=utf8
else
	set encoding=2byte-gb18030
	set termencoding=2byte-gb18030
endif
set fileencodings=ucs-bom,gb18030,utf-8
" use fencview to detect encoding. fencview can further use tellenc.
" compile tellenc.cpp in the bin dir and add to PATH
let g:fencview_autodetect=1

" Work-around incomplete terminfo databases                                     
" Particulalry useful when under `screen`, which may or may not be attached to  
" a physical terminal capable of 256color mode.                                 
if match($TERMCAP, 'Co#256:') == 0 || match($TERMCAP, ':Co#256:') > 0 || match($TERM, 'xterm') >= 0 || match($TERM, 'linux') >= 0 || match($TERM, 'screen') >= 0
    set t_Co=256                                                                
endif    

"set list
"set listchars=tab:>-

" syntax highlighting is very slow on long lines, disable it after 250 col
" If this does not help, just use :syntax off on that file!
set synmaxcol=500
" disable syntax highlighting on large files. `:syntax on` or `:syntax enbale` to bring back on
autocmd BufWinEnter * if line2byte(line("$") + 1) > 524288 | syntax clear | endif

" Indents
set autoindent cindent cinkeys-=0# indentkeys-=0#	" turn on indent by default and do not move back '#'
set noexpandtab tabstop=4 shiftwidth=4 
set modeline
autocmd FileType python setlocal et sta sw=4 sts=4
"autocmd FileType c setlocal expandtab ts=4 sw=4 sts=4
"autocmd FileType cpp setlocal expandtab ts=4 sw=4 sts=4

let python_version_2 = 1
let python_highlight_all = 1
let python_highlight_space_errors = 0

autocmd FileType python,c,cpp set list listchars=tab:>\  | set colorcolumn=100    " show tab chars
" Press F11 to toggle show tab char
map <F11> : if &list <Bar> set nolist <Bar> else <Bar> set list listchars=tab:>\  <Bar> endif<CR>

autocmd FileType python,c,cpp let g:indentLine_enabled = 1  " enable indentLine plugin
let g:indentLine_setColors = 0
let g:indentLine_char = ' '
let g:indentLine_enabled = 0
let g:indentLine_color_term = 95
map <F12> :IndentLinesToggle<CR>

" show filename in ruler
"set rulerformat=%30(%=:b%n%y%m%r%w\ %l,%c%V\ %P%)
set statusline=%f\ %=%-8.(%l,%c%V%)\ %P
set ruf=%40(%#Operator#%t%##\ %=%#Statement#%-8.(%l,%c%V%)%##\ %P%)

" press F10 to show the sytax highlighting group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"" neocomplete settings
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 2
"let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
"  " For no inserting <CR> key.
"  "return pumvisible() ? "\<C-y>" : "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"" Close popup by <Space>.
""inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
"" AutoComplPop like behavior.
""let g:neocomplete#enable_auto_select = 1
"" Shell like behavior(not recommended).
""set completeopt+=longest
""let g:neocomplete#enable_auto_select = 1
""let g:neocomplete#disable_auto_complete = 1
""inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"" Enable heavy omni completion.
"if !exists('g:neocomplete#sources#omni#input_patterns')
"  let g:neocomplete#sources#omni#input_patterns = {}
"endif
""let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
""let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
""let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"" For perlomni.vim setting.
"" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"let g:neocomplete#enable_auto_close_preview=1
"
"" jedi-vim  plugin options
""let g:jedi#completions_command = "<C-N>"
"let g:jedi#completions_enabled = 0	" Disable completion in jedi-vim
"let g:jedi#call_signature_escape = 'A0u1l2'	" Default =`= conflicts with operator_highlight plugin
