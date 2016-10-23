" Plugin installation start {{{
    call plug#begin(expand('~/.vim/bundle/'))

    " General plugins; loaded for all files
    Plug 'Raimondi/delimitMate'
    Plug 'roman/golden-ratio'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'bitc/vim-bad-whitespace'
    Plug 'altercation/vim-colors-solarized'
    Plug 'kshenoy/vim-signature'
    Plug 'mhinz/vim-signify'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

    " Snippets plugins; also loaded for all files
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'dnivra/more-vim-snippets'

    " Syntax checking
    Plug 'scrooloose/syntastic', { 'for': ['c', 'cpp', 'haskell', 'python'] }

    " Commenting related
    Plug 'scrooloose/nerdcommenter', { 'for': ['c', 'cpp', 'haskell', 'python', 'tex'] }

    " Haskell plugins
    Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
    Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }
    Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
    Plug 'Twinside/vim-haskellFold', { 'for': 'haskell' }

    " HTML plugins
    Plug 'nathanaelkane/vim-indent-guides', { 'for': ['html', 'htmldjango'] }

    " Markdown plugins
    " TODO: Lazily load these and make them work for *.md files
    Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'

    " Python plugins
    Plug 'fisadev/vim-isort', { 'for': 'python' }
    Plug 'tmhedberg/SimpylFold', { 'for': 'python' }

    call plug#end()

" }}} Plugin installation end

" General configuration start {{{
" Override as needed later

    set fileformat=unix
    syntax on
    filetype on
    set ignorecase
    set number
    set smartcase
    set encoding=utf-8

    set spell spelllang=en_gb

    set hlsearch
    set backspace=eol,start,indent

    " Be iMproved
    if has('vim_starting')
        set nocompatible
    endif

    filetype indent on
    filetype plugin indent on

    " Align the new line indent with the previous line
    set autoindent

    " Convert tabs to spaces
    set expandtab

    " Operation >> indents 4 columns; << unindents 4 columns
    set shiftwidth=4

    " Insert/delete 4 spaces when hitting a TAB/BACKSPACE
    set softtabstop=4

    " A hard TAB displays as 4 columns
    set tabstop=4

    " Shortcut to toggle paste mode
    set pastetoggle=<F10>"

    " Enable incremental search
    set incsearch

    " Set leader key to ,
    let mapleader = ","

    " Shortcuts for easy navigation between windows
    nnoremap <A-Up>    :wincmd k <CR>
    nnoremap <A-Down>  :wincmd j <CR>
    nnoremap <A-Left>  :wincmd h <CR>
    nnoremap <A-Right> :wincmd l <CR>

    " Set default shell to Z shell
    set shell=/bin/zsh

    " Set default textwidth
    set textwidth=85

    let g:python_host_prog = '/usr/bin/python2'

" }}} General configuration end

" Plugin configuration start {{{

    " Syntastic configuration start {{{

        let g:syntastic_auto_loc_list=1
        let g:syntastic_check_on_open=1

        " Shortcut to recompile
        nnoremap <F5> :SyntasticCheck<CR>

        " Shortcut to disable errors pane
        nnoremap <F6> :SyntasticReset<CR>

    " }}} Syntastic configuration end

    " You Complete Me configuration start {{{

        let g:ycm_semantic_triggers =  {
          \   'c' : ['->', '.'],
          \   'cpp' : ['->', '.', '::'],
          \   'haskell, java, vim' : ['.'],
          \   'tex' : ['{']
          \ }

        " Close preview after completion is chosen
        let g:ycm_autoclose_preview_window_after_completion = 1

        " Don't ask for YCM configuration file load confirmation once
        let g:ycm_confirm_extra_conf = 0

        " Collect identifiers from strings and comments
        let g:ycm_collect_identifiers_from_comments_and_strings = 1

        " Show completion for comments
        let g:ycm_complete_in_comments = 1

        " Set location of configuration file
        let g:ycm_global_ycm_extra_conf = '$HOME/.ycm_extra_conf.py'

        " Unset blacklist
        let g:ycm_filetype_blacklist = {}

    " }}} You Complete Me configuration end

    " delimitMate configuration start {{{

        " Characters delimitMate will match
        let delimitMate_matchpairs = "(:),[:],{:},<:>"

    " }}}  delimitMate configuration end

    " nerdcommenter configuration start {{{

        " Insert space after comment symbol
        let NERDSpaceDelims = 1

    " }}} nerdcommenter configuration end

    " Solarized theme configuration start {{{

        syntax enable
        se t_Co=256
        let g:solarized_termcolors=256
        set background=dark
        :silent! colorscheme solarized

    " }}} Solarized theme configuration end

    " vim-indent-guides configuration start {{{

        " Start level for indent highlight
        let g:indent_guides_start_level = 2

        " Size of indent guide
        let g:indent_guides_guide_size = 1

        " Disable default colours
        let g:indent_guides_auto_colors = 0

        " Set indent highlight colours: even is RoyalBlue1, odd is Cyan1
        " See http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim for all 256 colours
        autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd  ctermbg=51
        autocmd VimEnter,ColorScheme * :hi IndentGuidesEven ctermbg=63

    " }}} vim-indent-guides configuration end

    " vim-signify configuration start {{{

        " Highlight the changed lines
        let g:signify_line_highlight = 1

    " }}} vim-signify configuration end

    " vim-airline configuration start {{{

        set noshowmode
        set laststatus=2
        let g:airline#extensions#tabline#enabled=1

    " }}}  vim-airline configuration end

    " UltiSnips configuration start {{{

        let g:UltiSnipsExpandTrigger="<c-j>"
        " Location where private snippets are stored
        let g:UltiSnipsSnippetsDir="~/.vim/bundle/my-vim-snippets/UltiSnips"
        let g:UltiSnipsEditSplit="horizontal"

    " }}} UltiSnips configuration end

