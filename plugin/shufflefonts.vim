" Plugin for shuffling fonts.

if v:version >= 700
    try
        silent echo fontsize#regex_gtk2
    catch
        echoerr "YuMS/vim-shufflefonts is dependent on drmikehenry/vim-fontsize"
        finish
    endtry
endif

if exists("loaded_shufflefonts")
    finish
endif

let loaded_shufflefonts = 1

function! s:check_defined(variable, default)
  if !exists(a:variable)
    let {a:variable} = a:default
  endif
endfunction

call s:check_defined('g:shufflefonts_on_switch', 1)

" Save 'cpoptions' and set Vim default to enable line continuations.
let s:save_cpoptions = &cpoptions
set cpoptions&vim

if !hasmapto("<Plug>ShufflefontsBegin")
    nmap <silent> <Leader><Leader><leader>  <Plug>ShufflefontsBegin
endif

" Externally mappable mappings to internal mappings.
nmap <silent> <Plug>ShufflefontsBegin       <SID>begin<SID>(shufflefonts)
nmap <silent> <Plug>ShufflefontsQuit        <SID>quit

" "Shuffle font" mode mappings.  (shufflefonts)<KEY> maps <KEY> in "shuffle  font" mode.
nmap <silent> <SID>(shufflefonts)<leader>        <SID>shuffle<SID>(shufflefonts)
nmap <silent> <SID>(shufflefonts)q               <SID>quit
nmap <silent> <SID>(shufflefonts)<SPACE>         <SID>quit
nmap <silent> <SID>(shufflefonts)<CR>            <SID>quit
nmap <silent> <SID>(shufflefonts)                <SID>quit

" Action mappings.
nnoremap <silent> <SID>begin       :<C-u>call shufflefonts#begin()<CR>
nnoremap <silent> <SID>shuffle     :<C-u>call shufflefonts#shuffle()<CR>
nnoremap <silent> <SID>quit        :<C-u>call shufflefonts#quit()<CR>

if g:shufflefonts_on_switch
    call shufflefonts#init()
endif

" Restore saved 'cpoptions'.
let &cpoptions = s:save_cpoptions
" vim: sts=4 sw=4 tw=80 et ai:
