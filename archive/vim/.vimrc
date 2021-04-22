let mapleader=' '

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'yggdroot/indentline'

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'mhinz/vim-startify'

Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }

" Statusline
" Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-surround'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }

Plug 'tpope/vim-repeat'

Plug 'mattn/emmet-vim'

Plug 'preservim/nerdcommenter'

Plug 'jiangmiao/auto-pairs'

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

Plug 'ryanoasis/vim-devicons'

Plug 'junegunn/fzf.vim', { 'on': 'FZF' }

Plug 'puremourning/vimspector'

Plug 'andrewradev/splitjoin.vim'

Plug 'easymotion/vim-easymotion'

Plug 'lambdalisue/suda.vim', { 'on': 'SudaWrite' }

" Syntax highlight
Plug 'sheerun/vim-polyglot'
Plug 'jaxbot/semantic-highlight.vim', {'on': 'SemanticHighlightToggle'}
" Markdown
Plug 'godlygeek/tabular', {'for': 'markdown'} " Required by plasticboy/vim-markdown
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', {
            \'on': 'MarkdownPreview',
            \'for': 'markdown',
            \'do': 'cd app && yarn install'
            \}

" Snippets
Plug 'honza/vim-snippets'

" REPL
Plug 'rhysd/reply.vim', { 'on': ['Repl', 'ReplAuto'] }
Plug 'metakirby5/codi.vim'

" LSP
Plug 'dense-analysis/ale', { 'tag': '*' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" COC
Plug 'neoclide/coc-snippets', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fannheyward/coc-marketplace', { 'do': 'yarn install --frozen-lockfile' }
Plug 'clangd/coc-clangd', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fannheyward/coc-pyright', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fannheyward/coc-texlab', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-json', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-rls', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-html', { 'do': 'yarn install --frozen-lockfile' }
Plug 'josa42/coc-sh', { 'do': 'yarn install --frozen-lockfile' }
Plug 'josa42/coc-go', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-tabnine', { 'do': 'yarn install --frozen-lockfile' }

" Theme
Plug 'joshdick/onedark.vim'


call plug#end()

"------------------------------------------------------------------------------"
"                                    General                                   "
"------------------------------------------------------------------------------"

" no compatible vi
set nocompatible
" Show line numbers
set nu
set rnu

" Line wrap (number of cols)
set textwidth=90
" Highlight matching brace
set showmatch

" Highlight all search results
set hlsearch
" Enable smart-case search
set smartcase
" Always case-insensitive
set ignorecase
" Searches for strings incrementally
set incsearch

" expand tab to space
set expandtab
" Number of auto-indent spaces
set shiftwidth=4
" Enable smart-indent
set smartindent
" Number of spaces per Tab
set softtabstop=4

" Show row and column ruler information
set ruler

" Number of undo levels
set undolevels=1000

" show partial command in the last line of the screen
set showcmd

" enable filetype plugins
filetype plugin on
filetype indent on

" Auto read when a file is changed from the outside
set autoread

" auto reload changed file
augroup reloadFile
    au FocusGained,BufEnter * checktime
augroup END

" Height of the command bar
set cmdheight=2

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Add a bit extra margin to the left
set foldcolumn=1

" Enable syntax highlighting
syntax enable


" Enable 24-bit RGB color in the TUI
set termguicolors
" backup before overwriting a file
set nobackup
" No backup before overwriting a file,
" the backup is removed after the file was successfully written
set nowritebackup
" No swapfile
set noswapfile
" Don't show Insert or Visual mode
set noshowmode

" Whne off a buffer is unloaded when it is abandoned
set hidden
" If nothing is typed in 300ms the swap file will be written to disk
set updatetime=100

" timeoutlen
set timeoutlen=700

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" if has('gui_running')
set guifont=CaskaydiaCove\ Nerd\ Font:h11
" endif


"------------------------------------------------------------------------------"
"                                   Filetype                                   "
"------------------------------------------------------------------------------"
augroup setFiletype
    au!
    au BufNewFile,BufRead *.cls set filetype=tex
augroup END


"------------------------------------------------------------------------------"
"                                  Keybindings                                 "
"------------------------------------------------------------------------------"
" Fast saving
nnoremap <leader>w :w<CR>
" fast quit
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
" move between windows
noremap <C-j> <C-W>j
noremap <C-h> <C-W>h
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l
tnoremap <C-j> <C-\><C-n><C-W>j
tnoremap <C-h> <C-\><C-n><C-W>h
tnoremap <C-k> <C-\><C-n><C-W>k
tnoremap <C-l> <C-\><C-n><C-W>l

" copy to clipboard
nnoremap <leader>cp :%y+<CR>
vnoremap <leader>cp "+y

" For C++ header
noremap <leader>hpp :set filetype=cpp<CR>

" Buffer switching
nnoremap <leader>tp :bprevious<CR>
nnoremap <leader>tn :bnext<CR>
nnoremap <leader>bd :bdelete<CR>
" tab navigation like chrome
nnoremap <M-1> :bfirst<CR>
nnoremap <M-2> :bfirst<CR>:bn<CR>
nnoremap <M-3> :bfirst<CR>:2bn<CR>
nnoremap <M-4> :bfirst<CR>:3bn<CR>

" resource
nnoremap <leader>res :source %<CR>
nnoremap <leader>nh :noh<CR>


"------------------------------------------------------------------------------"
"                                 nvim specific                                "
"------------------------------------------------------------------------------"
if has('nvim')
    let g:python3_host_prog='/bin/python3'
    nnoremap <leader>tm :terminal<CR>
endif


"------------------------------------------------------------------------------"
"                                   neoformat                                  "
"------------------------------------------------------------------------------"
" shortcut
noremap <leader>f :Neoformat<CR>

" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
" python format
let g:neoformat_enabled_python = ['black']
" Haskell
let g:neoformat_enabled_haskell = ['ormolu']
" shell format
let g:shfmt_opt='-ci'
let g:neoformat_toml_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--stdin-filepath', '"%:p"'],
            \ 'stdin': 1,
            \}
