local config = require('sniphpets-luasnip').config

local M = {}

function M.base()
  local basename = M.basename()
  local type = 'class'

  if basename:match('Interface$') then
    type = 'interface'
  elseif basename:match('Trait$') then
    type = 'trait'
  elseif basename:match('^Abstract') then
    type = 'abstract class'
  elseif config.final_classes then
    type = 'final class'
  end

  return type .. ' ' .. basename
end

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

function M.file_header()
  local header = config.file_header

  if config.strict_types then
    header = header .. 'declare(strict_types=1);\n\n'
  end

  return header
end
return M
