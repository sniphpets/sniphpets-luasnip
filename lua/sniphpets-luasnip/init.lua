local create_config = require('sniphpets-luasnip.config').create_config

local M = {}
local config = create_config()

function M.root()
  local path = debug.getinfo(1, 'S').source:sub(2)

  return vim.fn.fnamemodify(path, ':p:h:h:h')
end

function M.config()
  return config
end

function M.setup(opts)
  config = create_config(opts)

  local snippets_path = M.root() .. '/snippets'

  local paths = {}
  if config.common.enabled then
    table.insert(paths, snippets_path .. '/common')
  end
  if config.phpunit.enabled then
    table.insert(paths, snippets_path .. '/phpunit')
  end
  if config.symfony.enabled then
    table.insert(paths, snippets_path .. '/symfony')
  end
  if config.doctrine.enabled then
    table.insert(paths, snippets_path .. '/doctrine')
  end

  require('luasnip.loaders.from_lua').lazy_load({
    paths = paths,
  })
end

return M
