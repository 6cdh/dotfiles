call plug#begin('~/.vim/plugged')


" ====================================
" [Alignment]
" ====================================
" Plug 'junegunn/vim-easy-align'


" ====================================
" [Code completion]
" ====================================
" Plug 'valloric/youcompleteme'


" ====================================
" [Tree Explorer]
" ====================================
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'


" ====================================
" [Start screen]
" ====================================
Plug 'mhinz/vim-startify'


" ====================================
" [Display Tags]
" ====================================
" Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }


" ====================================
" [Status bar]
" ====================================
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'


" ====================================
" [Git Integration]
" ====================================
Plug 'tpope/vim-fugitive'


" ====================================
" [quoting, parenthesizing made simple]
" ====================================
Plug 'tpope/vim-surround'
Plug 'junegunn/rainbow_parentheses.vim'

" ====================================
" [Format]
" ====================================
Plug 'chiel92/vim-autoformat'
" Plug 'sbdchd/neoformat'


" ====================================
" [Web]
" ====================================
" Emmet
" Plug 'mattn/emmet-vim'

" Vue
" Plug 'posva/vim-vue'


" ====================================
" [Comment Plugin]
" ====================================
Plug 'preservim/nerdcommenter'


" ====================================
" [Languages]
" ====================================
" Syntax check
" Plug 'scrooloose/syntastic'

" Syntax highlight
Plug 'sheerun/vim-polyglot', {'tag': '*'}
" Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'jaxbot/semantic-highlight.vim', {'on': 'SemanticHighlightToggle'}

" Golang
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }

" Tex
" Plug 'lervag/vimtex', {'for': 'tex'}
" Plug 'joom/latex-unicoder.vim'

" Markdown
Plug 'godlygeek/tabular', {'for': 'markdown'} " Required by plasticboy/vim-markdown
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}


" ====================================
" [Snippets]
" ====================================
" Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'


" ====================================
" [Solve Tab conflict]
" ====================================
" Plug 'ervandew/supertab'


" ====================================
" [Intellisense engine, LSP support]
" ====================================
Plug 'dense-analysis/ale', {'tag': '*'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}


" ====================================
" [Themes]
" ====================================
Plug 'joshdick/onedark.vim'

" ====================================
" [Auto pair parentheses, brackets and quotes...]
" ====================================
Plug 'jiangmiao/auto-pairs'
" Plug 'tmsvg/pear-tree'


" ====================================
" [Zenroom]
" ====================================
" Plug 'amix/vim-zenroom2'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}


" ====================================
" [Add Icons to Plugins, such as airline, nerdtree...]
" ====================================
Plug 'ryanoasis/vim-devicons'


" ====================================
" [Search]
" ====================================
Plug 'junegunn/fzf', {'tag': '*'}


" ====================================
" [Debug]
" ====================================
Plug 'puremourning/vimspector', {'tag': '*'}


" ====================================
" [Leetcode]
" ====================================
" Plug 'ianding1/leetcode.vim'


" ====================================
" [tiddlywiki]
" ====================================
" Plug 'sukima/vim-tiddlywiki'


call plug#end()

" ====================================
" [General]
" ====================================

set nocompatible    " no compatible vi
set number          " Show line numbers
set linebreak       " Break lines at word (requires Wrap lines)
" set showbreak=+++ " Wrap-broken line prefix
set textwidth=120   " Line wrap (number of cols)
set showmatch       " Highlight matching brace
"set spell          " Enable spell-checking
"set visualbel      " Use visual bell (no beeping)

set hlsearch        " Highlight all search results
set smartcase       " Enable smart-case search
set ignorecase      " Always case-insensitive
set incsearch       " Searches for strings incrementally

set expandtab       " expand tab to space
set shiftwidth=4    " Number of auto-indent spaces
set smartindent     " Enable smart-indent
" set smarttab      " Enable smart-tabs
set softtabstop=4   " Number of spaces per Tab

" Advanced
set ruler                       " Show row and column ruler information

set undolevels=1000             " Number of undo levels

" set backspace=eol,start,indent  " Configure backspace so it acts as it should act
" set whichwrap+=<,>,h,l
set showcmd
" enable filetype plugins
filetype plugin on
filetype indent on
" Auto read when a file is changed from the outside
set autoread
" autocmd
au FocusGained,BufEnter * checktime
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
set termguicolors
set nobackup
set nowritebackup
set noswapfile
set noshowmode

set hidden
set updatetime=300

" ========================================================================
" [nvim]
" ========================================================================
if has('nvim')
    let g:python3_host_prog='/bin/python3'
endif


" ========================================================================
" [set filetype for certain suffix]
" ========================================================================
augroup set_filetype
    au!
    au BufNewFile,BufRead *.cls set filetype=tex
augroup END


" ========================================================================
" [Keybinding]
" ========================================================================
" set mapleader
let g:mapleader=','
" Fast saving
nnoremap <leader>w :w<CR>
" fast quit
nnoremap <leader>q :q<CR>
" :W sudo saves the file
nnoremap <leader>W :w !sudo tee %<CR>
" move between windows
noremap <C-j> <C-W>j
noremap <C-h> <C-W>h
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l



