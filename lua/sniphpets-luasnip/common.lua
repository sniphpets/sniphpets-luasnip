local config = require('sniphpets-luasnip').config()

local M = {}

function M.basename()
  return vim.fn.expand('%:t:r')
end

function M.fqn()
  return M.path_to_fqn(M.filepath(), config.namespace_prefix)
end

function M.namespace()
  return M.path_to_namespace(M.filepath(), config.namespace_prefix)
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

return M
