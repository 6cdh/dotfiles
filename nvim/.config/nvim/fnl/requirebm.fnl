(local require _G._require)

(fn _require [module]
  (if _G.nvim_profile (let [_s (os.clock)
                            m (require module)]
                        (let [path (.. (vim.fn.stdpath :cache) :/profile.log)
                              f (io.open path :a)]
                          (f:write module " takes " (* (- (os.clock) _s) 1000)
                                   " ms\n")
                          (f:close))
                        m) (require module)))

{:require _require}

