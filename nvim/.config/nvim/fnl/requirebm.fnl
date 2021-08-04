(local require _G._require)

(fn _require [module]
  (fn profile-require []
    (let [_s (os.clock)
          m (require module)
          _e (os.clock)
          path _G.startup_features.profile_path
          f (io.open path :a)]
      (f:write module " takes " (-> (- _e _s) (* 1000)) " ms\n")
      (f:close)
      m))

  (if _G.startup_features.debug (profile-require) (require module)))

{:require _require}

