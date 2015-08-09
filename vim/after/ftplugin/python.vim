setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4

set colorcolumn=120

let NERDTreeIgnore = ['\.pyc']

let g:pymode = 1
let g:pymode_lint = 1

let g:pymode_lint_on_write = 1
let g:pymode_run_bind = '<leader>r'

"enable setting of breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

"maximum chars per line
let g:pymode_options_max_line_length = 99
let g:pymode_options_colorcolumn = 1

"quickfix window
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 6

let g:pymode_lint_options_pep8 = {'max_line_length': 99}
