(local [utils npairs fs] [(require :utils)
                          (require :nvim-autopairs)
                          (require :fs)])

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

(fn cmd [s]
  (.. :<Cmd> s :<CR>))

(fn plug [s]
  (.. :<Plug> s))

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
                 :o [(cmd "lua vim.lsp.buf.formatting()") "Format Buffer"]
                 :t {1 ":Tabularize /" 2 :Align :silent false}
                 :f [(cmd "Lspsaga lsp_finder")
                     "Find definitions and references"]
                 :a [(cmd "Lspsaga code_action") "Code Action By LSP"]
                 :r [(cmd "lua vim.lsp.buf.rename()") :Rename]
                 :c [(plug :kommentary_line_default) :Comment]
                 :s [(cmd :Codi) "Run REPL"]
                 :d [(cmd :Codi!) "Close REPL"]}
             :e {:name :Explorer
                 :e [(cmd :NvimTreeToggle) :NvimTree]
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
             :r {:name "Root action"
                 :r [(cmd :SudaWrite) "Write as Root"]
                 :j [(cmd :SudaRead) "Read as Root"]}
             :c {:name :Clipboard :p [(cmd "%y+") "Copy Buffer"]}
             :l {:name :Lint/Diagnostics
                 :l [(cmd "lua require'lspsaga.diagnostic'.show_line_diagnostics()")
                     "Show Line Diagnostics"]
                 :a [(cmd "Lspsaga diagnostic_jump_prev") "Last Diagnostic"]
                 :f [(cmd "Lspsaga diagnostic_jump_next") "Next Diagnostic"]}
             :h {:name :Hotpot :c [(cmd :HotpotCompileBuf) "Compile Buffer"]}
             :w [(cmd :w) :Save]
             :q [(cmd :q) :Quit]
             :Q [(cmd :q!) "Force Quit"]})

(local vmap {:o {:name "Code Action"
                 :o [(cmd "lua vim.lsp.buf.range_formatting()")
                     "Format Selection"]
                 :t {1 ":Tabularize /" 2 :Align :silent false}
                 :a [(cmd "Lspsaga range_code_action") "Code Action By LSP"]
                 :c [(plug :kommentary_visual_default<C-c>) :Comment]
                 :s [(cmd :Codi) "Run REPL"]
                 :d [(cmd :Codi!) "Close REPL"]}
             :c {:name :Clipboard :p ["\"+y" "Copy Selection"]}
             :h {:name :Hotpot
                 :c [(cmd :HotpotCompileSel) "Compile Selection"]}})

(fn verify-maps-balance-hands [maps]
  "{str {str str|[str]}|[str]} -> ()"
  (fn not-both-in-tbl [tbl v1 v2]
    (or (fs.!member? v1 tbl) (fs.!member? v2 tbl)))

  (fn verify-each-family [family prefix]
    "{str str|[str]}|[str] -> str -> ()"
    (fn verify-key [map key]
      "str|[str] -> str -> ()"
      (if (and (not= key :name) (not= key prefix))
          (assert (and (not-both-in-tbl left-hand key prefix)
                       (not-both-in-tbl right-hand key prefix))
                  (.. "Mappings Didn't Balance Two Hands: " prefix key))))

    (if (and (fs.tbl? family) (fs.!list? family))
        (fs.map2 verify-key family)))

  (fs.map2 verify-each-family maps))

(if _G.startup_features.debug
    (do
      (verify-maps-balance-hands nmap)
      (verify-maps-balance-hands vmap)))

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

(fn _G.smart_tab []
  (if (and (not= (vf.pumvisible) 0)
           (not= (. (vf.complete_info [:selected]) :selected) -1))
      ((. vf "compe#confirm"))
      (= ((. vf "vsnip#available") 1) 1)
      (utils.to_keycodes "<Plug>(vsnip-expand-or-jump)")
      (utils.to_keycodes :<TAB>)))

(fn _G.smart_cr []
  (if (not= (vf.pumvisible) 0) (npairs.esc :<cr>) (npairs.autopairs_cr)))

(fn kmap [m lhs rhs ...]
  (let [t {}]
    (fs.imap2 #(tset t $1 true) [...])
    (vim.api.nvim_set_keymap m lhs rhs t)))

(kmap mode.normal :<C-j> :<C-w>j :noremap)
(kmap mode.normal :<C-k> :<C-w>k :noremap)
(kmap mode.normal :<C-h> :<C-w>h :noremap)
(kmap mode.normal :<C-l> :<C-w>l :noremap)

(kmap mode.terminal :<C-j> "<C-\\><C-n><C-w>j" :noremap)
(kmap mode.terminal :<C-k> "<C-\\><C-n><C-w>k" :noremap)
(kmap mode.terminal :<C-h> "<C-\\><C-n><C-w>h" :noremap)
(kmap mode.terminal :<C-l> "<C-\\><C-n><C-w>l" :noremap)

(kmap mode.normal :K (cmd "Lspsaga hover_doc" :noremap :silent))

(kmap mode.insert :<TAB> "v:lua.smart_tab()" :expr :silent)
(kmap mode.insert :<CR> "v:lua.smart_cr()" :expr :silent)

