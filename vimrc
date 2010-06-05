" Line numbering on
set nocompatible
set background=dark
set nu
set shiftwidth=2
set tabstop=2
syntax on
set expandtab
set backupdir=~/.vim/backup/
set swapfile
set path=.,~/
set backspace=indent,eol,start
set smartindent "Turn on smartindent cindent|smartindent|autoindent
set textwidth=72
set pastetoggle=<C-P>
"Turn on syntax highligting
if has("syntax")
  set syntax=on
endif

let g:name = "Ronni Elken Lindsgaard"
let g:mail = "ronni@diku.dk"

"Togglepaste

if has("eval")
  "Define headerfunctions for different type of work
  function! HeaderMS()
    put = "/***********************************************************"
    put = " *"
    put = " * Ronni Elken Lindsgaard <ronni@mediastyle.dk>"
    put = " * Copyright 2010 Mediastyle"
    put = " *"
    put = " **********************************************************/"
  endfun
  function! HeaderPrivate()
    put = '/*'
    put = ' * Copyright 2010 Ronni Elken Lindsgaard <ronni@diku.dk>'
    put = ' * Distribute freely as long as you do not make money off of it'
    put = ' */ '
  endfun

  "Define standard Makefiles"
  function! MakePDF()
	  let l:basename = input("Basename (without .tex): ")
		let l:reader = input("PDF reader: ","evince")
    
		0put = 'BASENAME='. basename
		put = ''
    put = 'default: compile view'
    put = 'compile:'
	  put = '	pdflatex $(BASENAME).tex && pdflatex $(BASENAME).tex'
    put = ''
	  put = 'view: compile'
		put = '	' . reader . ' $(BASENAME).pdf'
    put = ''
	  put = 'print:'
    put = ''
	  call setline(line("."),"	cat $(BASENAME).pdf | ssh ask.diku.dk lpr -P m1a")
    put = ''
		put = 'clean:'
		put = '	rm $(BASENAME).aux $(BASENAME).log $(BASENAME).toc'
		 
  endfun
	function! MakeC()
		let l:cc = input("Compiler [gcc]: ","gcc")
		let l:flags = input("Compiler: ", "-Wall -pedantic -std=99 -ggdb")
		let l:source = input("Source files: ","main.c")
		let l:target = input("Output file: ")
		0put = 'CC=' . cc
		put = 'CFLAGS=' . flags
		put = 'SRC_FILES=' . source
		put = ''
		put = 'default: compile'
		put = ''
		put = 'compile:'
		put = ''
	endfun

	function! MakeMake()
		let l:make = input("Type of makefile [PDF,C]: ","PDF")
		call Make{make}()
	endfun
  function! XhtmlDoctype()
     put = '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">'
     put = '<html xmlns=\"http://www.w3.org/1999/xhtml\">'
  endfun

  function! CleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
      return "\<Tab>"
    else
      return "\<C-X>"
    endif
  endfun

  function! Lfigure()
    let l:options = input("Options: ","H!")
    let l:caption = input("Caption: ")
    let l:content = input("Content: ")
    put = '\begin{figure}[' . options . ']'
    put = '\begin{center}'
    put = content
    put = '\caption{' . caption . '}'
    put = '\end{center}'
    put = '\end{figure}'
  endfun
     function! IncludeGuardText()
         let l:t = substitute(expand("%"), "[./]", "_", "g")
         return toupper("GUARD_" . l:t)
     endfunction
     function! MakeIncludeGuards()
         norm gg
         /^$/
         norm 2O
         call setline(line("."), "#ifndef " . IncludeGuardText())
         norm o
         call setline(line("."), "#define " . IncludeGuardText() . " 1")
         norm G
         norm o
         call setline(line("."), "#endif")
     endfunction
 autocmd BufNewFile *.h 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
             \ call MakeIncludeGuards() |
             \ set sw=4 sts=4 et foldmethod=syntax |
             \ norm G
  function! Author()
    call setline(1, "Author: " . g:name . " <" . g:name . ">") 
  endfun

"  function! AbbreviateHTML()
    iabbrev <buffer> <div> <div></div>
    iabbrev <buffer> <table> <table><CR><CR></table><Up><Space>
    iabbrev <buffer> <tr> <tr><CR><CR></tr><Up><Space>
    iabbrev <buffer> <td> <td></td><Left><Left><Left><Left><Left><C-R>
"  endfun
  function! AbbrevPHP()
    iabbrev <buffer> jfun function()<CR>{<CR>}<Up><Up><End><Left><Left>
    iabbrev <buffer> jltrim ltrim(,'/')<Left><Left><Left><Left><Left><C-R>
    iabbrev <buffer> jrtrim rtrim(,'/')<Left><Left><Left><Left><Left><C-R>
    iabbrev <buffer> jprintr print_r(,true)<Left><Left><Left><Left><Left><Left><C-R>
    iabbrev <buffer> dmessage drupal_set_message()<Left><C-R>
"    iabbrev <buffer> jnodeapi 
"    iabbrev <buffer> jdx /*<CR><CR>/<Up>
  endfun
  function! AbbrevC()
    iabbrev jmain in int main( int argc, const char* argv[] )<CR>{<CR><CR>}<Up><Space>
    iabbrev jin #include
    iabbrev jdef #define
    iabbrev jio #include <stdio.h>
    iabbrev jlib #include <stdlib.h>
  endfun
  function! AbbrevProg()
    iabbrev jwhile while()<CR>{<CR>}<Up><Up><End><Left><C-R>
    iabbrev jif if()<CR>{<CR>}<Up><Up><End><Left><C-R>
    iabbrev jelse else {<CR>}<Up><End><C-R>
    iabbrev jfor for(;;)<CR>{<CR>}<Up><Up><End><Left><Left><Left><C-R>
  endfun
"  endfun
   function! AbbrevLatex()
    iabbrev <buffer> jbe \begin{}<Left><C-R>
    iabbrev <buffer> je \end{}<Left><C-R>
    iabbrev <buffer> jfrac \frac{}{}<Left><Left><Left><C-R>
    iabbrev <buffer> jsum \sum_{}^{}<Left><Left><Left><Left><C-R>
    iabbrev <buffer> jalign \begin{align*}<CR><CR>\end{align*}<Up><C-R>
    "iabbrev <buffer> jcycle \left(\begin{array\right)
    iabbrev <buffer> jlist \begin{itemize}<CR><CR>\end{itemize}<Up><C-R>
    iabbrev <buffer> jenum \begin{enumerate}<CR><CR>\end{enumerate}<Up><C-R>
    iabbrev <buffer> jdesc \begin{description}<CR><CR>\end{description}<Up><C-R>
    iabbrev <buffer> jii \item
    iabbrev <buffer> jmod \pmod{}<Left><C-R>
    iabbrev <buffer> ==> \Rightarrow
    iabbrev <buffer> <== \Leftarrow
    iabbrev <buffer> <=> \Leftrightarrow
    iabbrev <buffer> != \neq
    iabbrev <buffer> jsec \section{}<Left><C-R>
    iabbrev <buffer> jssec \subsection{}<Left><C-R>
    iabbrev <buffer> jsssec \subsubsection{}<Left><C-R> 
    iabbrev <buffer> jinn \in \mathbb{N}<C-R>
    iabbrev <buffer> jinz \in \mathbb{Z}<C-R>
    iabbrev <buffer> jinr \in \mathbb{R}<C-R>
    iabbrev <buffer> jinq \in \mathbb{Q}<C-R>
    iabbrev <buffer> jinv \in V<C-R>
    iabbrev <buffer> $$ $$<Left><C-R>
    iabbrev <buffer> jtoc \tableofcontents
    "Make easy braces
    iabbrev <buffer> jpar \left(\right)<Left><Left><Left><Left><Left><Left><Left>
    iabbrev <buffer> jlbrace \lbrace
    iabbrev <buffer> jbrace \lbrace\rbrace<Left><Left><Left><Left><Left><Left><Left>
    iabbrev <buffer> jceil \lceil\rceil<Left><Left><Left><Left><Left><Left>
    iabbrev <buffer> jfloor \lfloor\rfloor<Left><Left><Left><Left><Left><Left><Left>
    iabbrev <buffer> ... \ldots
    iabbrev <buffer> *** \cdots
   endfun
  
  inoremap <Tab>  <C-R>=CleverTab()<CR>
if has("autocmd")
  autocmd BufNewFile,BufRead *.php,*.module,*.install set syn=php |
    \ call AbbrevPHP() |
    \ call AbbrevProg()
  autocmd BufnewFile,BufRead *.c,*.h call AbbrevC()
  autocmd BufNewFile *.html 0r ~/.vim/skeletons/skeleton.html
  autocmd BufNewFile *.tex 0r ~/.vim/skeletons/skeleton.tex
  autocmd BufNewFile,BufRead *.tex call AbbrevLatex()
  autocmd BufNewFile,BufRead .*rc set textwidth=0
  autocmd BufNewFile *.py 0r ~/.vim/skeletons/skeleton.py | set textwidth=0
  autocmd BufRead *.css set smartindent
  autocmd BufNewFile *.sh 0put='#!/bin/sh' 
  autocmd BufNewFile,BufRead Makefile,makefile set noexpandtab | set list
	autocmd BufNewFile Makefile,makefile call MakeMake()
  ":autocmd cssfiles BufRead *.css set complete=k~/.vim/dictionaries/css.dict
  "set comments=s1:(*,mb:*,ex:*)
  "set comments+=sl:/*,mb:*,elx:*/
  autocmd BufRead *.module set syn=php
  autocmd FileType mail,human set nohlsearch formatoptions+=t textwidth=72 spell spelllang=da
endif
endif

