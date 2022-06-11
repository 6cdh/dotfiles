(local color
  {:dark
    {:bg "#282c34"
     :fg "#abb2bf"
     :yellow "#e5c07b"
     :cyan "#56b6c2"
     :green "#98c379"
     :orange "#d19a66"
     :violet "#a9a1e1"
     :magenta "#c678dd"
     :blue "#61afef"
     :red "#e06c75"
     :gray "#7f848e"}
   :light
    {:bg "#e6e9ef"
     :fg "#6a6a6a"
     :yellow "#eea825"
     :cyan "#56b6c2"
     :green "#40A02B"
     :orange "#ee9025"
     :violet "#a9a1e1"
     :magenta "#9a77cf"
     :blue "#04a5e5"
     :red "#D20F39"
     :gray "#bebebe"}})

(. color vim.o.background)