" }}} Plugin configuration end

" FileType configuration start {{{

    " C configuration start {{{

        autocmd BufNewFile,BufRead *.h set ft=c

        " Enable folding
        autocmd FileType c setlocal foldmethod=syntax

        " Disable spell check
        autocmd FileType c setlocal nospell

    " }}} C configuration end

    " C++ configuration start {{{

        autocmd FileType cpp let b:delimitMate_matchpairs="(:),[:],{:}"

        " Enable folding
        autocmd FileType cpp setlocal foldmethod=syntax

        " Disable spell check
        autocmd FileType cpp setlocal nospell

    " }}} C++ configuration end

    " Python configuration start {{{

        autocmd FileType python setlocal linebreak smartindent

        " lines longer than 85 columns will be broken
        autocmd FileType python setlocal textwidth=85

        " round indent to multiple of 'shiftwidth'
        autocmd FileType python setlocal shiftround

        " Set syntastic checkers to be activated
        let g:syntastic_python_checkers = ['python', 'flake8']

        " Ignore compiled files
        set wildignore+=*.pyc,*.pyo
        set wildignore+=*.egg,*.egg-info

        " Disable spell check in python files
        autocmd FileType python setlocal spell spelllang = ""

        " Disable spell check
        autocmd FileType python setlocal nospell

        " Do not match < or > for Python files
        autocmd FileType python let b:delimitMate_matchpairs="(:),[:],{:}"

    " }}} Python configuration end

    " Django configuration start {{{

        " Set filetype for common Django files
        autocmd BufNewFile,BufRead admin.py setlocal filetype=python.django
        autocmd BufNewFile,BufRead forms.py setlocal filetype=python.django
        autocmd BufNewFile,BufRead local_settings.py setlocal filetype=python.django
        autocmd BufNewFile,BufRead models.py setlocal filetype=python.django
        autocmd BufNewFile,BufRead settings.py setlocal filetype=python.django
        autocmd BufNewFile,BufRead urls.py setlocal filetype=python.django
        autocmd BufNewFile,BufRead views.py setlocal filetype=python.django
        autocmd BufNewFile,BufRead helper.py setlocal filetype=python.django

        " Set filetype for rest_framework's files
        autocmd BufNewFile,BufRead serializers.py setlocal filetype=python.django
        autocmd BufNewFile,BufRead permissions.py setlocal filetype=python.django

        " Enable indent highlight at startup
        autocmd FileType htmldjango IndentGuidesEnable

        " Disable spell check
        autocmd FileType python.django setlocal nospell
        autocmd FileType htmldjango setlocal nospell

    " }}} Django configuration end

    " Sage configuration start {{{

        autocmd BufNewFile,BufRead *.sage,*.spyx,*.pyx setlocal filetype=python

        " Disable spell check
        autocmd FileType python setlocal nospell

    " }}} Sage configuration end

    " HTML configuration start {{{

        " Enable indent highlight at startup
        autocmd FileType html IndentGuidesEnable

        " Fold based on indentation
        autocmd FileType html setlocal foldmethod=indent

    " }}} HTML configuration end

    " jam configuration start {{{

        autocmd BufRead,BufNewFile Jamfile setlocal filetype=jamfile
        autocmd FileType jamfile set noexpandtab
        autocmd FileType jamfile set softtabstop=8
        autocmd FileType jamfile set tabstop=8

    " }}} jam configuration end

    " Haskell configuation start {{{

        " Characters delimitMate will match
        autocmd FileType haskell let delimitMate_matchpairs = "(:),[:],{:}"

        " Reset shiftwidth
        autocmd FileType haskell let shiftwidth=4
        autocmd FileType haskell set shiftround
        autocmd FileType haskell set tabstop=8

        " Set textwidth to 85
        autocmd FileType haskell setlocal textwidth=85

        " Disable spell check
        autocmd FileType haskell setlocal nospell

        " Set omnifunc for completion
        autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

        " hdevtools configuration
        autocmd FileType haskell nnoremap <buffer> <F7> :HdevtoolsType<CR>
        autocmd FileType haskell nnoremap <buffer> <silent> <F8> :HdevtoolsClear<CR>
        let g:syntastic_haskell_hdevtools_args = "-g -Wall"

    " }}} Haskell configuration end

    " Markdown configuation start {{{

        autocmd FileType markdown setlocal formatoptions-=l

    " }}} Markdown configuation end

    " TeX configuration start {{{

        autocmd BufNewFile,BufRead *.tex setlocal filetype=tex

        autocmd FileType tex setlocal shiftwidth=2
        autocmd FileType tex setlocal softtabstop=2
        autocmd FileType tex setlocal tabstop=2
        autocmd FileType tex setlocal textwidth=85

    " }}} TeX configuration end

    " vimrc configuration start {{{

        autocmd BufNewFile,BufRead *vimrc setlocal foldmarker={{{,}}}
        autocmd BufNewFile,BufRead *vimrc setlocal foldmethod=marker

    " }}} vimrc configuration end

" }}} FileType configuration end
