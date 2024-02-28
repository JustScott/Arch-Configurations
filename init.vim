" init.vim - part of the Arch-Configurations project
" Copyright (C) 2023, Scott Wyman, development@scottwyman.me
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU Affero General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU Affero General Public License for more details.
"
" You should have received a copy of the GNU Affero General Public License
" along with this program.  If not, see <https://www.gnu.org/licenses/>.

set incsearch                   " Searches for matches live
set ignorecase                    " Do case insensitive matching
set tabstop=4                     " Default indentation of 4 spaces
set shiftwidth=4                 "Default indentation again"
autocmd FileType dart,yaml setlocal tabstop=2 shiftwidth=2 "Only use 2 spaces for tabs in dart files
set whichwrap+=<,>,[,]      " Allows wrapping to next line with arrow keys
set mouse=                      " Turn Mouse off
syntax on                             " Gives files syntax highlighting
set autoindent                  " Automatically indent when moving to next line
set expandtab                   " Automatically converts tabs to spaces
filetype on                            " Detects files for syntax highlighting automatically
augroup remember_folds     " Saves folds automatically
    autocmd BufWinLeave * mkview
    autocmd BufWinEnter * silent! loadview
augroup end
set splitright          " Open new vertical windows on the right 
set number relativenumber

" Remaps the window navigation keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make resizing easier using CTRL+arrow_keys
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" Exit terminal mode with CTRL+e
tnoremap <C-e> <C-\><C-n>

" Folding python code
set foldmethod=indent
set foldmarker={,}
nnoremap <space> za
vnoremap <space> zf

" Multiline Commenting
"  Most languages use //
vnoremap <C-c> :norm i//<CR>
vnoremap <C-\> :norm ^xx<CR>
"  python & bash use `#` for comments
autocmd FileType python,bash vnoremap <C-c> :norm i#<CR> 
autocmd FileType python,bash vnoremap <C-\> :norm ^x<CR>

" Make calcurse documents highlight markdown
autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown

" Clear the current search highlight
nnoremap <C-n> :noh<CR>

" Turn line numbers on and off
nnoremap <C-P> :set number relativenumber<CR>
nnoremap <C-O> :set nonumber norelativenumber<CR>

" Manage tabs
nnoremap <C-T> :tabnew<CR>
nnoremap <C-]> :tabnext<CR>
nnoremap <C-[> :tabprevious<CR>
nnoremap <C-Q> :tabclose<CR>

" Close the current window
nnoremap <C-D> :q<CR>

" Open up a terminal window below the current window without line numbers
"  laststatus=0 -> Remove the terminal status line
nnoremap <C-S> :belowright split\|term<CR>:set nonumber norelativenumber<CR>:set laststatus=0<CR>:startinsert<CR>
" Replace the current window with a terminal
nnoremap <C-W> :term<CR>:set nonumber norelativenumber<CR>:set laststatus=0<CR>:startinsert<CR>

" Specify the directory where vim-plug should manage your plugins
call plug#begin()

" lf filemanager in vim
"  use `\f` to open the window
"  `e` to edit in the floating window
"  `l` to edit in the main window
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'

" End vim-plug configuration
call plug#end()


" Use system clipboard for copy and paste
set clipboard=unnamedplus
