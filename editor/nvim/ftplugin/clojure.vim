setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
set textwidth=0

lua <<EOF
local ap = require("nvim-autopairs")
local rule = require("nvim-autopairs.rule")
ap.clear_rules()
ap.add_rule(rule('"', '"'))
EOF

