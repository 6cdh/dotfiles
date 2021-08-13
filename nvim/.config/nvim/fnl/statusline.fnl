(local [colors icons lsp vi_mode fs feline]
       [(require :theme.colors)
        (require :theme.icons)
        (require :feline.providers.lsp)
        (require :feline.providers.vi_mode)
        (require :fs)
        (require :feline)])

(local vf vim.fn)

(local vi_mode_colors {:NORMAL colors.green
                       :INSERT colors.red
                       :REPLACE colors.red
                       :VISUAL colors.magenta
                       :COMMAND colors.blue
                       :TERM colors.darkblue
                       :NONE colors.yellow})

(macro wrapper_str [msg s]
  `(.. ,s ,msg ,s))

(fn file_osinfo []
  (let [os (vim.bo.fileformat:lower)]
    (.. (. icons os) os)))

(fn lsp_clientnames []
  (let [clients (fs.map #$1.name (fs.tbl-values (vim.lsp.buf_get_clients)))]
    (if (fs.empty? clients) "" (.. icons.lsp (table.concat clients "/")))))

(macro lsp_diagnostics_info []
  `{:errs (lsp.get_diagnostics_count :Error)
    :warns (lsp.get_diagnostics_count :Warning)
    :infos (lsp.get_diagnostics_count :Information)
    :hints (lsp.get_diagnostics_count :Hint)})

(fn diag_enable? [s]
  #(let [diag (. (lsp_diagnostics_info) s)]
     (and (fs.!nil? diag) (not= 0 diag))))

(fn diag_of [s]
  #(.. (. icons s) (. (lsp_diagnostics_info) s)))

(fn vimode_hl []
  {:fg colors.bg :bg (vi_mode.get_mode_color)})

(local comps {:vi_mode {:left {:provider #(wrapper_str (-> (vi_mode.get_vim_mode)
                                                           (: :sub 1 3))
                                                       " ")
                               :hl vimode_hl
                               :right_sep icons.right_sep}
                        :right {:provider #(string.format " %d:%-d "
                                                          (vf.line ".")
                                                          (vf.col "."))
                                :hl vimode_hl
                                :left_sep icons.left_sep}}
              :file {:encoding {:provider :file_encoding
                                :left_sep " "
                                :hl {:fg colors.violet :style :bold}}
                     :info {:provider :file_info
                            :hl {:fg colors.blue :style :bold}}
                     :os {:provider file_osinfo
                          :left_sep " "
                          :hl {:fg colors.violet :style :bold}}
                     :type {:provider :file_type}}
              :line_percentage {:provider :line_percentage
                                :left_sep " "
                                :hl {:style :bold}}
              :scroll_bar {:provider :scroll_bar
                           :left_sep " "
                           :hl #{:fg (vi_mode.get_mode_color)}}
              :diagnos {:err {:provider (diag_of :errs)
                              :left_sep " "
                              :enabled (diag_enable? :errs)
                              :hl {:fg colors.red}}
                        :hint {:provider (diag_of :hints)
                               :left_sep " "
                               :enabled (diag_enable? :hints)
                               :hl {:fg colors.cyan}}
                        :info {:provider (diag_of :infos)
                               :left_sep " "
                               :enabled (diag_enable? :infos)
                               :hl {:fg colors.blue}}
                        :warn {:provider (diag_of :warns)
                               :left_sep " "
                               :enabled (diag_enable? :warns)
                               :hl {:fg colors.yellow}}}
              :git {:add {:provider :git_diff_added :hl {:fg colors.green}}
                    :branch {:provider :git_branch
                             :icon icons.git
                             :left_sep " "
                             :hl {:fg colors.violet :style :bold}}
                    :change {:provider :git_diff_changed
                             :hl {:fg colors.orange}}
                    :remove {:provider :git_diff_removed :hl {:fg colors.red}}}
              :lsp {:name {:provider lsp_clientnames
                           :icon icons.lsp
                           :enabled #(fs.!empty? lsp_clientnames)
                           :hl {:fg colors.yellow}}}
              :space {:provider " "}})

(local properties {:force_inactive {:filetypes [:NvimTree
                                                :dbui
                                                :packer
                                                :startify
                                                :fugitive
                                                :fugitiveblame]
                                    :buftypes [:terminal]
                                    :bufnames {}}})

(local components {:left {:active [comps.vi_mode.left
                                   comps.space
                                   comps.file.info
                                   comps.lsp.name
                                   comps.diagnos.err
                                   comps.diagnos.warn
                                   comps.diagnos.hint
                                   comps.diagnos.info]
                          :inactive [comps.vi_mode.left
                                     comps.space
                                     comps.file.info]}
                   :mid {:active {} :inactive {}}
                   :right {:active [comps.git.add
                                    comps.git.change
                                    comps.git.remove
                                    comps.file.os
                                    comps.git.branch
                                    comps.line_percentage
                                    comps.space
                                    comps.vi_mode.right]
                           :inactive {}}})

(feline.setup {:default_bg colors.bg
               :default_fg colors.fg
               : components
               : properties
               : vi_mode_colors})

