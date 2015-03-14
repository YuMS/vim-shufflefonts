" Autoload portion of plugin/shufflefont.vim.

" dependent on fontsize.vim"

if !exists("autoloaded_fontsize")
    finish
endif

if exists("autoloaded_shufflefont")
    finish
endif
let autoloaded_shufflefont = 1

let s:updatetime = &updatetime
let s:fontsList = [
    \'Source_Code_Pro',
    \'Consolas',
    \'Share_Tech_Mono',
    \'PT_Mono',
    \'ProFontWindows',
    \'NovaMono',
    \'Lucida_Console',
    \'InputMono',
    \'Inconsolata',
    \'Fira_Mono',
    \'Droid_Sans_Mono',
    \'Cutive_Mono',
    \'Cousine',
    \'Courier_New',
    \'Courier',
    \'BitStream_Vera_Sans_Mono',
    \'Arial_monospaced_for_SAP',
    \'Anonymous_Pro'
\]

let s:rnd = localtime() % 0x10000

function! s:random(n)
    let s:rnd = (s:rnd * 31421 + 6927) % 0x10000
    return s:rnd * a:n / 0x10000
endfunction

function! shufflefont#echofont()
    echo 'Current font: ' getfontname()
    autocmd! shufflefont CursorHold *
    let &updatetime = s:updatetime
endfunction

function! shufflefont#shuffle()
    let fontSize = fontsize#getSize(getfontname())
    let index = s:random(len(s:fontsList))
    let &guifont = fontsize#setSize(s:fontsList[index], fontSize)
    let &updatetime = 1
    autocmd shufflefont CursorHold * call shufflefont#echofont()
endfunction

function! shufflefont#display()
    redraw
    sleep 100m
    echo fontsize#fontString(getfontname()) . "<leader>"
endfunction

function! shufflefont#begin()
    call shufflefont#display()
endfunction

function! shufflefont#quit()
    echo fontsize#fontString(getfontname()) . " (Done)"
endfunction

augroup shufflefont
    au BufEnter * :call shufflefont#shuffle()
augroup END

" vim: sts=4 sw=4 tw=80 et ai:
