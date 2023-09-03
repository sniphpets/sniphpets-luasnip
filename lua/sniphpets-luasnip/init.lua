local create_config = require('sniphpets-luasnip.config').create_config

local M = {}

function M.basename()
  return vim.fn.expand('%:t:r')
end

function M.namespace()
  return M.path_to_namespace(M.filepath(), M.config.namespace_prefix)
end

function M.filepath()
  return vim.fn.expand('%:p')
end

function M.path_to_namespace(path, namespace_prefix)
  local fqn = M.path_to_fqn(path, namespace_prefix)

  if fqn == namespace_prefix then
    return fqn
  end

  return fqn:gsub('\\[^\\]+$', '')
end

function M.path_to_fqn(path, namespace_prefix)
  namespace_prefix = namespace_prefix or ''

  local fqn = path:gsub('.php$', ''):gsub('/', '\\'):gsub('^.*\\%l[^\\]*\\?', '')

  if fqn == '' then
    return namespace_prefix
  end

  if namespace_prefix == '' then
    return fqn
  end

  return namespace_prefix .. '\\' .. fqn
end

function M.root()
  local path = debug.getinfo(1, 'S').source:sub(2)

  return vim.fn.fnamemodify(path, ':p:h:h:h')
end

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

  require('luasnip.loaders.from_lua').lazy_load({
    paths = paths,
  })
end

return M
