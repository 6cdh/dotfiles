(local sumneko_root_path
       (.. (vim.fn.stdpath :cache)
           :/lspconfig/sumneko_lua/lua-language-server))

(local config-tbl
  {:default {:flags {:debounce_text_changes 500}
             :clangd {:on_attach #(set $1.resolved_capabilities.document_formatting false)}
             :rust_analyzer {:settings {:rust-analyzer {:checkOnSave {:command :clippy}}}}
             :efm {:init_options {:documentFormatting true}
                   :filetypes [:cpp :css :dockerfile :go :html :json :javascript :lua
                               :markdown :python :sh :toml :vim :yaml]}
             :sumneko_lua {:cmd [:lua-language-server
                                 :-E
                                 (.. sumneko_root_path :/main.lua)]
                           :settings {:Lua {:runtime {:version :LuaJIT
                                                      :path (vim.split package.path ";")}
                                            :diagnostics {:globals [:vim]}
                                            :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                                  (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}}
                                            :telemetry {:enable false}}}}}})

(local config (setmetatable config-tbl {:__index #{}}))

(let [lsp_installer (require :nvim-lsp-installer)]
  (lsp_installer.on_server_ready
    (fn [server]
      (server:setup (vim.tbl_extend :force
                                    config.default
                                    (. config server))))))

(vim.lsp.set_log_level :error)

