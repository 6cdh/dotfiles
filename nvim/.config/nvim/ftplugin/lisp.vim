setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
set textwidth=0

lua << EOF
require("nvim-autopairs").disable()
EOF

