syntax on
set number
set hlsearch
set ignorecase

" 자동 들여쓰기 설정
set ai
set si
set cindent
set linebreak


" 마우스 커서이동
set mouse=a

" 수정된 위치에 커서
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" 상태바
set laststatus=2 " 상태바 표시를 항상한다
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\

" 인코딩 자동 설정
set fileencodings=utf-8,euc-kr

" 탭 사이즈 변경
set smartindent
set tabstop=4
set expandtab
set shiftwidth=4

"<F2> 키로 저장
nnoremap <F2> :w
