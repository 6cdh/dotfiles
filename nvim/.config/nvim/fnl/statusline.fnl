(local [colors icons vi_mode fl gps]
       [(require :theme.colors)
        (require :theme.icons)
        (require :feline.providers.vi_mode)
        (require :fulib)
        (require :nvim-gps)])

(local vf vim.fn)

(local vi_mode_colors {:NORMAL colors.green
                       :INSERT colors.red
                       :REPLACE colors.red
                       :VISUAL colors.magenta
                       :COMMAND colors.blue
                       :TERM colors.darkblue
                       :NONE colors.yellow})

(fn wrapper-space [msg]
  (.. " " msg " "))

(fn lsp_clientnames []
  (let [clients (->> (vim.lsp.buf_get_clients) (fl.tbl-values)
                     (fl.map #$1.name))]
    (table.concat clients "/")))

(fn vimode_hl []
  {:fg colors.bg :bg (vi_mode.get_mode_color)})

(local comps {:vi_mode {:left {:provider #(wrapper-space (-> (vi_mode.get_vim_mode)
                                                             (: :sub 1 3)))
                               :hl vimode_hl
                               :right_sep icons.right_sep}
                        :right {:provider #(string.format " %d:%-d "
                                                          (vf.line ".")
                                                          (vf.col "."))
                                :hl vimode_hl
                                :left_sep (.. " " icons.left_sep)}}
              :file {:encoding {:provider :file_encoding
                                :left_sep " "
                                :hl {:fg colors.violet :style :bold}}
                     :info {:provider :file_info
                            :left_sep " "
                            :hl {:fg colors.blue :style :bold}}
                     :os {:provider #(vim.bo.fileformat:lower)
                          :icon #(. icons (vim.bo.fileformat:lower))
                          :left_sep " "
                          :hl {:fg colors.violet :style :bold}}
                     :type {:provider :file_type}}
              :context {:name {:provider #(gps.get_location)
                               :enabled #(gps.is_available)
                               :hl {:fg colors.blue :style :bold}}}
              :line_percentage {:provider :line_percentage
                                :left_sep " "
                                :hl {:style :bold}}
              :diagnos {:err {:provider :diagnostic_errors
                              :icon icons.errs
                              :left_sep " "
                              :hl {:fg colors.red}}
                        :hint {:provider :diagnostic_hints
                               :icon icons.hints
                               :left_sep " "
                               :hl {:fg colors.cyan}}
                        :info {:provider :diagnostic_info
                               :icon icons.infos
                               :left_sep " "
                               :hl {:fg colors.blue}}
                        :warn {:provider :diagnostic_warnings
                               :icon icons.warns
                               :left_sep " "
                               :hl {:fg colors.yellow}}}
              :git {:branch {:provider :git_branch
                             :icon icons.git
                             :left_sep " "
                             :hl {:fg colors.violet :style :bold}}
                    :add {:provider :git_diff_added :hl {:fg colors.green}}
                    :change {:provider :git_diff_changed
                             :hl {:fg colors.orange}}
                    :remove {:provider :git_diff_removed :hl {:fg colors.red}}}
              :lsp {:name {:provider lsp_clientnames
                           :icon icons.lsp
                           :left_sep " "
                           :hl {:fg colors.yellow}}}})

(local properties {:force_inactive {:filetypes [:NvimTree
                                                :dbui
                                                :packer
                                                :startify
                                                :fugitive
                                                :fugitiveblame]
                                    :buftypes [:terminal]
                                    :bufnames {}}})

(local components
       {:active [[comps.vi_mode.left
                  comps.file.info
                  comps.context.name
                  comps.lsp.name
                  comps.diagnos.err
                  comps.diagnos.warn
                  comps.diagnos.hint
                  comps.diagnos.info]
                 [comps.git.add
                  comps.git.change
                  comps.git.remove
                  comps.file.os
                  comps.git.branch
                  comps.line_percentage
                  comps.vi_mode.right]]
        :inactive [[comps.vi_mode.left comps.file.info]]})

(let [feline (require :feline)]
  (feline.setup {:default_bg colors.bg
                 :default_fg colors.fg
                 : components
                 : properties
                 : vi_mode_colors}))

