set incsearch                   " Searches for matches live
set ignorecase                    " Do case insensitive matching
set tabstop=4                     " Default indentation of 4 spaces
set shiftwidth=4                 "Default indentation again"
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
nnoremap <space> za
vnoremap <space> zf

" Multiline Commenting
vnoremap <C-c> :norm i#<CR>
vnoremap <C-\> :norm ^x<CR>

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
nnoremap <C-S> :belowright split\|term<CR>:set nonumber norelativenumber<CR>
" Replace the current window with a terminal
nnoremap <C-W> :term<CR>:set nonumber norelativenumber<CR>
