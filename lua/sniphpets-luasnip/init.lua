local create_config = require('sniphpets-luasnip.config').create_config

local M = {}

M.config = create_config()

function M.setup(opts)
  M.config = create_config(opts)

  local snippets_path = M.root() .. '/snippets'

  local paths = {}
  if M.config.common.enabled then
    table.insert(paths, snippets_path .. '/common')
  end
  if M.config.phpunit.enabled then
    table.insert(paths, snippets_path .. '/phpunit')
  end
  if M.config.symfony.enabled then
    table.insert(paths, snippets_path .. '/symfony')
  end
  if M.config.doctrine.enabled then
    table.insert(paths, snippets_path .. '/doctrine')
  end
  if M.config.eloquent.enabled then
    table.insert(paths, snippets_path .. '/eloquent')
  end

  require('luasnip.loaders.from_lua').lazy_load({
    paths = paths,
  })
end

function M.root()
  local path = debug.getinfo(1, 'S').source:sub(2)

  return vim.fn.fnamemodify(path, ':p:h:h:h')
end

return M
