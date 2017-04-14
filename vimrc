" vim: fdm=marker
scriptencoding utf-8
set encoding=utf-8
set nocompatible               " Be iMproved
set modeline
set modelines=3

set backupskip=/tmp/*,/private/tmp/*" 

" Bundles {{{
    call plug#begin('~/.vim/plugged')

    Plug 'Shougo/vimproc'
    Plug 'altercation/vim-colors-solarized'
    Plug 'tpope/vim-surround'
    Plug 'spf13/vim-autoclose'
    Plug 'kien/ctrlp.vim'
    Plug 'myusuf3/numbers.vim'
    Plug 'scrooloose/syntastic'
    Plug 'scrooloose/nerdcommenter'
    Plug 'godlygeek/tabular'
    Plug 'Shougo/neocomplete'
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'honza/vim-snippets'
    Plug 'elzr/vim-json'
    Plug 'pangloss/vim-javascript'
    Plug 'kchmck/vim-coffee-script'
    Plug 'airblade/vim-gitgutter'
    Plug 'LokiChaos/vim-tintin'
    Plug 'tpope/vim-projectionist'
    Plug 'mileszs/ack.vim'

    " HTML
    "Plug 'amirh/HTML-AutoCloseTag'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'tpope/vim-haml'
    Plug 'tpope/vim-unimpaired'
    Plug 'othree/xml.vim'
    "Plug 'mustache/vim-mustache-handlebars'

    " Ruby
    Plug 'vim-ruby/vim-ruby'
    Plug 'tpope/vim-rbenv'
    Plug 'tpope/vim-bundler'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rails'
    "let g:rubycomplete_buffer_loading = 1
    "let g:rubycomplete_classes_in_global = 1
    "let g:rubycomplete_rails = 1

    "Plug 'tpope/vim-cucumber'
    "Plug 'quentindecock/vim-cucumber-align-pipes'
    "Plug 'xolox/vim-misc'
    "Plug 'xolox/vim-notes'
    Plug 'mattn/emmet-vim'
    "Plug 'tpope/vim-abolish'
    "Plug 'vimwiki/vimwiki'
    "Plug 'danielmiessler/VimBlog'
    Plug 'actionshrimp/vim-xpath'

    "Plug 'PProvost/vim-ps1'
    Plug 'editorconfig/editorconfig-vim'
    call plug#end()
" }}}

"" General config {{{
  set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
  "set listchars=tab:›,trail:.,nbsp:~
  set list

  filetype plugin indent on
  filetype plugin on
  let mapleader = ','
  set expandtab
  set shiftwidth=2
  set softtabstop=2
  set nu
  syntax on
  set ignorecase smartcase
	let g:xml_syntax_folding = 1
  if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
    " Selected characters/lines in visual mode
  endif
  if has('statusline')
    set laststatus=2
    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
  endif

""}}}

"" Vim folders {{{
  let dir_list = {
              \ 'backup': 'backupdir',
              \ 'views': 'viewdir',
              \ 'swap': 'directory' }
      
  for [dirname, settingname] in items(dir_list)
      let directory = $HOME . '/.vim' . dirname . '/'
      if exists("*mkdir")
          if !isdirectory(directory)
              call mkdir(directory)
          endif
      endif
      if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
      else
          let directory = substitute(directory, " ", "\\\\ ", "g")
          exec "set " . settingname . "=" . directory
      endif
  endfor
""}}}

"" Key mappings {{{
  " Window movements"
  map <C-J> <C-W>j<C-W>_
  map <C-K> <C-W>k<C-W>_
  map <C-L> <C-W>l<C-W>_
  map <C-H> <C-W>h<C-W>_

  " Toggle search highlighting 
  nmap <silent> <leader>/ :set invhlsearch<CR>
  
  " Shortcuts
  " Change Working Directory to that of the current file
  cmap cwd lcd %:p:h
  cmap cd. lcd %:p:h

  " Visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv

  " Allow using the repeat operator with a visual selection (!)
  " http://stackoverflow.com/a/8064607/127816
  vnoremap . :normal .<CR>

  " Fix home and end keybindings for screen, particularly on mac
  " - for some reason this fixes the arrow keys too. huh.
  map [F $
  imap [F $
  map [H g0
  imap [H g0

  " For when you forget to sudo.. Really Write the file.
  cmap w!! w !sudo tee % >/dev/null

  " Some helpers to edit mode
  " http://vimcasts.org/e/14
  cnoremap %% <C-R>=expand('%:h').'/'<cr>
  map <leader>ew :e %%
  map <leader>es :sp %%
  map <leader>ev :vsp %%
  map <leader>et :tabe %%

  " Adjust viewports to the same size
  map <Leader>= <C-w>=

  " Map <Leader>ff to display all lines with keyword under cursor
  " and ask which one to jump to
  nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

  " Easier horizontal scrolling
  map zl zL
  map zh zH
  map <Leader>i mmgg=G`m<CR>
  map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
  nmap <F2> :NERDTreeToggle<cr>
  map <F5> :%!tidy -xml -q -utf8 -indent<cr>
  nnoremap <leader><leader> <C-^>
  " Insert a hash rocket with <c-l>
  imap <c-l> <space>=><space>
  " Can't be bothered to understand ESC vs <c-c> in insert mode
  imap <c-c> <esc>
  " Clear the search buffer when hitting return
  function! MapCR()
    nnoremap <Leader>h :nohlsearch<cr>
  endfunction
  call MapCR()
""}}}

"" Misc {{{
  if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  endif
  
  "Yank to end of line"
  nnoremap Y y$ 
""}}}

"" Formatting {{{
  set nowrap                      " Wrap long lines
  set autoindent                  " Indent at the same level of the previous line
  set shiftwidth=2                " Use indents of 4 spaces
  set expandtab                   " Tabs are spaces, not tabs
  set tabstop=2                   " An indentation every four columns
  set softtabstop=2               " Let backspace delete indent
  set backspace=2
  set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
  set splitright                  " Puts new vsplit windows to the right of the current
  set splitbelow                  " Puts new split windows to the bottom of the current
  "set matchpairs+=<:>             " Match, to be used with %
  set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
  set background=dark
  syntax enable
  colorscheme solarized
  set nospell
  set incsearch
  set hlsearch
  set cursorline

  set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline:h13

  set winwidth=84
  " We have to have a winheight bigger than we want to set winminheight. But if
  " we set winheight to be huge before winminheight, the winminheight set will
  " fail.
  set winheight=5
  set winminheight=5
  set winheight=999
  " "
  map <leader>gr :topleft :split config/routes.rb<cr>
  map <leader>gg :topleft 100 :split Gemfile<cr>
""}}}

"" Crap {{{

    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    "autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre * :%s/\s\+$//e
    "<buffer> call StripTrailingWhitespace()
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    "autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    "autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    "autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    "autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    "autocmd FileType haskell setlocal nospell

    " }
    
    " Code folding options {
    "
        "nmap <leader>f0 :set foldlevel=0<CR>
        "nmap <leader>f1 :set foldlevel=1<CR>
        "nmap <leader>f2 :set foldlevel=2<CR>
        "nmap <leader>f3 :set foldlevel=3<CR>
        "nmap <leader>f4 :set foldlevel=4<CR>
        "nmap <leader>f5 :set foldlevel=5<CR>
        "nmap <leader>f6 :set foldlevel=6<CR>
        "nmap <leader>f7 :set foldlevel=7<CR>
        "nmap <leader>f8 :set foldlevel=8<CR>
        "nmap <leader>f9 :set foldlevel=9<CR>
    " }

    " }"
""}}}

"" autocmds {{{



    augroup vimrcEx
        " Clear all autocmds in the group
        autocmd!
        autocmd FileType text setlocal textwidth=78
        " Jump to last cursor position unless it's invalid or in an
        " event handler
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif

        "for ruby, autoindent with two spaces, always expand tabs
        autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et fdm=syntax
        autocmd BufWritePost *.rb call system('ctags -R&')
        autocmd FileType python set sw=4 sts=4 et

        autocmd! BufRead,BufNewFile *.sass setfiletype sass 

        autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
        autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

        " Indent p tags
        " autocmd FileType html,eruby if
        " g:html_indent_tags !~ '\\|p\>' | let
        " g:html_indent_tags .= '\|p\|li\|dt\|dd' |
        " endif

        " Don't syntax highlight markdown because
        " it's often wrong
        autocmd! FileType mkd setlocal syn=off

        " Leave the return key alone when in
        " command line windows, since it's
        " used
        " to run commands there.
        autocmd! CmdwinEnter * :unmap <cr>
        autocmd! CmdwinLeave * :call
    augroup END
""}}}

"" Functions {{{

"" FocusOnFile {{{
  nnoremap <leader>s :call FocusOnFile()<cr>

  function! FocusOnFile()
    tabnew %
    normal! v
    normal! l
    call OpenTestAlternate()
    normal! h
  endfunction
""}}}

"" Rubocop {{{
  command! Rubocop call Rubocop()

  function! Rubocop()
    set makeprg=rubocop
    make
  endfunction
""}}}
    " Find merge conflict markers {{{
        map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
    " }}}"
    
" SWITCH BETWEEN TEST AND PRODUCTION CODE{{{
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction

nnoremap <leader>. :call OpenTestAlternate()<cr>
" }}}
"
" RUNNING TESTS {{{
"
  map <leader>t :call RunTestFile()<cr>
  map <leader>T :call RunNearestTest()<cr>
  map <leader>a :call RunTests('')<cr>
  map <leader>c :w\|:!script/features<cr>
  map <leader>w :w\|:!script/features --profile wip<cr>

  function! RunTestFile(...)
      if a:0
          let command_suffix = a:1
      else
          let command_suffix = ""
      endif

      " Run the tests for the previously-marked file.
      let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
      if in_test_file
          call SetTestFile()
      elseif !exists("t:grb_test_file")
          return
      end
      call RunTests(t:grb_test_file . command_suffix)
  endfunction

  function! RunNearestTest()
      let spec_line_number = line('.')
      call RunTestFile(":" . spec_line_number)
  endfunction

  function! SetTestFile()
      " Set the spec file that tests will be run for.
      let t:grb_test_file=@%
  endfunction

  function! RunTests(filename)
      " Write the file and run tests for the given filename
      if expand("%") != ""
        :w
      end
      if match(a:filename, '\.feature$') != -1
          exec ":!script/features " . a:filename
      else
          if filereadable("script/test")
              exec ":!script/test " . a:filename
          elseif filereadable("bin/spring")
              exec ":!spring rspec --color " . a:filename
          elseif filereadable("Gemfile")
              exec ":!bundle exec rspec --color " . a:filename
          else
              exec ":!rspec --color " . a:filename
          end
      end
  endfunction
" }}}

""}}}

"" Plugins config {{{

  " Misc {{{
    let g:NERDShutUp=1
    let b:match_ignorecase = 1
  " }}}

  "" NeoComplete {{{
    " Snippets "
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)"
          \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)"
          \: "\<TAB>"

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'
    let g:neosnippet#enable_snipmate_compatibility = 1
    
  ""}}}

  " Ctags {{{
    set tags=./tags;/,~/.vimtags

    " Make tags placed in .git/tags file available in all levels of a repository
    let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
    if gitroot != ''
      let &tags = &tags . ',' . gitroot . '/.git/tags'
    endif
  " }}}
  
  " AutoCloseTag {{{
      " Make it so AutoCloseTag works for xml and xhtml files as well
      au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
      nmap <Leader>ac <Plug>ToggleAutoCloseMappings
  " }}}
  
  " SnipMate {{{
      " Setting the author var
      " If forking, please overwrite in your .vimrc.local file
      let g:snips_author = 'Jelle Helsen <jelle@hcode.be>'
  " }}}

  " Tabularize {{{
      nmap <Leader>a& :Tabularize /&<CR>
      vmap <Leader>a& :Tabularize /&<CR>
      nmap <Leader>a= :Tabularize /=<CR>
      vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a: :Tabularize /:<CR>
      vmap <Leader>a: :Tabularize /:<CR>
      nmap <Leader>a:: :Tabularize /:\zs<CR>
      vmap <Leader>a:: :Tabularize /:\zs<CR>
      nmap <Leader>a, :Tabularize /,<CR>
      vmap <Leader>a, :Tabularize /,<CR>
      nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
      vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
  " }}}

  " JSON {{{
      nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
  " }}}

  " ctrlp {{{
      let g:ctrlp_working_path_mode = 'ra'
      nnoremap <silent> <D-t> :CtrlP<CR>
      nnoremap <silent> <D-r> :CtrlPMRU<CR>
      let g:ctrlp_custom_ignore = {
          \ 'dir':  '\.git$\|\.hg$\|\.svn$',
          \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

      " On Windows use "dir" as fallback command.
      if has('win32') || has('win64')
          let g:ctrlp_user_command = {
              \ 'types': {
                  \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                  \ 2: ['.hg', 'hg --cwd %s locate -I .'],
              \ },
              \ 'fallback': 'dir %s /-n /b /s /a-d'
          \ }
      else
          let g:ctrlp_user_command = {
              \ 'types': {
                  \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                  \ 2: ['.hg', 'hg --cwd %s locate -I .'],
              \ },
              \ 'fallback': 'find %s -type f'
          \ }
      endif
  "}}}


  " Fugitive {{{
      nnoremap <silent> <leader>gs :Gstatus<CR>
      nnoremap <silent> <leader>gd :Gdiff<CR>
      nnoremap <silent> <leader>gc :Gcommit<CR>
      nnoremap <silent> <leader>gb :Gblame<CR>
      nnoremap <silent> <leader>gl :Glog<CR>
      nnoremap <silent> <leader>gp :Git push<CR>
      nnoremap <silent> <leader>gr :Gread<CR>:GitGutter<CR>
      nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
      nnoremap <silent> <leader>ge :Gedit<CR>
      nnoremap <silent> <leader>gg :GitGutterToggle<CR>
      set diffopt=filler,vertical
  "}}}

  " vim-gitgutter {{{
      " https://github.com/airblade/vim-gitgutter/issues/106
      let g:gitgutter_realtime = 0
  " }}}
""}}}              

"""""""""""""""""""""""""""""""""""""""""""
" Misc
" """"""""""""""""""""""""""""""""""""""""

hi! IncSearch cterm=NONE,underline term=NONE,underline
hi! Search cterm=NONE,underline term=NONE,underline
set scrolloff=5
set sidescrolloff=5
set grepprg=ack

let g:notes_directories = ['~/Dropbox/Notes']
let g:vimwiki_list = [{'path': '~/Google\ Drive/wiki/'}]
