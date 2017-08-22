" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file based on ron

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "aulddays"

let s:alyellow=221

hi Normal		guifg=black	guibg=black
hi NonText		guifg=brown ctermfg=95
hi comment		guifg=green ctermfg=70
hi constant		guifg=cyan	gui=bold
hi identifier	guifg=cyan	gui=NONE
hi statement	guifg=lightblue	gui=NONE ctermfg=153
hi preproc		guifg=Pink2
hi type			guifg=seagreen	gui=bold  ctermfg=115
hi special		term=bold ctermfg=214 guifg=yellow
hi ErrorMsg		guifg=Black	guibg=Red
hi WarningMsg	guifg=Black	guibg=Green
hi Error		guibg=Red
hi Todo			guifg=Black	guibg=orange
hi Cursor		guibg=#60a060 guifg=#00ff00
hi Search		guibg=lightslateblue ctermbg=221
hi IncSearch	gui=NONE guibg=steelblue
hi LineNr		guifg=darkgrey ctermfg=101
hi title		guifg=darkgrey
hi StatusLineNC	gui=NONE guifg=lightblue guibg=darkblue
hi StatusLine	gui=bold	guifg=cyan	guibg=blue
hi label		guifg=gold2
hi operator		guifg=orange	ctermfg=yellow
hi clear Visual
hi Visual		term=reverse cterm=reverse gui=reverse
hi DiffChange   ctermbg=22 guibg=darkgreen
hi DiffText		ctermbg=52 guibg=olivedrab
hi DiffAdd		ctermbg=17 guibg=slateblue
hi DiffDelete   ctermbg=52 guibg=coral
hi Folded		guibg=gray30
hi FoldColumn	guibg=gray30 guifg=white
hi cIf0			guifg=gray
hi Conceal		cterm=bold ctermbg=237 ctermfg=136
hi Number		ctermfg=208
hi CursorLine   term=underline cterm=bold ctermbg=235 guibg=Grey40 
hi ColorColumn  ctermbg=236

hi link Boolean 	Number
hi link Float       Number

" for tab hilighting (in listchars).
" matchadd does the trick, and -1 in matchadd makes search highlighting override it
hi GroupTab     ctermfg=95
call matchadd("GroupTab", "\t", -1)
" The above does not work for new windows (such as those created by :split), use WinEnter to handle that
autocmd VimEnter * autocmd WinEnter * let w:tabmatchadded=1	" tabmatchadded ensures matchadd only once
autocmd VimEnter * let w:tabmatchadded=1	" WinEnter doesn't fire on the first window
autocmd WinEnter * if !exists('w:tabmatchadded') | call matchadd("GroupTab", "\t", -1) | endif
