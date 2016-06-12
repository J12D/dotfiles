let NERDTreeIgnore = ['\.aux', '\.fdb_latexmk', '\.fls', '\.log', '\.out', '\.synctex\.gz', '\.bbl', '\.bcf', '\.blg', '\.pdf', '\.run\.xml']

syntax spell toplevel

function! WC()
    let filename = expand("%")
    let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
    let result = system(cmd)
    echo result . " words"
endfunction

command! WC call WC()

imap <buffer> [[ \begin{
imap <buffer> ]] <Plug>LatexCloseCurEnv
nmap <leader>ce <Plug>LatexChangeEnv 
nmap <leader>li diwi\textit{<ESC>pi<Right>} 
nmap <leader>lb diwi\textbf{<ESC>pi<Right>} 
