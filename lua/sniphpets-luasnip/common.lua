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

function M.method_visibility(_, snip)
  return M.visibility(snip.captures[1], 'public')
end

function M.property_visibility(_, snip)
  return M.visibility(snip.captures[1], 'private')
end

function M.visibility(mode, default)
  local vis = default or 'public'

  if mode:match('u') then
    vis = 'public'
  elseif mode:match('o') then
    vis = 'protected'
  elseif mode:match('i') then
    vis = 'private'
  end

  if mode:match('s') then
    vis = vis .. ' static'
  end

  if mode:match('r') then
    vis = vis .. ' readonly'
  end

  if mode:match('f') then
    vis = 'final ' .. vis
  elseif mode:match('a') then
    vis = 'abstract ' .. vis
  end

  return vis
end

return M
