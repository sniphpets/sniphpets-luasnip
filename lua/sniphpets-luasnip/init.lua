local M = {}

function M.dirname(path)
  return vim.fn.fnamemodify(path, ':h')
end

function M.basename()
  return vim.fn.expand('%:t:r')
end

function M.filepath()
  return vim.fn.expand('%:p')
end

function M.namespace()
  return M.path_to_namespace(M.filepath(), M.opts.namespace_prefix)
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

  local fqn = path:gsub('.php$', ''):gsub('/', '\\')

  local i = fqn:find('\\%u')
  if i == nil then
    return namespace_prefix
  end

  fqn = fqn:sub(i + 1, -1)

  if namespace_prefix == '' then
    return fqn
  end

  return namespace_prefix .. '\\' .. fqn
end

local defaults = {
  strict_types = false,
  namespace_prefix = 'App',
  common = {
    enabled = true,
    prefix = '',
  },
  symfony = {
    enabled = false,
    prefix = 'sf',
  },
  phpunit = {
    enabled = false,
    prefix = 'pu',
    namespace_prefix = 'App\\Tests',
  },
  doctrine = {
    enabled = false,
    prefix = 'dc',
  },
}

M.opts = vim.deepcopy(defaults)

M.setup = function(opts)
  M.opts = vim.tbl_deep_extend('force', M.opts, opts or {})

  local path = M.dirname(debug.getinfo(1).source:sub(2)) .. '/../../snippets'

  local paths = {}
  if M.opts.common.enabled then
    table.insert(paths, path .. '/common')
  end
  if M.opts.phpunit.enabled then
    table.insert(paths, path .. '/phpunit')
  end
  if M.opts.symfony.enabled then
    table.insert(paths, path .. '/symfony')
  end
  if M.opts.doctrine.enabled then
    table.insert(paths, path .. '/doctrine')
  end

  require('luasnip.loaders.from_lua').lazy_load({
    paths = paths,
  })
end

return M
