" Autoload portion of plugin/shufflefonts.vim.

if exists("autoloaded_shufflefonts")
    finish
endif
let autoloaded_shufflefonts = 1

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
    let &guifont = fontsize#setSize(s:fontsList[index], fontSize)
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
