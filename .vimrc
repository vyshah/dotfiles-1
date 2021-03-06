if $VIM_PATH != ""
	let $PATH=$VIM_PATH
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

"  Plugins {{{1
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'cespare/vim-toml'
Plug 'chrisbra/NrrwRgn'
Plug 'christoomey/vim-tmux-navigator'
Plug 'direnv/direnv.vim'
Plug 'davidhalter/jedi-vim', {'for': ['python', 'pyrex']}
Plug 'edkolev/tmuxline.vim'
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'hynek/vim-python-pep8-indent'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all --no-update-rc'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/molokai'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'machakann/vim-highlightedyank'
Plug 'mhinz/vim-grepper'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-markdown-subscope'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rhysd/git-messenger.vim'
Plug 'roxma/nvim-yarp'
Plug 'rust-lang/rust.vim'
Plug 'sickill/vim-pasta'
Plug 'SirVer/ultisnips'
Plug 'solarnz/thrift.vim', {'for': 'thrift'}
Plug 'tbabej/taskwiki', {'do': 'pip3 install --upgrade git+git://github.com/tbabej/tasklib@develop'}
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/visualrepeat'
Plug 'vimwiki/vimwiki'
Plug 'wellle/tmux-complete.vim'
Plug 'w0rp/ale'

call plug#end()

"  General {{{1
set nocompatible        " Don't need compatibility with vi.
set nobackup writebackup
                        " Don't backup edited files but temporarily backup
                        " before overwiting.
set backspace=indent,eol,start
set history=50          " History of : commands.
set ruler               " Show the cursor position.
set laststatus=2        " Always show status line.
set showcmd             " Display incomplete commands.
set hidden              " Allow buffers to be hidden without saving.
set relativenumber number
                        " Show the line number of the current line and
                        " relative numbers of all other lines.
set noexpandtab softtabstop=0 shiftwidth=8 tabstop=8
                        " Use 8 tabs for indentation.
set copyindent preserveindent
                        " Preserve existing indentation as much as possible.
set incsearch
set autoindent
set nowrap              " No wrapping
set nojoinspaces        " Don't add two spaces after punctuation when joining
                        " two lines.
set ignorecase smartcase tagcase=followscs
                        " Ignore casing during search except if uppercase
                        " characters are used. Use the same settings for tag
                        " searches.
set shortmess+=c
set inccommand=split    " Show :s result incrementally.
set background=dark
set textwidth=78
set lazyredraw          " Don't redraw the screen while executing macros.
                        " Useful if the macros does a lot of transformation.
set virtualedit=all
set visualbell          " No beeping.
set splitbelow splitright
                        " Split below or to the right of the current window.
set foldmethod=marker
set hlsearch            " Highlight search results.
set wildmenu            " Show options for :-command completion.
set mouse=a             " Support mouse everywhere.
set scrolloff=10        " Lines to leave below cursor when scrolling.
set list listchars=tab:»\ ,trail:·
                        " Show tabs and trailing whitespace.
set wildignore+=*/cabal-dev,*/dist,*.o,*.class,*.pyc,*.hi
                        " Ignore in wildcard expansions.

" Use true color if not on Terminal.app
if $TERM_PROGRAM != "Apple_Terminal"
	set termguicolors
endif

colorscheme molokai

" Use terminal background for performance.
highlight Normal ctermbg=NONE guibg=NONE

" Make line numbers in terminal more readable
highlight LineNr ctermfg=245

" Invisible vertical split
highlight VertSplit guibg=bg guifg=bg

" Use global python. Ensures nvim works with Python plugins inside a virtualenv.
let g:python_host_prog = '/usr/local/bin/python'

" Space = leader
let mapleader = "\<Space>"

" Configuration available on OSX only:
if has("unix")
	let s:uname = system("uname")
	if s:uname == "Darwin"
		set macmeta        " Use Option key as Meta
		set fuopt=maxvert  " Don't change width in OSX full screen mode
	endif
endif

" If using gnome-terminal, use 256 colors.
if $COLORTERM == 'gnome-terminal'
	set t_Co=256
endif

" Easier tabbing
nmap <silent> <C-M-T> :tabe<CR>
nmap <silent> <C-M-H> :tabp<CR>
nmap <silent> <C-M-L> :tabn<CR>

" Disable ex mode from Q
nnoremap Q <Nop>

