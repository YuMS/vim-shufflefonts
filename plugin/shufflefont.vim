" Plugin for shuffling fonts.

if exists("loaded_shufflefont")
    finish
endif
let loaded_shufflefont = 1


" Save 'cpoptions' and set Vim default to enable line continuations.
let s:save_cpoptions = &cpoptions
set cpoptions&vim

if ! hasmapto("<Plug>ShufflefontBegin")
    nmap <silent> <Leader><Leader><leader>  <Plug>ShufflefontBegin
endif

" Externally mappable mappings to internal mappings.
nmap <silent> <Plug>ShufflefontBegin       <SID>begin<SID>(shufflefont)
nmap <silent> <Plug>ShufflefontQuit        <SID>quit

" "Shuffle font" mode mappings.  (shufflefont)<KEY> maps <KEY> in "shuffle  font" mode.
nmap <silent> <SID>(shufflefont)<leader>        <SID>shuffle<SID>(shufflefont)
nmap <silent> <SID>(shufflefont)q               <SID>quit
nmap <silent> <SID>(shufflefont)<SPACE>         <SID>quit
nmap <silent> <SID>(shufflefont)<CR>            <SID>quit
nmap <silent> <SID>(shufflefont)                <SID>quit

" Action mappings.
nnoremap <silent> <SID>begin       :<C-u>call shufflefont#begin()<CR>
nnoremap <silent> <SID>shuffle     :<C-u>call shufflefont#shuffle()<CR>
nnoremap <silent> <SID>quit        :<C-u>call shufflefont#quit()<CR>

" Restore saved 'cpoptions'.
let &cpoptions = s:save_cpoptions
" vim: sts=4 sw=4 tw=80 et ai:
