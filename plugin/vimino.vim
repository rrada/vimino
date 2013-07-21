" ============================================================================
" File:        vimino.vim
" Description: vim plugin that enables arduino development with ino tool
" Maintainer:  Radek Rada <radek.rada@gmail.com>
" Last Change: Jul 20, 2013
" License:     Copyright (C) 2013 Radek Rada.
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
"
" ============================================================================

let s:vimino_version = '0.1'

" Load Once: {{{1
if exists("loaded_vimino")
    finish
endif
let loaded_vimino = 1

" plugin driectory
let s:helper_dir = expand("<sfile>:h")

function! s:PrintStatus(result)
  if a:result == 0
    echohl Statement | echomsg "Succeeded." | echohl None
  else
    echohl WarningMsg | echomsg "Failed." | echohl None
  endif
endfunction

" Private: Invoke ino command with action
function! s:InvokeInoCli(param)
  let l:f_name = expand('%:p')
  if !empty(l:f_name)
    execute "w"
    if a:param == "build"
      echomsg "Building..."
    elseif a:param == "clean"
      echomsg "Cleaning..."
    elseif a:param == "upload"
      echomsg "Uploading firmware..."
    elseif a:param == "serial"
      echomsg "Conecting to serial port..."
    endif

    let l:project_dir = fnamemodify(expand('%:p:h'), ':h')
    let l:command = s:helper_dir . "/ino-cli " .
          \ l:project_dir . " " .
          \ a:param
    " echo l:command
    let l:result = system(l:command)
    call s:PrintStatus(v:shell_error)
    echo l:result
    call s:PrintStatus(v:shell_error)
  else
    echohl WarningMsg | echomsg "You have to open a src file, first" | echohl None
    return ""
  endif

endfunction

function! s:InvokeSerialScreen()
  let l:project_dir = fnamemodify(expand('%:p:h'), ':h')
  let l:command = s:helper_dir . "/vimino-serial " .
        \ l:project_dir
  " echo l:command
  let l:result = system(l:command)
  call s:PrintStatus(v:shell_error)
  echo l:result
  call s:PrintStatus(v:shell_error)
endfunction


" Public: Build the current pde file
function! InoBuild()
  call s:InvokeInoCli("build")
endfunction

" Public: Clean project (remove .build dir)
function! InoClean()
  call s:InvokeInoCli("clean")
endfunction

" Public: Upload firmware
function! InoUpload()
  call s:InvokeInoCli("upload")
endfunction

" Public: Connect to serial port
function! InoSerial()
  if g:vimino_serial_screen_prefered == 0
    call s:InvokeInoCli("serial")
  else
    call s:InvokeSerialScreen()
  endif
endfunction

" Default variable settings
if !exists('g:vimino_serial_screen_prefered')
  let g:vimino_serial_screen_prefered = 0
endif

if !exists('g:vimino_map_keys')
  let g:vimino_map_keys = 1
endif

if g:vimino_map_keys
  nnoremap <leader>ib :call InoBuild()<CR>
  nnoremap <leader>ic :call InoClean()<CR>
  nnoremap <leader>iu :call InoUpload()<CR>
  nnoremap <leader>is :call InoSerial()<CR>
endif
