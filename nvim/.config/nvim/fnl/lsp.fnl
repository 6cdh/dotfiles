(local sumneko_root_path
       (.. (vim.fn.stdpath :cache) :/lspconfig/sumneko_lua/lua-language-server))

(local config
       {:default {:flags {:debounce_text_changes 500}}
        :bashls {}
        :clangd {:on_attach #(set $1.resolved_capabilities.document_formatting
                                  false)}
        :pyright {}
        :hls {}
        :vimls {}
        :texlab {}
        :gopls {}
        :racket_langserver {}
        :clojure_lsp {}
        :rust_analyzer {:settings {:rust-analyzer {:checkOnSave {:command :clippy}}}}
        :efm {:init_options {:documentFormatting true}
              :filetypes [:cpp
                          :css
                          :dockerfile
                          :fennel
                          :go
                          :html
                          :json
                          :javascript
                          :lua
                          :markdown
                          :python
                          :sh
                          :toml
                          :vim
                          :yaml]}
        :sumneko_lua {:cmd [:lua-language-server
                            :-E
                            (.. sumneko_root_path :/main.lua)]
                      :settings {:Lua {:runtime {:version :LuaJIT
                                                 :path (vim.split package.path
                                                                  ";")}
                                       :diagnostics {:globals [:vim]}
                                       :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                             (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}}
                                       :telemetry {:enable false}}}}})

(local enabled-servers [:bashls
                        :clangd
                        :pyright
                        :hls
                        :vimls
                        :texlab
                        :gopls
                        :rust_analyzer
                        :racket_langserver
                        :clojure_lsp
                        :efm
                        :sumneko_lua])

(let [lspconfig (require :lspconfig)
      fl (require :fulib)]
  (fn setup-server [server]
    ((. lspconfig server :setup) (vim.tbl_extend :force config.default
                                                 (. config server))))

  (fl.for_each setup-server enabled-servers))

(vim.lsp.set_log_level :error)

