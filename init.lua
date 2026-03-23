-- Disable unused remote providers early so health checks don't report them.
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
