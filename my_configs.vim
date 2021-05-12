" set number relativenumber
set number
set visualbell

let &t_SI = "\<Esc>[6 q"
let &t_EI = "\<Esc>[2 q"

set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

" Para subir e descer linhas, nos três modos. C-seta
nmap <silent> <C-Down> :m .+1<CR>==
nmap <silent> <C-Up> :m .-2<CR>==
imap <silent> <C-Down> <Esc>:m .+1<CR>==gi
imap <silent> <C-Up> <Esc>:m .-2<CR>==gi
vmap <silent> <C-Down> :m '>+1<CR>gv=gv
vmap <silent> <C-Up> :m '<-2<CR>gv=gv

" Emojis

ab :checked: ✅
ab :warning: ⚠️
ab :pushpin: 📌
ab :bomb: 💣
ab :construction: 🚧
ab :point_right: 👉
ab :joia: 👍
ab :pray: 🙏
ab :brain: 🧠
ab :poo: 💩

" netrw
nnoremap <C-b> :Lexplore<CR>
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
let g:netrw_banner = 0

set splitbelow splitright

" Usar variável para abrir este rc com facilidade
let $RC="$HOME/.vim_runtime/my_configs.vim"

set encoding=UTF-8
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1 " Voltar para 2?

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

syntax on
filetype plugin indent on

"---------------------------- Plugins ----------------------------
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

"------------------ Go Lang --------------------------------------
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"------------------ Outros Plugs ---------------------------------
" Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
" Snippets
Plug 'SirVer/ultisnips'

" Obs: instalacao manual de git gutter em vim/pack/airblade/

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Language Server
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

"" TypeScript
Plug 'HerringtonDarkholme/yats.vim'
" ----------------- deoplete, para autocompletion -----------
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'

" ---------------- para netrw ------------------------------
Plug 'tpope/vim-vinegar'

endif

call plug#end()

let g:deoplete#enable_at_startup = 1

colorscheme gruvbox

" Background transparente
hi Normal guibg=NONE ctermbg=NONE

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Tab as space, as it should
set tabstop =2
set softtabstop =2
set shiftwidth =2
set expandtab

"----------------- Go Lang settings ---------------------
"“ Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Autocompletion
"au filetype go inoremap <buffer> . .<C-x><C-o>

"LSP que deve encontrar definitions
let g:go_def_mapping_enabled = 0
"Go Path
let g:go_bin_path = $HOME."/go/bin"
" Abrir def em nova tab
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

"-------------- Snippets -----------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"-------------- TypeScript --------------------------
nmap <silent> K <Plug>(lsp-hover)
nmap <silent> gr <plug>(lsp-references)
nmap <silent> gd <plug>(lsp-definition)
nmap <silent> [g <plug>(lsp-previous-diagnostic)
nmap <silent> ]g <plug>(lsp-next-diagnostic)
nnoremap <leader>a :LspCodeAction<CR>
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_settings_root_markers = [
\   '.git',
\   '.git/',
\ ]
let g:lsp_document_code_action_signs_enabled = 1

let g:lsp_use_lua = has('nvim-0.4.0') || (has('lua') && has('patch-8.2.0775'))

if (executable('typescript-language-server'))
  au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->['typescript-language-server --stdio']},
        \ 'allowlist': ['javascript', 'typescript'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"-------------- Git Gutter --------------------------
let g:gitgutter_enabled=1
let g:gitgutter_set_sign_backgrounds=1
set signcolumn=yes
nmap <Leader>hp <Plug>(GitGutterPreviewHunk)
nmap [h <plug>(GitGutterPrevHunk)
nmap ]h <plug>(GitGutterNextHunk)
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" ------- Open FZF search in vim -------------------
autocmd VimEnter * map <C-f> <Esc><Esc>:GFiles!<CR>
autocmd VimEnter * inoremap <C-f> <Esc><Esc>:BLines!<CR>
autocmd VimEnter * map <C-g> <Esc><Esc>:BCommits!<CR>

" Navegar buffers
nmap <C-d> <Esc><Esc>:Buffers<CR>
nmap <C-s> <Esc><Esc>:Rg!<CR>

" -------- Making Vim with Typescript faster -----
" set re=0
" set regexpengine=1
set synmaxcol=200
set redrawtime=10000
syntax sync fromstart

" Prettier
nnoremap <leader>p :Prettier<CR>
