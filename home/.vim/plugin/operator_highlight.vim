" Copyright (C) 2011 by Strahinja Markovic
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

if exists( 'g:loaded_operator_highlight' )
  finish
else
  let g:loaded_operator_highlight = 1
endif

if !exists( 'g:ophigh_color_gui' )
  let g:ophigh_color_gui = "cyan"
endif

if !exists( 'g:ophigh_highlight_link_group' )
  let g:ophigh_highlight_link_group = ""
endif


if !exists( 'g:ophigh_color' )
  let g:ophigh_color = "222"
endif

if !exists( 'g:ophigh_filetypes_to_active' )
  let g:ophigh_filetypes_to_active = {}
endif

fun! s:ActiveFiletypeIfNotSet( file_type )
  if get( g:ophigh_filetypes_to_active, a:file_type, 1 )
    let g:ophigh_filetypes_to_active[ a:file_type ] = 1
  endif
endfunction

call s:ActiveFiletypeIfNotSet('python')
call s:ActiveFiletypeIfNotSet('cpp')
"call s:IgnoreFiletypeIfNotSet('help')
"call s:IgnoreFiletypeIfNotSet('markdown')
"call s:IgnoreFiletypeIfNotSet('qf') " This is for the quickfix window
"call s:IgnoreFiletypeIfNotSet('conque_term')
"call s:IgnoreFiletypeIfNotSet('diff')
"call s:IgnoreFiletypeIfNotSet('html')
"call s:IgnoreFiletypeIfNotSet('php')
"call s:IgnoreFiletypeIfNotSet('c')
"call s:IgnoreFiletypeIfNotSet('cpp')
"call s:IgnoreFiletypeIfNotSet('xhtml')
"call s:IgnoreFiletypeIfNotSet('htm')
"call s:IgnoreFiletypeIfNotSet('css')
"call s:IgnoreFiletypeIfNotSet('less')
"call s:IgnoreFiletypeIfNotSet('xml')
"call s:IgnoreFiletypeIfNotSet('sh')
"call s:IgnoreFiletypeIfNotSet('bash')
"call s:IgnoreFiletypeIfNotSet('notes')
"call s:IgnoreFiletypeIfNotSet('jinja')
"call s:IgnoreFiletypeIfNotSet('text')

fun! s:HighlightOperators()
  if !get( g:ophigh_filetypes_to_active, &filetype, 0 )
    return
  endif

  " for the last element of the regex, see :h /\@!
  " basically, searching for "/" is more complex since we want to avoid
  " matching against "//" or "/*" which would break C++ comment highlighting
  syntax match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|)\|(\|{\|}\|\.\|\[\|\]\|/\(/\|*\)\@!"


  if g:ophigh_highlight_link_group != "" 
    exec "hi link OperatorChars " . g:ophigh_highlight_link_group
  else
    exec "hi OperatorChars guifg=" . g:ophigh_color_gui . " gui=NONE"
    exec "hi OperatorChars ctermfg=" . g:ophigh_color . " cterm=NONE"
  endif

endfunction

au Syntax * call s:HighlightOperators()
au ColorScheme * call s:HighlightOperators()


