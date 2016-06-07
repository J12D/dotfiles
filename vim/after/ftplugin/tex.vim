let NERDTreeIgnore = ['\.aux', '\.fdb_latexmk', '\.fls', '\.log', '\.out', '\.synctex\.gz', '\.bbl', '\.bcf', '\.blg', '\.pdf', '\.run\.xml']

syntax spell toplevel

function! WC()
    let filename = expand("%")
    let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
    let result = system(cmd)
    echo result . " words"
endfunction

command! WC call WC()