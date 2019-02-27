" ------------------------------
" Name: vimrc for imqxms
" Author: im0qianqian
" ------------------------------

" Init {{{
" 判断当前环境是 Windows 还是 Linux
let g:isWindows = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:isWindows = 1
endif
" }}}

" Startup {{{
filetype indent plugin on

augroup vimrcEx
    au!

    autocmd FileType text setlocal textwidth=78

augroup END

" vim 文件折叠方式为 marker
augroup ft_vim
    au!

    autocmd FileType vim setlocal foldmethod=marker

    " 打开文件总是定位到上次编辑的位置
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

augroup END

" }}}

" General {{{
" 关闭与 vi 的兼容
set nocompatible
" 不创建备份文件
set nobackup
" 不生成临时交换文件
set noswapfile
" 设置自动加载已在外部更改的文件
set autoread
" 记录的历史命令最大条数
set history=1024
" 设置 vim 的当前目录为打开的文件所在目录
set autochdir
" 设置可以从行首或者行尾跳到另一行
set whichwrap=b,s,<,>,[,]
" 去除 UTF-8 编码的 BOM 标记
set nobomb
" indent: 如果用了 :set indent,:set ai 等自动缩进，想用退格键将字段缩进的删掉，必须设置这个选项。否则不响应。
" eol: 如果插入模式下在行开头，想通过退格键合并两行，需要设置 eol。
" start: 要想删除此次插入前的输入，需设置这个。
set backspace=indent,eol,start whichwrap+=<,>,[,]
" Vim 的默认寄存器和系统剪贴板共享
set clipboard+=unnamed
" 设置 alt 键不映射到菜单栏
set winaltkeys=no
" 启用鼠标
set mouse=a
if(g:isWindows)
    " 设置 python 路径 (Windows)
    set pythonthreehome=C:\Anaconda3
    set pythonthreedll=C:\Anaconda3\Python37.dll
else
    set pythonthreehome=/usr
endif
" }}}

" Lang & Encoding {{{
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set langmenu=zh_CN
let $LANG = 'en_US.UTF-8'
"language messages zh_CN.UTF-8
" }}}

" GUI {{{
" 设置主题
colorscheme Tomorrow-Night

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set cursorline
" 高亮查找
set hlsearch
" 即时显示查找结果
set incsearch
" 查找时忽略大小写
set ignorecase
" 打开行号显示
set number
" 窗口大小
" set lines=35 columns=140
" 分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright

" 不显示工具/菜单栏
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b
" 使用内置 tab 样式而不是 gui
set guioptions-=e
if (g:isWindows)
    set guifont=Consolas:h12:cANSI
else
    set guifont=Consolas\ 14
endif

set listchars=trail:·,extends:>,precedes:<
set statusline=%F
set statusline+=%M
set statusline+=%=
set statusline+=%{''.(&fenc!=''?&fenc:&enc).''}
set statusline+=/
set statusline +=%{&ff}            "file format
set statusline+=\ -\      " Separator
set statusline+=%l/%L
set statusline+=[%p%%]
set statusline+=\ -\      " Separator
set statusline+=%1*\ %y\ %*
" }}}

" Format {{{
set autoindent
set smartindent
" tab 大小
set tabstop=4
" 缩进大小
set shiftwidth=4
set softtabstop=4
" 使用空格代替 tab
set expandtab
" 设置代码折叠的方式
set foldmethod=indent
" 设置打开文件不折叠代码
set foldlevelstart=99
" 语法高亮
syntax on
" 设置不自动折行
set nowrap
" }}}

" Keymap {{{
let mapleader=","

" 刷新配置文件 [,+s]
nmap <leader>s :source $MYVIMRC<cr>
" 编辑配置文件 [,+e]
nmap <leader>e :e $MYVIMRC<cr>

nmap <leader>tn :tabnew<cr>
nmap <leader>tc :tabclose<cr>
nmap <leader>th :tabp<cr>
nmap <leader>tl :tabn<cr>

" 移动分割窗口
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" 正常模式下 alt+j,k,h,l 调整分割窗口大小
nnoremap <M-j> :resize +5<cr>
nnoremap <M-k> :resize -5<cr>
nnoremap <M-h> :vertical resize -5<cr>
nnoremap <M-l> :vertical resize +5<cr>

" 插入模式移动光标 alt + 方向键
" inoremap <M-j> <Down>
" inoremap <M-k> <Up>
" inoremap <M-h> <left>
" inoremap <M-l> <Right>

" IDE like delete
inoremap <C-BS> <Esc>bdei

