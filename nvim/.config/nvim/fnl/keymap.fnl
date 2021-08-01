(local utils (require :utils))
(local npairs (require :nvim-autopairs))
(local fs (require :fs))
(local vf vim.fn)

; Keymap Principles
; 1. Balance two hands.
; 2. As few as possible keystrokes.
; 3. Map the most frequently functions to repected keystrokes.
; 4. Semantic mappings.
; 5. A key on the home row is expected if it can't meet the principle 4.

; stylua: ignore start

(local left-hand [:q :w :e :r :t :a :s :d :f :g :z :x :c :v :b])
(local right-hand [:y :u :i :o :p :h :j :k :l :n :m])

(fn cmd [s]
  (.. :<Cmd> s :<CR>))

(fn plug [s]
  (.. :<Plug> s))

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
                 :l [(cmd "lua require\"lspsaga.diagnostic\".show_line_diagnostics()")
                     "Show Line Diagnostics"]
                 :a [(cmd "Lspsaga diagnostic_jump_prev") "Last Diagnostic"]
                 :f [(cmd "Lspsaga diagnostic_jump_next") "Next Diagnostic"]}
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
             :c {:name :Clipboard :p ["\"+y" "Copy Selection"]}})

(fn verify-maps [maps]
  (fn not-both-in-tbl [tbl v1 v2]
    (or (fs.!member? v1 tbl) (fs.!member? v2 tbl)))

  (fn check-each [v k]
    (if (and (fs.tbl? v) (fs.!nil? v.name))
        (fs.map2 #(assert (or (= $2 :name) (= k $2)
                              (and (not-both-in-tbl left-hand k $2)
                                   (not-both-in-tbl right-hand k $2)))
                          (.. "Mappings Didn't Balance\n        Two Hands: " k
                              $2)) v)))

  (fs.map2 check-each maps))

(verify-maps nmap)
(verify-maps vmap)

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

(fn _G.smart_tab []
  (if (and (not= (vf.pumvisible) 0)
           (not= (. (vf.complete_info [:selected]) :selected) -1))
      ((. vf "compe#confirm"))
      (= ((. vf "vsnip#available") 1) 1)
      (utils.to_keycodes "<Plug>(vsnip-expand-or-jump)")
      (utils.to_keycodes :<TAB>)))

(fn _G.smart_cr []
  (if (not= (vf.pumvisible) 0) (npairs.esc :<cr>) (npairs.autopairs_cr)))

(kmap mode.insert :<TAB> "v:lua.smart_tab()" :expr :silent)
(kmap mode.insert :<CR> "v:lua.smart_cr()" :expr :silent)

