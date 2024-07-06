"インデント関係
set expandtab			"空白をタブとして認識しないようにする
set tabstop=4			"一個のタブを空白何個分にとるか
set softtabstop=4		"tabを押した時に空白何個分のインデントをとるか
set autoindent			"改行したりしたときにインデントを保持する
set shiftwidth=4		"vimのインデントでいくつ空白を挿入するか
set smartindent         "インデントはスマートインデント
set list listchars=tab:\▸\- "不可視文字を可視化（タブが設定のように表示される）

"検索関係
set incsearch           "文字検索時にリアルタイムで検索する
set smartcase           "大文字小文字を区別せずに検索する
set hlsearch            "検索した文字がハイライトされる
set tags=.tags;~		"ctagsを遡って検索
set wrapscan            "検索時に最後まで行ったら最初に戻る
nmap <Esc><Esc> :nohlsearch<CR><Esc>    "ESC連打でハイライト解除

"表示関係
let &colorcolumn=80     "80列目に線を入れる
set title               "タイトルにパスを表示する
set number              "行頭に数字を表示する
" set relativenumber	"番号を相対表示にする
set showcmd             "入力中のコマンドを表示する
set showmatch           "括弧入力時の対応する括弧を表示
set cursorcolumn        "今いる列をハイライト
set cursorline			"今いる行をハイライト
set nowrap			    "折り返しをしない
set scrolloff=8			"スクロール時に余白をとるようにする
syntax enable           "ハイライトをオンにする
colorscheme evening     "デフォルトのカラースキームを設定する
"let g:markdown_fenced_languages = ['html', 'python', 'bash=sh'] "markdown記法でsyntax highlight
set conceallevel=2      "concealを行う（Markdownのため）
set fenc=utf-8          "文字コードをUTF-8に設定

"操作関係
set mouse=a			    "マウスでカーソルの位置を指定できる
set whichwrap=b,s,<,>,[,]	"行末、行頭で行を跨ぐことができる
set splitbelow			"splitすると下に分かれる
set splitright			"splitすると右に分かれる
set wildmode=list:longest   "コマンドラインの補完
set virtualedit=onemore "行末の一行先までカーソルを移動できるように

"その他
set autoread			"編集中に別のところで編集されたら自動で読み込む
set backspace=indent,eol,start
set hidden		        "保存しなくてもバッファの切り替えができる
set noswapfile			"swapファイルは使用しない
set nobackup            "バックアップファイルを作らない
set wildmenu wildmode=longest,full	"補完の形を決める(vim互換性)
set vb t_vb=            "ベルをオフにする
filetype plugin indent on   "vimtexに必要らしい
set encoding=utf-8      "utf-8での出力を可能にする(vimtex)


"プラグイン
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_node_path = '/c/Program Files/nodejs/node'

Plug 'vim-airline/vim-airline'
let g:airline#extension#tabline#enabled = 1

"Plug 'skanehira/preview-markdown.vim'
"let g:preview_markdown_parser = glow

Plug 'godlygeek/tabular'    "must come before vim-markdown
Plug 'preservim/vim-markdown'
"let g:vim_markdown_conceal = 0 "concealレベルに応じずconcealをオフにする
"let g:tex_conceal = ""         "LaTeX mathのconcealをオフにする
"let g:vim_markdown_math = 1    "LaTeX mathのsyntaxをオンにする
let g:vim_markdown_strikethrough = 1    "取り消し線をオンにする(~~ ~~で表す)
"let g:vim_markdown_new_list_item_indent "新しい箇条書きにインデントをつける

Plug 'lervag/vimtex'        "VimTex
let g:vimtex_compiler_latexmk_engines = { '_' : '-pdf' } "ないと更新時に環境が壊れるらしい
"let g:vimtex_fold_enabled      "vimtexのfoldingをオンにする
"let g:vimtex_format_enabled    "vimtexのformatをオンにする

Plug 'luochen1990/rainbow'  "かっこをカラフルにしてくれる
let g:rainbow_active = 1    "set to 0 if you want to eneble it later via :RainbowToggle
call plug#end()

"functions
function! AddIndentWhenEnter()  "中かっこを展開したときにインデントを付け足す
    if getline(".")[col(".")-1] == "}" && getline(".")[col(".")-2] == "{"
        return "\n\t\n\<UP>\<END>"
    else
        return "\n"
    endif
endfunction

"keymap
inoremap <silent> <expr> <CR> AddIndentWhenEnter()
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
"inoremap < <><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap ` ``<LEFT>
