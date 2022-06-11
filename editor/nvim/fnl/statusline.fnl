(local [colors icons vi_mode fl]
       [(require :theme.colors)
        (require :theme.icons)
        (require :feline.providers.vi_mode)
        (require :fulib)])

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
  (let [clients (->> (vim.lsp.buf_get_clients)
                     (fl.table-values)
                     (fl.map #$1.name))]
    (table.concat clients "/")))

(fn vimode_hl []
  {:fg "fg" :bg (vi_mode.get_mode_color)})

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
                                :hl {:fg "violet" :style :bold}}
                     :info {:provider {:name :file_info
                                       :opts {:file_modified_icon "[+]"
                                              :file_readonly_icon " "}}
                            :left_sep " "
                            :hl {:fg "blue" :style :bold}}
                     :os {:provider #(vim.bo.fileformat:lower)
                          :icon #(. icons (vim.bo.fileformat:lower))
                          :left_sep " "
                          :hl {:fg "violet" :style :bold}}
                     :type {:provider :file_type}}
              :line_percentage {:provider :line_percentage
                                :left_sep " "
                                :hl {:style :bold}}
              :diagnos {:err {:provider :diagnostic_errors
                              :icon icons.errs
                              :left_sep " "
                              :hl {:fg "red"}}
                        :hint {:provider :diagnostic_hints
                               :icon icons.hints
                               :left_sep " "
                               :hl {:fg "cyan"}}
                        :info {:provider :diagnostic_info
                               :icon icons.infos
                               :left_sep " "
                               :hl {:fg "blue"}}
                        :warn {:provider :diagnostic_warnings
                               :icon icons.warns
                               :left_sep " "
                               :hl {:fg "yellow"}}}
              :git {:branch {:provider :git_branch
                             :icon icons.git
                             :left_sep " "
                             :hl {:fg "violet" :style :bold}}
                    :add {:provider :git_diff_added :hl {:fg "green"}}
                    :change {:provider :git_diff_changed
                             :hl {:fg "orange"}}
                    :remove {:provider :git_diff_removed :hl {:fg "red"}}}
              :lsp {:name {:provider lsp_clientnames
                           :icon icons.lsp
                           :left_sep " "
                           :hl {:fg "yellow"}}}})

(local components
       {:active [[comps.vi_mode.left
                  comps.file.info
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
  (feline.setup {:theme colors
                 : components
                 :force_inactive {:filetypes [:NvimTree
                                              :dbui
                                              :packer
                                              :startify
                                              :fugitive
                                              :fugitiveblame]
                                  :buftypes [:terminal]
                                  :bufnames {}}
                 : vi_mode_colors}))

