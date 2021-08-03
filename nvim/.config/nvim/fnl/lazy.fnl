(local {: register-luacmd : require-call-str : require-call : new_augroup}
       (require :utils))

(register-luacmd :PackerCompile "require'plugins' require'packer'.compile()")
(register-luacmd :PackerInstall "require'plugins' require'packer'.install()")

(register-luacmd :PackerStatus "require'plugins' require'packer'.status()")
(register-luacmd :PackerSync "require'plugins' require'packer'.sync()")
(register-luacmd :PackerUpdate "require'plugins' require'packer'.update()")

(new_augroup :fennel_packer ["BufWritePost plugins.fnl PackerCompile"])