" 选择该行
nnoremap vv ^vg_
" 转换当前行为大写
inoremap <C-u> <esc>mzgUiw`za
" 命令模式下的行首尾
cnoremap <C-a> <home>
cnoremap <C-e> <end>

" 显示行号改变
nnoremap <F2> :setlocal number!<cr>
" 对文本是否进行折行处理
nnoremap <leader>w :set wrap!<cr>

imap <C-v> "+gP
vmap <C-c> "+y
vnoremap <BS> d
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y
imap <C-V> "+gP
map <S-Insert> "+gP
cmap <C-V> <C-R>+
cmap <S-Insert> <C-R>+

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

" 打开当前目录 windows
nmap <silent> <leader>ex :!start explorer %:p:h<CR>

" 打开当前目录CMD
nmap <silent> <leader>cmd :!start cmd /k cd %:p:h<cr>

" 复制当前文件/路径到剪贴板
nmap ,fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nmap ,fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

" 设置切换Buffer快捷键"
nnoremap <C-left> :bn<CR>
nnoremap <C-right> :bp<CR>

" }}}

" Plugin {{{
filetype off
call plug#begin()
" ----- NerdTree ----- {{{
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

let NERDTreeIgnore=['.idea', '.vscode', '*.pyc']
let NERDTreeBookmarksSort = 1
let NERDTreeShowLineNumbers = 0
let NERDTreeShowBookmarks = 0
let g:NERDTreeWinPos = 'left'
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nmap <leader>n :NERDTreeToggle <cr>
" }}}
" ----- Multiple-cursors ----- {{{
" Plug 'terryma/vim-multiple-cursors'
" }}}
" ----- Airline ----- {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
set laststatus=2

if !exists('g:airline_symbols')
    "let g:airline_symbols = {}
endif
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols='fancy'

"let g:airline_symbols.branch = ''
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]
let g:airline#extensions#tabline#enabled = 1

" }}}
" ----- Nerdcommenter ----- {{{
Plug 'scrooloose/nerdcommenter'

" 在注释分隔符后加一个空格
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" 代码注释快捷键
nmap <C-x> <Leader>c<Space>
vmap <C-x> <Leader>c<Space>
" }}}
" ----- AutoFormat ---- {{{
Plug 'Chiel92/vim-autoformat'
if(g:isWindows)
    " 设置 clang-format 路径
    let g:formatterpath = ['C:\Users\qianqian\.vscode\extensions\ms-vscode.cpptools-0.21.0\LLVM\bin']
else
    let g:formatterpath = ['/home/qianqian/Documents/program/clang-format']
endif
" 自定义格式化参数
let g:formatdef_clangformat = '"clang-format -style=\"{BasedOnStyle: LLVM, IndentWidth: 4, Language: Cpp, AccessModifierOffset: -4, AlignEscapedNewlinesLeft: true, , BreakConstructorInitializersBeforeComma: true}\" -fallback-style=LLVM"'
" 设置支持的文件类型，c/cpp
let g:formatters_c = ['clangformat']
let g:formatters_cpp = ['clangformat']
" 代码格式化 [Shift+F]
noremap <S-F> :Autoformat<CR>
" }}}
" ---- YouCompleteMe ---- {{{
"  安装完自动执行 install.py ，按需加载 C/C++
Plug 'Valloric/YouCompleteMe' , { 'do': './install.py --clang-completer','for': ['c', 'cpp', 'python']}
" 停止提示是否载入本地ycm_extra_conf文件
let g:ycm_confirm_extra_conf = 0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax = 1
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files = 1
" 从第2个键入字符就开始罗列匹配项
" let g:ycm_min_num_of_chars_for_completion=2
" 在注释输入中也能补全
let g:ycm_complete_in_comments = 1
" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" 触发语法补全
let g:ycm_key_invoke_completion = '<C-z>'
" 设置额外的语义补全触发条件
let g:ycm_semantic_triggers = {'c, cpp, python, java, py ,cs': ['re!\w{2}']}
" 关闭函数原型预览功能
set completeopt=menu,menuone
let g:ycm_add_preview_to_completeopt = 0
" 屏蔽 YCM 诊断代码信息
let g:ycm_show_diagnostics_ui = 0
" 启用 YCM 白名单
let g:ycm_filetype_whitelist = {
            \ "c":1,
            \ "cpp":1,
            \ "java":1,
            \ "python":1,
            \ "cs" :1,
            \ "sh":1,
            \ "zsh":1,
            \ }
" Python 解释器路径
if (g:isWindows)
    let g:ycm_global_ycm_extra_conf="~/vimfiles/.ycm_extra_conf.py"
else
    let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"
endif
" }}}
" ---- AsyncRun ---- {{{
Plug 'skywind3000/asyncrun.vim'
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 指定默认 shell
if(g:isWindows)
    let g:asyncrun_shell = 'powershell'
    let g:asyncrun_shellflag = '-c'
else
    let g:asyncrun_shell = 'gnome-terminal'
endif
let g:asyncrun_mode=4
" 设置 打开/关闭 Quickfix 窗口
nnoremap <C-n> :call asyncrun#quickfix_toggle(6)<cr>
" 保存并编译运行 C++
nnoremap <silent> <C-b> :call ExecuteByIm0qianqian()<CR>
function! ExecuteByIm0qianqian()
    exec "w"
    if &filetype == 'c' || &filetype == 'cpp'
        AsyncRun -mode=4 g++ -std=c++14 -g -DLOCAL_IM0QIANQIAN -Wall -pipe -m64 $(VIM_FILEPATH) -o $(VIM_FILEDIR)/bin/Debug/$(VIM_FILENOEXT).exe && $(VIM_FILEDIR)/bin/Debug/$(VIM_FILENOEXT).exe
    elseif &filetype == 'python'
        AsyncRun -mode=4 python $(VIM_FILEPATH)
    endif
endfunction
" }}}
" ---- Vim C++ Syntax Highlighting ---- {{{
Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1
" }}}
" ---- UltiSnips --- {{{
Plug 'SirVer/ultisnips'
Plug 'im0qianqian/vim-snippets'
let g:UltiSnipsExpandTrigger="<M-j>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}

" ---- Vimcdoc --- {{{
Plug 'yianwillis/vimcdoc'
" }}}
filetype on
call plug#end()
" }}}

