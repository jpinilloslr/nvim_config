-- Requires black and prettier to be installed through Mason
return {
  'sbdchd/neoformat',
  commit = 'b3b3858',
  setup = function()
    vim.g.neoformat_enabled_python = { 'black' }
    vim.g.neoformat_enabled_javascript = { 'prettier' }
    vim.g.neoformat_enabled_typescript = { 'prettier' }
    vim.g.neoformat_enabled_css = { 'prettier' }
    vim.g.neoformat_enabled_scss = { 'prettier' }
    vim.g.neoformat_enabled_html = { 'prettier' }
    vim.g.neoformat_enabled_graphql = { 'prettier' }
    vim.g.neoformat_enabled_react = { 'prettier' }
  end
}
