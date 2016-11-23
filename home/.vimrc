set mouse=	" disable mouse
set encoding=cp936
set fileencodings=gb18030,utf-8
set termencoding=gb18030
colorscheme aulddays
set scrolloff=4	" center cursor when scroll
set nu

" Work-around incomplete terminfo databases                                     
" Particulalry useful when under `screen`, which may or may not be attached to  
" a physical terminal capable of 256color mode.                                 
if match($TERMCAP, 'Co#256:') == 0 || match($TERMCAP, ':Co#256:') > 0           
    set t_Co=256                                                                
endif    

"set list
"set listchars=tab:>-

" syntax highlighting is very slow on long lines, disable it after 250 col
" If this does not help, just use :syntax off on that file!
set synmaxcol=400	
" disable syntax highlighting on large files. seems impossible to switch back
" on after open that file, but comment this line
autocmd BufWinEnter * if line2byte(line("$") + 1) > 10485760 | syntax clear | endif

"autocmd FileType des setlocal et sta sw=4 sts=4
autocmd FileType python setlocal et sta sw=4 sts=4
"autocmd FileType html setlocal noet sta sw=4 sts=4
"autocmd FileType xsl setlocal noet sta sw=4 sts=4
"autocmd FileType xml setlocal noet sta sw=4 sts=4
"autocmd FileType tpl setlocal noet sta sw=4 sts=4
"autocmd FileType php setlocal et sta sw=4 sts=4
autocmd FileType c setlocal expandtab ts=4 sw=4 sts=4
autocmd FileType cpp setlocal expandtab ts=4 sw=4 sts=4
"autocmd FileType js setlocal et sta sw=4 sts=4

let python_highlight_all = 1
let python_highlight_space_errors = 0

autocmd FileType python,c,cpp set list listchars=tab:>\     " show tab chars
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
"let python_highlight_all = 1
"Python2Syntax
""powerline
"set rtp+=/lib/python2.7/site-packages/powerline/bindings/vim/
"set laststatus=1

" press F10 to show the sytax highlighting group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
