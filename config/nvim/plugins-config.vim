" settings       ------------ {{{1
" ================================
let g:indentLine_char = '┆'
let g:indentLine_noConcealCursor=""

" lgrep settings                  {{{1
" ====================================
" Workaround due to:
" https://github.com/junegunn/fzf.vim/issues/448
" See:
" :h lgrep
" :h grepprg
" :h lol[der]

set grepprg=ag

" emmet          ------------ {{{1
" ================================
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\  'extends' : 'jsx',
\  },
\}

" NERDCommenter  ------------ {{{1
" ================================

" space after comment delimiters by default
let g:NERDSpaceDelims = 1

" compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/*','right': '*/' } }

" NERDTree       ------------ {{{1
" ================================

let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['node_modules', 'tmp', 'bower_components']
let NERDTreeMinimalUI = 1

nmap <silent> <leader>n :NERDTreeFind<CR>
nmap <silent> <leader>N :NERDTreeToggle<CR>

" ALE            ------------ {{{1
" ================================

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'markdown': ['vale'],
\   'python': ['pylint'],
\   'solhint': ['solhint'],
\   'text': ['vale']
\}

let g:ale_fixers = {
\     'javascript': ['eslint'],
\     'markdown': ['textlint'],
\     'text': ['textlint'],
\     'typescript': ['eslint'],
\}

let g:ale_set_quickfix=1
let g:ale_set_highlights=1

" colorscheme    ------------ {{{1
" ================================

" colorscheme solarized8_dark_high
" colorscheme gruvbox

" true colors are required for vim in terminal
set termguicolors

" if you prefer the default one, comment out this line
let g:equinusocio_material_darker = 1

" make vertsplit invisible
let g:equinusocio_material_hide_vertsplit = 1

colorscheme equinusocio_material

" vim-airline    ------------ {{{1
" ================================

let g:airline_powerline_fonts = 1
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_solarized_bg='gruvbox'

" let g:airline_theme='molokai'
" let g:airline_solarized_bg='molokai'
let g:airline#extensions#tabline#reformatter = 'unique_tail_improved'

" vim-notes      ------------ {{{1
" http://peterodding.com/code/vim/notes/
" ================================

let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.md'
let g:notes_title_sync = 'rename_file'    " rename file to match title
let g:notes_smart_quotes = 0              " No quote substitution
let g:notes_indexfile = '~/Documents/Notes/.index.db'
let g:notes_conceal_code = 0              " Conceal nothing
let g:notes_list_bullets = ['•', '◦', '▸', '▹', '▪', '▫']
let g:notes_markdown_program='/usr/local/bin/multimarkdown'

" vim-gutter -----------------{{{1
" ================================
"
set updatetime=250

" https://jakobgm.com/posts/vim/git-integration/
" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

" jump to first/last
nnoremap <silent> [C gg:GitGutterNextHunk<cr>
nnoremap <silent> ]C G:GitGutterPrevHunk<cr>

" jump to prev/next
nnoremap <silent> [c :GitGutterPrevHunk<cr>
nnoremap <silent> ]c :GitGutterNextHunk<cr>

" preview hunk
nnoremap <leader>p :GitGutterPreviewHunk<cr>

" coc ----------------------- {{{1
" ================================

" Use `[d` and `]d` for navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gm <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <cr> to confirm complete
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


" open-browser -------------- {{{1
" ================================

let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" fzf ----------------------- {{{1
" ================================

" An action can be a reference to a function that processes selected lines
function! s:build_location_list(lines)
  call setloclist(map(copy(a:lines), '{ "filename": v:val }'))
  lopen
  lw
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_location_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
