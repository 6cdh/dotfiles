(fn setup [spec]
  (let [{:package-manager pm-name
         :packages pkgs-name
         :mods mods}
        spec]
    (let [pm (require pm-name)
          pkgs (require pkgs-name)]
      (pm.setup pkgs))
    (each [_ name (ipairs mods)]
      (let [m (require (.. "modules." name))]
        (m.setup)))))

{: setup}