" Clear highlights on enter
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Yank and paste operations preceded by <leader> should use system clipboard.
nnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
vnoremap <leader>y "+y

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Ctrl-P in insert mode will paste while preserving indentation.
inoremap <C-P> <C-R><C-P>"

" Neovim specific configs.
if has('nvim')
	" Split navigation inside nvim's terminal emulator.
	tnoremap <C-M-J> <C-\><C-n><C-W><C-J>
	tnoremap <C-M-K> <C-\><C-n><C-W><C-K>
	tnoremap <C-M-L> <C-\><C-n><C-W><C-L>
	tnoremap <C-M-H> <C-\><C-n><C-W><C-H>
endif

" Edit the local vimrc
nnoremap <silent> <leader>evf :tabe $MYVIMRC<cr>
nnoremap <silent> <leader>svf :source $MYVIMRC<cr>

" Buffer shortcuts
nmap <silent> <leader>q :bd<CR>
nmap <silent> <leader>Q :bd!<CR>
nmap <silent> <leader>bn :bn<CR>
nmap <silent> <leader>bN :bN<CR>

" Don't show line numbers in terminal.
autocmd TermOpen * setlocal nonu nornu

" Auto-reload files {{{2

" Trigger :checktime when changing buffers or coming back to vim.
augroup AutoReload
	autocmd!
	autocmd FocusGained,BufEnter * :checktime
augroup end

"  Plugin {{{1

" airline {{{2
let g:airline_theme = "molokai"
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#ale#enabled = 1

" We want to do this manually with,
"   :Tmuxline airline | TmuxlineSnapshot ~/.tmux-molokai.conf
let g:airline#extensions#tmuxline#enabled = 0

" ale {{{2
let g:ale_open_list = 1
let g:ale_sign_error='⊘'
let g:ale_sign_warning='⚠'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_emit_conflict_warnings = 0
let g:ale_linters = {}
let g:ale_linter_aliases = {}

nmap <silent> <leader>ep <Plug>(ale_previous_wrap)
nmap <silent> <leader>en <Plug>(ale_next_wrap)

" ncm2 {{{2
autocmd BufEnter * call ncm2#enable_for_buffer()

set completeopt=noinsert,menuone,noselect,preview

inoremap <silent> <C-Space> <c-r>=ncm2#force_trigger()<cr>

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When <CR> is pressed while the popup menu is visible, it only
" hides the menu. This hides the menu and moves on to the next line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> <SID>HandleTab()
inoremap <expr> <S-Tab> (pumvisible() ? "\<C-p>" : "\<S-Tab>")

function s:HandleTab()
	" Select the first item if popup is open but nothing has been
	" selected. Otherwise, expand the selected item.
	if pumvisible()
		if empty(v:completed_item)
			return "\<c-n>"
		else
			return ncm2_ultisnips#expand_or("", 'n')
		endif
	endif

	return "\<tab>"
endfunction

" UltiSnips {{{3
imap <c-u> <Plug>(ultisnips_expand)
let g:UltiSnipsExpandTrigger            = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger       = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger      = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" easy-align {{{2
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" fzf {{{2
let g:fzf_layout = { 'down': '~15%' }

nmap <silent> <C-P> :Files<CR>
nmap <silent> <leader>tt :Trees<CR>
nmap <silent> <leader>r :History<CR>
nmap <silent> <leader>bb :Buffers<CR>
nmap <silent> <leader>: :Commands<CR>

" :Trees support {{{3

" FZFDirs runs FZF, displaying only directories.
function! s:FZFDirs(opts) " {{{4
	let cmd = 'find -L .
		\ \( -path ''*/\.*'' -o -fstype dev -o -fstype proc \) -prune
		\ -o -type d -print | sed 1d | cut -b3-'
	call fzf#run(extend({'source': cmd}, a:opts))
endfunction

" Fuzzy find a directory and open a directory.
command! Trees call s:FZFDirs({'sink': 'edit'})

" grepper {{{2
let g:grepper =
	\ {
	\ 'tools': ['rg', 'ag', 'git'],
	\ 'side': 1,
	\ 'side_cmd': 'new',
	\ 'prompt_text': '$t> ',
	\ 'prompt_quote': 2,
	\ 'quickfix': 1,
	\ 'switch': 1,
	\ 'jump': 0,
	\ 'dir': 'filecwd',
	\ }

if executable('rg')
	nnoremap <leader>gg :Grepper -tool rg<cr>