" toml
let g:neoformat_enabled_toml = ['prettier']

" Makefile
let g:neoformat_make_makefmt = {
            \ 'exe': 'unexpand',
            \ 'args': ['-t 2'],
            \ 'stdin': 1,
            \}
let g:neoformat_enabled_make = ['makefmt']


"------------------------------------------------------------------------------"
"                                  lightline                                   "
"------------------------------------------------------------------------------"
let g:lightline = {
            \'colorscheme': 'onedark',
            \'active': {
            \  'left': [['paste'],
            \           ['fugitive', 'filename', 'readonly', 'modified'],
            \           ['gitgutter', 'cocstatus']],
            \  'right': [['lineinfo'],
            \            ['percent'],
            \            ['fileformat', 'fileencoding', 'filetype'],
            \            ['aleinfo']]
            \},
            \'component_function': {
            \  'cocstatus': 'coc#status',
            \  'aleinfo': 'Alestatus',
            \  'gitgutter': 'GitStatus',
            \  'fugitive': 'FugitiveHead',
            \  'fileformat': 'Cfileformat',
            \  'fileencoding': 'Cfileencoding'
            \},
            \}


function! Cfileformat() abort
    let l:s = &fileformat
    return l:s ==# 'unix' ? '' : l:s
endfunction

function! Cfileencoding() abort
    let l:s = &fileencoding
    return l:s ==# 'utf-8' ? '' : l:s
endfunction


function! GitStatus() abort
    let [a, m, r] = GitGutterGetHunkSummary()
    let l:add = a == 0 ? '' : printf('+%d', a)
    let l:change = m == 0 ? '' : printf((empty(l:add) ?  '' : ' ') . '~%d', m)
    let l:delete = r == 0 ? '' : printf((empty(l:add) && empty(l:change) ? '' : ' ') . '-%d', r)
    return l:add . l:change . l:delete