" ========================================================================
" [SuperTab]
" ========================================================================
" <tab> navigate the completion menu from top to bottom rather bottom to top
" let g:SuperTabDefaultCompletionType = '<c-n>'



" ========================================================================
" [neoformat]
" ========================================================================
" shortcut
" noremap <leader>f :Neoformat<CR>
" format on save
" augroup fmt
"     autocmd!
"     autocmd BufWritePre * undojoin | Neoformat
" augroup END
" Enable alignment
" let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
" let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
" let g:neoformat_basic_format_trim = 1
" python format
" let g:neoformat_python_yapf = {}
" let g:neoformat_enabled_python = ['yapf', 'autopep8']
" shell format
" let g:shfmt_opt="-ci"


" ========================================================================
" [autoformat]
" ========================================================================
" shortcut
noremap <leader>f :Autoformat<CR>
" format upon saving file
" au BufWrite * :Autoformat
" markdown
let g:formatdef_formd = '"prettier --stdin-filepath ".expand("%:p")'
let g:formatters_markdown = ['formd']
" python
" let g:formatter_yapf_style = 'google'
let g:formatters_python = ['black']

let g:formatdef_tomlfmt = '"toml-fmt"'
let g:formatters_toml = ['tomlfmt']

" let g:autoformat_verbosemode = 1

" latex
let g:formatdef_latexindent = '"latexindent"'
let g:formatters_tex = ['latexindent']


" ========================================================================
" [Ultisnips]
" ========================================================================
" let g:UltiSnipsExpandTrigger='<c-a>'
" let g:UtliSnipsJumpForwardTrigger='<tab>'
" let g:UtliSnipsJumpBackwardTrigger='<s-tab>'


" ========================================================================
" [lightline]
" ========================================================================
" function! CocCurrentFunction()
"     return get(b:, 'coc_current_function', '')
" endfunction
"
" let g:lightline = {
"             \ 'colorscheme': 'onedark',
"             \ 'active': {
"             \   'left': [ [ 'mode', 'paste' ],
"             \             [ 'cocstatus', 'currentfunction', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"             \ },
"             \ 'component_function': {
"             \   'gitbranch': 'fugitive#head',
"             \   'cocstatus': 'coc#status',
"             \   'currentfunction': 'CocCurrentFunction'
"             \ },
"             \ }
"


" ========================================================================
" [airline]
" ========================================================================
" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
" Show powerline symbols
let g:airline_powerline_fonts = 1
" airline theme
let g:airline_theme='onedark'



" ========================================================================
" [NERDTree]
" ========================================================================
" shortcut to open NERDTree
noremap <leader>nt :NERDTreeToggle<CR>

" Open NERDTree automatically when vim starts up on opening a directory
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif


" ========================================================================
" [NERDComment]
" ========================================================================
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


" ========================================================================
" [YCM]
" ========================================================================
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'
"
" let g:clang_format#style_options = {
"             \ 'AccessModifierOffset' : -4,
"             \ 'AllowShortIfStatementsOnASingleLine' : 'true',
"             \ 'AlwaysBreakTemplateDeclarations' : 'true',
"             \ 'Standard' : 'C++17'}
" let g:clang_format#auto_format=1
" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'


" ========================================================================
" [vim-markdown]
" ========================================================================
" disable the folding configuration
let g:vim_markdown_folding_disabled = 1
" disable conceal
let g:vim_markdown_conceal = 0
" Latex math syntax
let g:vim_markdown_math = 1
" Strikethrough uses two tildes
let g:vim_markdown_strikethrough = 1


" ========================================================================
" [onedark]
" ========================================================================
" enable italics
let g:onedark_terminal_italics=1
colorscheme onedark
" transparent background
highlight Normal guibg=NONE


" ========================================================================
" [Markdown preview]
" ========================================================================


" ========================================================================
" [Coc.nvim]
" ========================================================================
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <slient> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor
au CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>cocrn <Plug>(coc-rename)

" codeAction to the selected region.
xmap <leader>cocca <Plug>(coc-codeaction-selected)
nmap <leader>cocca <Plug>(coc-codeaction-selected)

" codeAction
nmap <leader>cocca <Plug>(coc-codeaction)

" fixCurrent
nmap <leader>cocfc <Plug>(coc-fix-current)

" Introduce function text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" `:OR` for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" ========== coc-snippets ==========
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
" ========== coc-snippets ==========


" ========================================================================
" [coc.nvim extensions]
" ========================================================================
let g:coc_global_extensions = ['coc-word',
            \'coc-snippets',
            \'coc-marketplace',
            \'coc-clangd',
            \'coc-texlab',
            \'coc-python',
            \'coc-json',
            \]


" ========================================================================
" [Semantic highlight]
" ========================================================================
:nnoremap <leader>sh :SemanticHighlightToggle<cr>


" ========================================================================
" [ALE]
" ========================================================================
let g:ale_echo_msg_format = '%s --%linter%'
let g:ale_disable_lsp = 1
let g:ale_linters_ignore = {'cpp': ['clangtidy']}


" ========================================================================
" [vimspector]
" ========================================================================
let g:vimspector_enable_mappings = 'HUMAN'


" ========================================================================
" [Rainbow parentheses]
" ========================================================================
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [238, 248, 59]

augroup rainbow_activate
    au BufEnter * :RainbowParentheses<CR>
augroup END

