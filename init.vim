" init.vim - part of the Arch-Configurations project
" Copyright (C) 2023-2025, JustScott, development@justscott.me
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


"
" Syntax Refresher
"    map - Map a key in normal & visual+select modes
"    noremap - map a non-recurseive key in normal & visual+select modes
"
"    Mapping Mode Prefix:
"    --------------
"     + example: `nmap`
"     * `n` - only in normal mode
"     * `v` - only visual+select mode
"     * `x` - visual only
"     * `s` - select only
"     * `i` - insert only
"     * `c` - command-line only
"
"    <CR> - Carriage Return: Programmatically click enter
"

set incsearch                   " Searches for matches live
set ignorecase                    " Do case insensitive matching
set tabstop=4                    " Sets the width of a tab character to 4 spaces.
set shiftwidth=4                 " Sets the number of spaces to use for each step of indentation.
autocmd FileType dart,yaml,c,cpp,markdown setlocal tabstop=2 shiftwidth=2 "Only use 2 spaces for tabs in dart files
set expandtab                    " Use spaces instead of tabs
set autoindent                   " indent when moving to next line
set whichwrap+=<,>,[,]      " Allows wrapping to next line with arrow keys
set mouse=                      " Turn Mouse off
syntax on                             " Gives files syntax highlighting
filetype on                            " Detects files for syntax highlighting automatically
set splitright          " Open new vertical windows on the right 
set number relativenumber
colorscheme vim " Use the pre version 0.10 color schemes for now

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

" Folding python code
set foldmethod=indent
set foldmarker={,}
set foldlevel=0 " Close all folds when opening file
nnoremap <space> za
nnoremap <C-space> :set foldlevel=0<CR>
"augroup remember_folds     " Saves folds automatically
"    autocmd BufWinLeave * mkview
"    autocmd BufWinEnter * silent! loadview
"augroup end


" Multiline Commenting
"  Detect /bin/bash at the start of bash files, and set the file type to sh
"   * helpful for executable bash files that don't have a file suffix
autocmd BufRead,BufNewFile * if getline(1) =~# '^#!.*\bash' | setfiletype sh | endif
"  Most languages use //
vnoremap <C-c> :norm i//<CR>
vnoremap <C-\> :norm ^xx<CR>
"  python & bash use `#` for comments
autocmd FileType python,sh vnoremap <C-c> :norm i#<CR> 
autocmd FileType python,sh vnoremap <C-\> :norm ^x<CR>

" Make calcurse documents highlight markdown
autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown

" Clear the current search highlight
nnoremap <C-n> :noh<CR>

" Turn line numbers on and off
nnoremap <C-P> :set number relativenumber<CR>
nnoremap <C-O> :set nonumber norelativenumber<CR>

" Manage tabs
nnoremap <C-T> :tabnew<CR>:term<CR>:set nonumber norelativenumber<CR>:set laststatus=0<CR>:startinsert<CR>
nnoremap <C-CR> :tabnext<CR>
nnoremap <C-backspace> :tabprevious<CR>
nnoremap <C-Q> :tabclose<CR>

" Close the current window
nnoremap <C-D> :q<CR>

" Use system clipboard for copy and paste
set clipboard=unnamedplus

" Open up a terminal window below the current window without line numbers
"  laststatus=0 -> Remove the terminal status line
nnoremap <C-S> :belowright split\|term<CR>:set nonumber norelativenumber<CR>:set laststatus=0<CR>:startinsert<CR>
" Replace the current window with a terminal
nnoremap <C-W> :term<CR>:set nonumber norelativenumber<CR>:set laststatus=0<CR>:startinsert<CR>
" Exit terminal mode with CTRL+e
tnoremap <C-e> <C-\><C-n>

" Open the fzf tool
nnoremap <C-f> :FZF<CR>

" Specify the directory where vim-plug should manage your plugins
call plug#begin()

" lf filemanager in vim
"  use `\f` to open the window
"  `e` to edit in the floating window
"  `l` to edit in the main window
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}

" End vim-plug configuration
call plug#end()