endfunction

function! s:aleLinted() abort
    return get(g:, 'ale_enabled', 0) == 1
                \ && getbufvar(bufnr(''), 'ale_enabled', 1)
                \ && getbufvar(bufnr(''), 'ale_linted', 0) > 0
                \ && ale#engine#IsCheckingBuffer(bufnr('')) == 0
endfunction

function! Alestatus() abort
    if !s:aleLinted()
        return ''
    endif
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:infos = l:counts.info == 0 ? '' : printf("\uf129 %d", l:counts.info)
    let l:warn_cnt = l:counts.warning + l:counts.style_warning
    let l:warnings = l:warn_cnt == 0 ? '' : printf((empty(l:infos) ? '' : ' ') . "\uf071 %d", l:warn_cnt)
    let l:err_cnt = l:counts.error + l:counts.style_error
    let l:errors = l:err_cnt == 0 ? '' : printf((empty(l:infos) && empty(l:warnings) ? '' : ' ') . " \uf05e %d", l:err_cnt)
    return ale#engine#IsCheckingBuffer(bufnr('')) ? 'ALE Checking' : l:infos . l:warnings . l:errors
endfunction


"------------------------------------------------------------------------------"
"                                    airline                                   "
"------------------------------------------------------------------------------"
" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
" Show powerline symbols
let g:airline_powerline_fonts = 1
" airline theme
let g:airline_theme='onedark'

" Tab navigation
nnoremap <C-S-tab> :bprevious<CR>
nnoremap <C-tab> :bnext<CR>


"------------------------------------------------------------------------------"
"                                   nerdtree                                   "
"------------------------------------------------------------------------------"
" shortcut to open NERDTree
noremap <leader>nt :NERDTreeToggle<CR>

" Open NERDTree automatically when vim starts up on opening a directory
augroup nerdTreeDir
    au StdinReadPre * let s:std_in=1
    au VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
augroup END


"------------------------------------------------------------------------------"
"                                  nerdcomment                                 "
"------------------------------------------------------------------------------"
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1


"------------------------------------------------------------------------------"
"                                 vim-markdown                                 "
"------------------------------------------------------------------------------"
" disable the folding configuration
let g:vim_markdown_folding_disabled = 1
" enable conceal
let g:vim_markdown_conceal = 1
" Latex math syntax
let g:vim_markdown_math = 1
" Strikethrough uses two tildes
let g:vim_markdown_strikethrough = 1
" Enable TOC Autofit
let g:vim_markdown_toc_autofit = 1


"------------------------------------------------------------------------------"
"                                    onedark                                   "
"------------------------------------------------------------------------------"
" enable italics
let g:onedark_terminal_italics=1
colorscheme onedark


"------------------------------------------------------------------------------"
"                                   coc.nvim                                   "
"------------------------------------------------------------------------------"
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <slient> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor
augroup highlightSymbol
    au CursorHold * silent call CocActionAsync('highlight')
augroup END

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" codeAction to the selected region.
xmap <leader>cocca <Plug>(coc-codeaction-selected)
nmap <leader>cocca <Plug>(coc-codeaction-selected)

" codeAction
nmap <leader>cocca <Plug>(coc-codeaction)

" fixCurrent
nmap <leader>cfc <Plug>(coc-fix-current)

" <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" `:OR` for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')


"------------------------------------------------------------------------------"
"                                 coc-snippets                                 "
"------------------------------------------------------------------------------"
" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


"------------------------------------------------------------------------------"
"                              Semantic highlight                              "
"------------------------------------------------------------------------------"
nnoremap <leader>sh :SemanticHighlightToggle<CR>


