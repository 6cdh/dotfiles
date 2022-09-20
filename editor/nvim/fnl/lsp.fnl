(local sumneko_root_path
       (.. (vim.fn.stdpath :cache)
           :/lspconfig/sumneko_lua/lua-language-server))

(local config-tbl
  {:default {:flags {:debounce_text_changes 500}}
   :rust_analyzer {:settings {:rust-analyzer {:checkOnSave {:command :clippy}}}}
   :efm {:init_options {:documentFormatting true}
         :filetypes [:cpp :css :dockerfile :go :html :json :javascript :lua
                     :markdown :python :sh :toml :vim :yaml]}
   :sumneko_lua {:settings {:Lua {:runtime {:version :LuaJIT
                                            :path (vim.split package.path ";")}
                                  :diagnostics {:globals [:vim]}
                                  :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                        (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}}
                                  :telemetry {:enable false}}}}})

(local config (setmetatable config-tbl {:__index #{}}))

(local enabled_servers [:clangd :rust_analyzer :sumneko_lua :hls
                        :ocamllsp
                        :rnix :racket_langserver :tsserver :kotlin_language_server])

((-> (require "nvim-lsp-installer")
    (. :setup)))

(let [lspconfig (require "lspconfig")]
  (each [_ server (ipairs enabled_servers)]
    ((-> lspconfig
        (. server)
        (. :setup))
     (vim.tbl_extend :force config.default (. config server)))))

(vim.lsp.set_log_level :error)

