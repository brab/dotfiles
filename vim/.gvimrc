set guioptions-=L "remove left hand scrollbar with vertically split window
set guioptions-=T "remove toolbar
set guioptions-=m "remove menubar
"turned off for OSX, causes problems
"set guioptions-=r "remove right scrollbar

" Font stuff
set anti "antialias fonts
if has("gui_gtk2")
    "Ubuntu
    try
        set guifont=SourceCodePro\ 12
    catch
        set guifont=UbuntuMono\ 12
    endtry
elseif has("gui_macvim")
    "OSX
    try
        set guifont=SourceCodePro:h12
    catch
        set guifont=Menlo:h12
    endtry
endif