"------------------------------------------------------------------------------"
"                                      ale                                     "
"------------------------------------------------------------------------------"
let g:ale_echo_msg_format = '%s --%linter%'
let g:ale_disable_lsp = 1
let g:ale_linters_ignore = {
            \'cpp': ['clangtidy']
            \}
let g:ale_sign_error = '--'
let g:ale_sign_warning = ' !'


"------------------------------------------------------------------------------"
"                                  vimspector                                  "
"------------------------------------------------------------------------------"
let g:vimspector_enable_mappings = 'HUMAN'


"------------------------------------------------------------------------------"
"                                   autopairs                                  "
"------------------------------------------------------------------------------"
" https://github.com/jiangmiao/auto-pairs/issues/204
augroup autoPairs
    au filetype vim let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '`':'`'}
    au filetype clojure,lisp let b:AutoPairs = {'"':'"', '(':')', '[':']',  '{':'}', '`':'`'}
augroup END


"------------------------------------------------------------------------------"
"                              rainbow parentheses                             "
"------------------------------------------------------------------------------"
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [238, 248, 59]

augroup rainbowActivate
    au BufEnter * :RainbowParentheses<CR>
augroup END


"------------------------------------------------------------------------------"
"                                 Comment Frame                                "
"------------------------------------------------------------------------------"
function! s:CommentFrame(left_border, right_border, line_width, topdown_fill, middle_fill, title)
    let except_left_right = a:line_width - len(a:left_border) - len(a:right_border)
    let middle_fill_len = except_left_right - len(a:title)
    let middle_fill_left = middle_fill_len / 2
    let middle_fill_right = middle_fill_len - middle_fill_left
    let middle_content = a:left_border . repeat(a:middle_fill, middle_fill_left) . a:title .
                \    repeat(a:middle_fill, middle_fill_right) . a:right_border

    let topdown_border = a:left_border . repeat(a:topdown_fill, except_left_right) . a:right_border

    call append(line('.'), l:topdown_border)
    call append(line('.'), l:middle_content)
    call append(line('.'), l:topdown_border)
endfunction

function! s:CommentFramePrompt()
    let str = input('[Comment Frame]: ')
    if str ==# ''
        return
    endif
    let left = b:NERDCommenterDelims['left']
    let right = b:NERDCommenterDelims['right'] ==# '' ? left : b:NERDCommenterDelims['right']
    call s:CommentFrame(left, right, 80, '-', ' ', str)
endfunction

nnoremap <leader>cfq :call <SID>CommentFramePrompt()<CR>


"------------------------------------------------------------------------------"
"                                  easy align                                  "
"------------------------------------------------------------------------------"
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


"------------------------------------------------------------------------------"
"                                  easymotion                                  "
"------------------------------------------------------------------------------"
map <leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

map s <Plug>(easymotion-overwin-f2)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)


"------------------------------------------------------------------------------"
"                                  gitgutter                                   "
"------------------------------------------------------------------------------"
let g:gitgutter_map_keys = 0
nnoremap <leader>gd :GitGutterPreviewHunk<CR>


"------------------------------------------------------------------------------"
"                                     suda                                     "
"------------------------------------------------------------------------------"
let g:suda#prompt = '[sudo] Password: '

" :W sudo saves the file
nnoremap <leader>W :SudaWrite<CR>
nnoremap <leader>sdr :SudaRead<CR>


"------------------------------------------------------------------------------"
"                                 indent line                                  "
"------------------------------------------------------------------------------"
let g:indentLine_char = '⎸'
" https://github.com/plasticboy/vim-markdown/issues/395
let g:indentLine_concealcursor = ''


"------------------------------------------------------------------------------"
"                                     REPL                                     "
"------------------------------------------------------------------------------"
nnoremap <leader>rp :Repl<CR>
nnoremap <leader>rps :ReplSend<CR>
vnoremap <leader>rps :ReplSend<CR>
nnoremap <leader>rpr :ReplRecv<CR>
nnoremap <leader>rpsp :ReplStop<CR>