else
	nnoremap <leader>gg :Grepper -tool ag<cr>
endif

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" LanguageClient {{{2
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_rootMarkers = {}
let g:LanguageClient_autoStart = 1

" Don't spam language server. Wait a second before sending updates.
let g:LanguageClient_changeThrottle = 1

" Don't show signs in the gutter since the inline diagnostics are loud enough.
let g:LanguageClient_diagnosticsSignsMax = 0

augroup LanguageClientHooks
	autocmd!
	autocmd FileType * call s:SetupLanguageClient()
augroup END

function! s:SetupLanguageClient() " {{{3
	if !has_key(g:LanguageClient_serverCommands, &filetype)
		return
	endif

	" Keybindings
	"  K            Documentation
	"  <leader>d    Go to definition
	"  F2           Rename
	"  F5           Context menu

	nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
	nnoremap <buffer> <silent> <leader>d :call LanguageClient#textDocument_definition()<CR>
	nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
	nnoremap <buffer> <silent> <C-Space> :call LanguageClient_contextMenu()<CR>
endfunction

" vim-multiple-cursors {{{2

" Ctrl-p conflicts with file search. Use different mapping.
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-m>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" neosnippets {{{2
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = "~/.config/nvim/plugged/vim-snippets/snippets"

" netrw {{{2
let g:netrw_liststyle = 3

" sneak {{{2
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" taskwiki {{{2
let g:taskwiki_markup_syntax = "markdown"
let g:taskwiki_disable_concealcursor = 1

" tmux-navigator {{{2

" We have our own mappings
let g:tmux_navigator_no_mappings = 1

" Better split navigation
nnoremap <silent> <C-J> :TmuxNavigateDown<CR>
nnoremap <silent> <C-K> :TmuxNavigateUp<CR>
nnoremap <silent> <C-L> :TmuxNavigateRight<CR>
nnoremap <silent> <C-H> :TmuxNavigateLeft<CR>

"  File Types {{{1

" go {{{2

" vim-go {{{3
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_term_enabled = 1
let g:go_gopls_complete_unimported = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_snippet_engine = "neosnippet"
let g:go_template_file = $HOME . "/.config/vim-go/main.go"

if $VIM_GO_BIN_PATH != ""
	let g:go_bin_path = $VIM_GO_BIN_PATH
endif

" LanguageClient {{{3
let g:LanguageClient_serverCommands.go = ['gopls']
let g:LanguageClient_rootMarkers.go = ['go.mod', 'Gopkg.toml', 'glide.lock']

" ale {{{3
let g:ale_linters.go = ['go vet', 'golint']

" haskell {[{2

" LanguageClient {{{3
let g:ale_linters.haskell = ['hie', 'stylish-haskell', 'hlint']
let g:ale_haskell_hie_executable = 'hie-wrapper'
let g:LanguageClient_serverCommands.haskell = ['hie-wrapper']
let g:LanguageClient_rootMarkers.haskell = ['*.cabal', 'stack.yaml']

" python {{{2

" jedi-vim {{{3
let g:jedi#show_call_signatures = 0
let g:jedi#use_tabs_not_buffers = 1

" rust {{{2
let g:rustfmt_autosave = 1

" LanguageClient {{{3
if executable('rust-analyzer')
	let g:LanguageClient_serverCommands.rust = ['rust-analyzer']
else
	let g:LanguageClient_serverCommands.rust = ['rustup', 'run', 'stable', 'rls']
endif

" vimwiki {{{2

function! s:buildWiki(path)
	return {
		\ 'syntax': 'markdown',
		\ 'ext': '.md',
		\ 'auto_toc': 1,
		\ 'list_margin': 0,
		\ 'path': a:path,
		\ }
endfunction

" Use ~/.notes as the wiki location by default. Support overriding by setting
" VIMWIKI_PATH.
let g:vimwiki_list = [s:buildWiki('~/.notes')]
let g:vimwiki_list[0].index = '000000000001 Home'

if $VIMWIKI_PATH != ""
	call insert(g:vimwiki_list, s:buildWiki($VIMWIKI_PATH))
endif

let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_autowriteall = 1
let g:vimwiki_auto_chdir = 1
let g:vimwiki_folding = 'expr'
let g:vimwiki_use_mouse = 1

" ale {{{3
let g:ale_linter_aliases.vimwiki = ['markdown']
