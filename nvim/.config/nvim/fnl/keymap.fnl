(local fl (require :fulib))

(local vf vim.fn)

; Keymap Principles
; 1. Balance two hands.
; 2. As few as possible keystrokes.
; 3. Map the most frequently functions to repected keystrokes.
; 4. Semantic mappings.
; 5. A key on the home row is expected if it can't meet the principle 4.

(local [left-hand right-hand]
       [[:q :w :e :r :t :a :s :d :f :g :z :x :c :v :b]
        [:y :u :i :o :p :h :j :k :l :n :m]])

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
                 :c [(cmd :PackerClean) :PackerClean]
                 :d [(cmd :PackerUpdate) :PackerUpdate]
                 :e [(cmd :PackerCompile) :PackerCompile]
                 :s [(cmd :PackerStatus) :PackerStatus]
                 :t [(cmd :PackerInstall) :PackerInstall]}
             :t {:name :Terminal
                 :t [":<c-u>exe v:count1 . \"ToggleTerm\"<CR>"
                     "Embeded Float Terminal"]
                 :m [(cmd :terminal) :Terminal]}
             :o {:name "Code Action"
                 :o [(luacmd "vim.lsp.buf.formatting()") "Format Buffer"]
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
                 :j [(cmd :RnvimrToggle) :Ranger]}
             :s {:name :Search
                 :s [(cmd "Telescope live_grep") :Grep]
                 :j [(cmd "Telescope find_files") :Files]
                 :k [(cmd "Telescope buffers") :Buffers]
                 :h [(cmd "Telescope help_tags") :Help]}
             :f {:name :File :f [(cmd "set filetype") "Set FileType"]}
             :b {:name :Buffer
                 :b [(cmd :BufferLinePick) :BufferLinePick]
                 :h [(cmd :BufferLineCyclePrev) :BufferLinePrevious]
                 :l [(cmd :BufferLineCycleNext) :BufferLineNext]
                 :j [(cmd :bdelete) :BufferClose]}
             :r {:name "Root action" :r [(cmd :SudoWrite) "Write as Root"]}
             :c {:name :Clipboard
                 :p [(cmd "%y+") "Copy Buffer"]
                 :j ["\"+p" "Paste content"]}
             :l {:name :Lint/Diagnostics
                 :l [(luacmd "vim.lsp.diagnostic.show_line_diagnostics()")
                     "Show Line Diagnostics"]
                 :a [(luacmd "require'trouble'.previous({skip_groups=true, jump=true})")
                     "Last Diagnostic"]
                 :f [(luacmd "require'trouble'.next({skip_groups=true, jump=true})")
                     "Next Diagnostic"]}
             :h {:name :Hotpot :c [(cmd :HotpotCompileBuf) "Compile Buffer"]}
             :w [(cmd :w) :Save]
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
             :c {:name :Clipboard :p ["\"+y" "Copy Selection"]}
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
        (fl.for_each verify-key family)))

  (fl.for_each verify-each-family maps))

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
     (fl.for_each #(tset t# $1 true) [,...])
     (vim.api.nvim_set_keymap ,m ,lhs ,rhs t#)))

(kmap mode.normal :<M-j> :<C-w>j :noremap)
(kmap mode.normal :<M-k> :<C-w>k :noremap)
(kmap mode.normal :<M-h> :<C-w>h :noremap)
(kmap mode.normal :<M-l> :<C-w>l :noremap)

(kmap mode.terminal :<M-j> "<C-\\><C-n><C-w>j" :noremap)
(kmap mode.terminal :<M-k> "<C-\\><C-n><C-w>k" :noremap)
(kmap mode.terminal :<M-h> "<C-\\><C-n><C-w>h" :noremap)
(kmap mode.terminal :<M-l> "<C-\\><C-n><C-w>l" :noremap)

(kmap mode.normal :K (luacmd "vim.lsp.buf.hover()" :noremap :silent))

