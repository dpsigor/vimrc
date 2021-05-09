" set number relativenumber
set number
set visualbell

let &t_SI = "\<Esc>[6 q"
let &t_EI = "\<Esc>[2 q"

set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

" Para subir e descer linhas, nos três modos. Alt+J ou Alt+K
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

" NERDTree mapping e preventing other buffers replacing NERDTree in its window
nnoremap <C-b> :NERDTreeToggle<CR>
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
let NERDTreeWinPos = "left"

let g:NERDTreeIgnore = ['^node_modules$']

" NerdTree encontrar o current file
nnoremap <silent> <Leader>pv :NERDTreeFind<CR>
" Para ampliar o NerdTree (ou qualquer outro vertical split)
nnoremap <silent> <Leader>r+ :vertical resize +5<CR>
nnoremap <silent> <Leader>r- :vertical resize -5<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults
set splitbelow splitright

" NerdTreeGitStatus ---------------------------------------------------------------------------------------
let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0

" Usar variável para abrir este rc com facilidade
let $RC="$HOME/.vim_runtime/my_configs.vim"

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=UTF-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

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
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "
                              \<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" Navegação do código para as definições, referências e tipos.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" Mostrar documentação de uma função ou tipo etc
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

"" Remap <C-f> and <C-b> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
"  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>



"-----------------------haskell-language-server-----------------------------------------
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>




"-----------------------stylish-haskell-------------------------------------------------
" auto format no save está bugado
"autocmd BufWrite *.hs :Autoformat
" Don't automatically indent on save, since vim's autoindent for haskell is buggy
"autocmd FileType haskell let b:autoformat_autoindent=0


"-------------------haskell-vim (Syntax Highlighting and Identation)--------------------
syntax on
filetype plugin indent on
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
" let g:haskell_classic_highlighting = 1    " remover 'opinionated highlighting'


"---------------------------- Haskell ----------------------------
call plug#begin('~/.vim/plugged')
" permite lints e dá dicas no haskell:
Plug 'w0rp/ale'
" permite que toda sugestão do lint seja executada sem que você precise digitar manualmente
Plug 'mpickering/hlint-refactor-vim'
" permite alinhamentos comuns no haskell
Plug 'junegunn/vim-easy-align'
" esquema de cores e indentação
Plug 'raichoo/haskell-vim'
" utilizado para usar o haskel-language-server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-scripts/indentpython.vim'
"------------------ Go Lang --------------------------------------
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"------------------ Outros Plugs ---------------------------------
Plug 'scrooloose/nerdtree'
" Plug 'dyng/ctrlsf.vim'
" Color schemas
Plug 'sainnhe/sonokai'
Plug 'morhetz/gruvbox'
" Snippets
Plug 'SirVer/ultisnips'
" Icones para NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

" Obs: instalacao manual de git gutter em vim/pack/airblade/

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" TypeScript
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'leafgarland/typescript-vim'

call plug#end()

" Color schema config (sonokai)
" if has('termguicolors')
"   set termguicolors
" endif
" let g:sonokai_style = 'default'
" let g:sonokai_enable_italic = 0
" let g:sonokai_disable_italic_comment = 1
" let g:sonokai_transparent_background = 1
" let g:sonokai_menu_selection_background = 'green'

" colorscheme sonokai
" colorscheme archman
colorscheme gruvbox
" colorscheme wombat256grf

" Background transparente
hi Normal guibg=NONE ctermbg=NONE

" ALE lint
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'haskell': ['hlint'],
\   'python': ['autopep8'],
\}

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" Atalho será ga para gerar alinhamento
nmap ga <Plug>(EasyAlign)

" Tab as space, as it should
set tabstop =2
set softtabstop =2
set shiftwidth =2
set expandtab

" COC
let g:coc_disable_startup_warning = 1


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
nmap <leader>i :CocCommand tsserver.organizeImports<cr>

"-------------- Git Gutter --------------------------
let g:gitgutter_enabled = 1
set signcolumn=yes

"-------------- Comments ----------------------------
" Commenting blocks of code.
"augroup commenting_blocks_of_code
"  autocmd!
"  autocmd FileType c,cpp,java,scala,javascript,typescript,go let b:comment_leader = '// '
"augroup END
"noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
"noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" ------- Open FZF search in vim -------------------
autocmd VimEnter * map <C-f> <Esc><Esc>:GFiles!<CR>
autocmd VimEnter * inoremap <C-f> <Esc><Esc>:BLines!<CR>
autocmd VimEnter * map <C-g> <Esc><Esc>:BCommits!<CR>

" Navegar buffers
nmap <C-d> <Esc><Esc>:Buffers<CR>
nmap <C-s> <Esc><Esc>:Rg!<CR>

" ------------ Use tab to indent ----------
"  ---- Problema: <c-i> pára de funcionar
"nnoremap <Tab> >>_
"nnoremap <S-Tab> <<_
"inoremap <S-Tab> <C-D>
"autocmd VimEnter * vnoremap <Tab> >gv
"autocmd VimEnter * vnoremap <S-Tab> <gv

" ------ Substituir seleção pelo register padrão
vnoremap <leader>p "_dP

" Mostrar o higlight group da palavra no cursor
nmap <C-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" -------- Making Vim with Typescript faster -----
" set re=0
" set regexpengine=1
set synmaxcol=200
set redrawtime=10000
syntax sync fromstart
