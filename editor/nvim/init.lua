local preconfig = require 'modules.preconfig'

preconfig 'https://github.com/savq/paq-nvim'

for _, mod in pairs({ 'pkgs', 'options', 'map' }) do
    require("modules." .. mod)
end
