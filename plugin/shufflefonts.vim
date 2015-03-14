" Plugin for shuffling fonts.

if exists("loaded_shufflefonts")
    finish
endif
let loaded_shufflefonts = 1


" Save 'cpoptions' and set Vim default to enable line continuations.
let s:save_cpoptions = &cpoptions
set cpoptions&vim

if ! hasmapto("<Plug>ShufflefontBegin")
    nmap <silent> <Leader><Leader><leader>  <Plug>ShufflefontBegin
endif

" Externally mappable mappings to internal mappings.
nmap <silent> <Plug>ShufflefontBegin       <SID>begin<SID>(shufflefonts)
nmap <silent> <Plug>ShufflefontQuit        <SID>quit

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

" Restore saved 'cpoptions'.
let &cpoptions = s:save_cpoptions
" vim: sts=4 sw=4 tw=80 et ai:
