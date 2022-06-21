setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
setlocal textwidth=0
setlocal lisp

lua <<EOF
local ap = require("nvim-autopairs")
local rule = require("nvim-autopairs.rule")
ap.clear_rules()
EOF

