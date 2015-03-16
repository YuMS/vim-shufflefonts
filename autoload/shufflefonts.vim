" Autoload portion of plugin/shufflefonts.vim.

if exists("autoloaded_shufflefonts")
    finish
endif
let autoloaded_shufflefonts = 1

" Modified Font examples from http://vim.wikia.com/wiki/VimTip632

" Regex values for each platform split guifont into three
" sections (\1, \2, and \3 in capturing parentheses):
"
" - prefix
" - delimiter
" - size (possibly fractional)
" - suffix (possibly including extra fonts after commas)

" gui_gtk2: Courier\ New\ 11
let fontsize#regex_gtk2 = '\(.\{-}\)\( \)\(\d\+\)\(.*\)'

" gui_photon: Courier\ New:s11
let fontsize#regex_photon = '\(.\{-}\)\(:s\)\(\d\+\)\(.*\)'

" gui_kde: Courier\ New/11/-1/5/50/0/0/0/1/0
let fontsize#regex_kde = '\(.\{-}\)\(\/\)\(\d\+\)\(.*\)'

" gui_x11: -*-courier-medium-r-normal-*-*-180-*-*-m-*-*
" TODO For now, just taking the first string of digits.
let fontsize#regex_x11 = '\(.\{-}\)\(-\)\(\d\+\)\(.*\)'

" gui_other: Courier_New:h11:cDEFAULT
let fontsize#regex_other = '\(.\{-}\)\(:h\)\(\d\+\)\(.*\)'

if has("gui_gtk2")
    let s:regex = fontsize#regex_gtk2
elseif has("gui_photon")
    let s:regex = fontsize#regex_photon
elseif has("gui_kde")
    let s:regex = fontsize#regex_kde
elseif has("x11")
    let s:regex = fontsize#regex_x11
else
    let s:regex = fontsize#regex_other
endif

let s:updatetime = &updatetime
let s:fontsList = []

let s:rnd = localtime() % 0x10000

function! s:random(n)
    let s:rnd = (s:rnd * 31421 + 6927) % 0x10000
    return s:rnd * a:n / 0x10000
endfunction

function! shufflefonts#echofont()
    echo 'Current font: ' getfontname()
    autocmd! shufflefonts CursorHold *
    let &updatetime = s:updatetime
endfunction

function! shufflefonts#shuffle()
    if !len(s:fontsList)
        return
    endif
    let fontSize = fontsize#getSize(getfontname())
    let index = s:random(len(s:fontsList))
    let decodedFont = fontsize#decodeFont(getfontname())

    if match(decodedFont, s:regex) != -1
        let newFont = substitute(decodedFont, s:regex, s:fontsList[index] . '\2' . fontSize . '\4', '')
    else
        let newFont = decodedFont
    endif
    let &guifont = fontsize#setSize(newFont, fontSize)
    let &updatetime = 1
    autocmd shufflefonts CursorHold * call shufflefonts#echofont()
endfunction

function! shufflefonts#display()
    redraw
    sleep 100m
    echo fontsize#fontString(getfontname()) . "<leader>"
endfunction

function! shufflefonts#begin()
    call shufflefonts#display()
endfunction

function! shufflefonts#quit()
    echo fontsize#fontString(getfontname()) . " (Done)"
endfunction

function! shufflefonts#init()
    if exists('g:shufflefonts_fonts_list')
        let s:fontsList = g:shufflefonts_fonts_list
    endif
    augroup shufflefonts
        au BufEnter * :call shufflefonts#shuffle()
    augroup END
endfunction

" vim: sts=4 sw=4 tw=80 et ai:
