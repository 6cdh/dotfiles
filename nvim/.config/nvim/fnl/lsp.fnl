(local fs (require :fs))

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
        :rust_analyzer {}
        :efm {:init_options {:documentFormatting true}
              :filetypes [:cpp
                          :dockerfile
                          :fennel
                          :go
                          :json
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
                        :efm
                        :sumneko_lua])

(let [lspconfig (require :lspconfig)]
  (fs.imap2 #((. lspconfig $1 :setup) (vim.tbl_extend :force config.default
                                                      (. config $1)))
            enabled-servers))

(let [lspkind (require :lspkind)]
  (lspkind.init {:with_text false
                 :symbol_map {:Text " "
                              :Method " "
                              :Function " "
                              :Constructor " "
                              :Variable " "
                              :Class " "
                              :Interface " "
                              :Module " "
                              :Property " "
                              :Unit " "
                              :Value " "
                              :Enum " "
                              :Keyword " "
                              :Snippet " "
                              :Color " "
                              :File " "
                              :Reference " "
                              :Folder " "
                              :EnumMember " "
                              :Constant " "
                              :Struct " "
                              :Event " "
                              :Operator " "
                              :TypeParameter " "}}))

