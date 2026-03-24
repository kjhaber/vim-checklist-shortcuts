" vim-checklist-shortcuts
" Copy long checklist file to short version (e.g. for shortening a long
" grocery list for use in actual grocery store)
" See ~/.config-local/bin/shorten-md-checklist

if exists('g:loaded_vim_checklist_shortcuts')
  finish
endif
let g:loaded_vim_checklist_shortcuts = 1

let s:plugin_script_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
echom s:plugin_script_path


if !exists('g:vim_checklist_shortcuts_map_keys')
  let g:vim_checklist_shortcuts_map_keys = 1
endif

function! ChecklistShortCopy()
  let l:orig_filename = expand('%:p')
  let l:short_filename = substitute(l:orig_filename, '.md', 'Short.md', '')
  silent execute "!" . s:plugin_script_path . "/shorten-md-checklist.sh " . l:orig_filename . " > " . l:short_filename
  echom "Wrote " . l:short_filename
endfunction
command! ChecklistShortCopy call ChecklistShortCopy() | execute "normal! gg"

function! ChecklistShortOpen()
  " Open short version of checklist file in new vertical split
  let l:orig_filename = expand('%:p')
  let l:short_filename = substitute(l:orig_filename, '.md', 'Short.md', '')
  execute "vsplit " . l:short_filename
endfunction
command! ChecklistShortOpen call ChecklistShortOpen()

function! ChecklistJumpToNextCheckbox()
  let result = search('\[x\]', 'W')
  if result == 0
    echo "No unchecked checkbox found"
  endif
endfunction
command! ChecklistJumpToNextCheckbox call ChecklistJumpToNextCheckbox()

function! ChecklistJumpToNextUncheckedBox()
  let result = search('\[ \]', 'W')
  if result == 0
    echo "No unchecked checkbox found"
  endif
endfunction
command! ChecklistJumpToNextUncheckedBox call ChecklistJumpToNextUncheckedBox()

function! ChecklistJumpToPrevCheckbox()
  let result = search('\[x\]', 'Wb')
  if result == 0
    echo "No unchecked checkbox found"
  endif
endfunction
command! ChecklistJumpToPrevCheckbox call ChecklistJumpToPrevCheckbox()

function! ChecklistJumpToPrevUncheckedBox()
  let result = search('\[ \]', 'Wb')
  if result == 0
    echo "No unchecked checkbox found"
  endif
endfunction
command! ChecklistJumpToPrevUncheckedBox call ChecklistJumpToPrevUncheckedBox()


if g:vim_checklist_shortcuts_map_keys
  nmap <leader>c> :ChecklistShortOpen<CR>
  nmap <leader>cc :ChecklistShortCopy<CR>
  nmap <leader>cX :ChecklistJumpToPrevCheckbox<CR>
  nmap <leader>cx :ChecklistJumpToNextCheckbox<CR>
  nmap <leader>co :ChecklistJumpToNextUncheckedBox<CR>
  nmap <leader>cO :ChecklistJumpToPrevUncheckedBox<CR>
endif

