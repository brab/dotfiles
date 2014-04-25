set guioptions-=L "remove left hand scrollbar with vertically split window
set guioptions-=T "remove toolbar
set guioptions-=m "remove menubar
"turned off for OSX, causes problems
"set guioptions-=r "remove right scrollbar

" Font stuff
set anti "antialias fonts
" OSX formatted
try
    set guifont=Cousine:h12
catch
    set guifont=Menlo:h12
endtry
