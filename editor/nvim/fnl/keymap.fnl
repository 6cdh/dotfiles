(local fl (require :fulib))

(local vf vim.fn)

; Keymap Principles
; 1. Balance two hands.
; 2. As few as possible keystrokes.
; 3. use repeated keystrokes for the most common action
; 4. Semantic mappings.
; 5. A key on the home row is expected if it can't meet the principle 4.

; Colemak layout
(local [left-hand right-hand]
       [[:q :w :f :p :g
         :a :r :s :t :d
         :z :x :c :v]
        [:j :l :u :y
         :h :n :e :i :o
         :b :k :m]])

(macro cmd [s]
  (string.format "<Cmd>%s<CR>" s))

(macro luacmd [s]
  (string.format "<Cmd>lua %s<CR>" s))

(macro plug [s]
  (string.format "<Plug>%s" s))

;; keymap format

; {:<prefix> {:name :<prefix-name> ;; name is optional
;             ;; A family of keymap
;             :<key> [:<cmd> :<description>]
;             :<key> [:<cmd> :<description>]
;             ...}
;  ...
;  :<prefix> [:<cmd> :<description>]}

(local nmap {:p {:name "Plugins Manager"
                 :p [(cmd :PackerSync) :PackerSync]
                 :l [(cmd :PackerClean) :PackerClean]
                 :u [(cmd :PackerUpdate) :PackerUpdate]
                 :o [(cmd :PackerCompile) :PackerCompile]
                 :y [(cmd :PackerStatus) :PackerStatus]
                 :i [(cmd :PackerInstall) :PackerInstall]}
             :t {:name :Toggle
                 :t [":<c-u>exe v:count1 . \"ToggleTerm\"<CR>"
                     "Embeded Float Terminal"]
                 :m [(cmd :terminal) :Terminal]
                 :i [(cmd :TogglePair) :Autopair]}
             :o {:name "Code Action"
                 :o [(luacmd "vim.lsp.buf.format({async=true})") "Format Buffer"]
                 :t {1 ":Tabularize /" 2 :Align :silent false}
                 :f [(luacmd "vim.lsp.buf.definition()")
                     "Find definitions and references"]
                 :a [(luacmd "vim.lsp.buf.code_action()") "Code Action By LSP"]
                 :r [(luacmd "vim.lsp.buf.rename()") :Rename]
                 :c [(plug :kommentary_line_default) :Comment]
                 :s [(cmd :Codi) "Run REPL"]
                 :d [(cmd :Codi!) "Close REPL"]}
             :e {:name :Explorer
                 :e [(cmd :Lexplore) :Netrw]
                 :t [(cmd :RnvimrToggle) :Ranger]}
             :s {:name :Search
                 :s [(cmd "Telescope live_grep") :Grep]
                 :n [(cmd "Telescope find_files") :Files]
                 :b [(cmd "Telescope buffers") :Buffers]
                 :h [(cmd "Telescope help_tags") :Help]}
             :f {:name :File
                 :f [(cmd "set filetype") "Set FileType"]}
             :b {:name :Buffer
                 :b [(cmd :BufferLinePick) :BufferLinePick]
                 :p [(cmd :BufferLineCyclePrev) :BufferLinePrevious]
                 :t [(cmd :BufferLineCycleNext) :BufferLineNext]
                 :d [(cmd :bdelete) :BufferClose]}
             :r {:name "Root action"
                 :r [(cmd :SudoWrite) "Write as Root"]}
             :c {:name :Clipboard
                 :n [(cmd "%y+") "Copy Buffer"]
                 :e ["\"+p" "Paste content"]}
             :l {:name :Lint/Diagnostics
                 :l [(luacmd "vim.diagnostic.open_float()")
                     "Show Line Diagnostics"]
                 :s [(luacmd "require'trouble'.previous({skip_groups=true, jump=true})")
                     "Last Diagnostic"]
                 :t [(luacmd "require'trouble'.next({skip_groups=true, jump=true})")
                     "Next Diagnostic"]}
             :h {:name :Hotpot
                 :c [(cmd :HotpotCompileBuf) "Compile Buffer"]}
             :w [(cmd :up) "Save if changed"]
             :q [(cmd :q) :Quit]
             :Q [(cmd :q!) "Force Quit"]})

(local vmap {:o {:name "Code Action"
                 :o [(luacmd "vim.lsp.buf.range_formatting()")
                     "Format Selection"]
                 :t {1 ":Tabularize /" 2 :Align :silent false}
                 :a [(luacmd "vim.lsp.buf.range_code_action()")
                     "Code Action By LSP"]
                 :c [(plug :kommentary_visual_default<C-c>) :Comment]
                 :s [(cmd :Codi) "Run REPL"]
                 :d [(cmd :Codi!) "Close REPL"]}
             :c {:name :Clipboard
                 :n ["\"+y" "Copy Selection"]}
             :h {:name :Hotpot
                 :c [(cmd :HotpotCompileSel) "Compile Selection"]}})

(fn verify-maps-balance-hands [maps]
  "{str {str str|[str]}|[str]} -> ()"
  (fn not-both-in-tbl [tbl v1 v2]
    (or (fl.not-member? v1 tbl) (fl.not-member? v2 tbl)))

  (fn verify-each-family [family prefix]
    "{str str|[str]}|[str] -> str -> ()"
    (fn verify-key [map key]
      "str|[str] -> str -> ()"
      (if (and (not= key :name) (not= key prefix))
          (assert (and (not-both-in-tbl left-hand key prefix)
                       (not-both-in-tbl right-hand key prefix))
                  (.. "Mappings Didn't Balance Two Hands: " prefix key))))

    (if (and (fl.table? family) (fl.not-list? family))
        (fl.for-each verify-key family)))

  (fl.for-each verify-each-family maps))

(verify-maps-balance-hands nmap)
(verify-maps-balance-hands vmap)

(local mode {:normal :n
             :select :s
             :visual :x
             :insert :i
             :cmd :c
             :terminal :t
             :operator_pending :o
             :visual_select :v})

(let [wk (require :which-key)]
  (wk.register nmap {:prefix :<leader>
                     :mode mode.normal
                     :noremap true
                     :silent true})
  (wk.register vmap {:prefix :<leader>
                     :mode mode.visual
                     :noremap true
                     :silent true}))

(macro to_keycodes [s]
  `(vim.api.nvim_replace_termcodes ,s true true true))

(macro kmap [m lhs rhs ...]
  `(let [t# {}]
     (fl.for-each #(tset t# $1 true) [,...])
     (vim.api.nvim_set_keymap ,m ,lhs ,rhs t#)))

(kmap mode.normal :<M-j> :<C-w>j :noremap)
(kmap mode.normal :<M-k> :<C-w>k :noremap)
(kmap mode.normal :<M-h> :<C-w>h :noremap)
(kmap mode.normal :<M-l> :<C-w>l :noremap)
(kmap mode.normal :<C-l> (cmd :noh) :noremap)

(kmap mode.terminal :<M-j> "<C-\\><C-n><C-w>j" :noremap)
(kmap mode.terminal :<M-k> "<C-\\><C-n><C-w>k" :noremap)
(kmap mode.terminal :<M-h> "<C-\\><C-n><C-w>h" :noremap)
(kmap mode.terminal :<M-l> "<C-\\><C-n><C-w>l" :noremap)

(kmap mode.normal :K (luacmd "vim.lsp.buf.hover()") :noremap :silent)

