local config = require('sniphpets-luasnip').config

local M = {}

--- Returns the base name of a current file, including its type (class, interface, etc.).
-- @return string The base name of the file.
function M.base()
  local basename = M.basename()
  local type = M.snippet_type(basename)

  if type == 'class' and config.final_classes then
    type = 'final class'
  end

  return type .. ' ' .. basename
end

--- Returns the base name of a current file, removing an extension and specified suffix.
-- @param suffix string The suffix to remove from the filename. Defaults to an empty string.
-- @return string The base name of the file.
function M.basename(suffix)
  local basename = vim.fn.expand('%:t:r')

  if suffix then
    basename = basename:gsub(suffix .. '$', '', 1)
  end

  return basename
end

--- Returns the filepath of the current file.
-- @return string The filepath of the current file.
function M.filepath()
  return vim.fn.expand('%:p')
end

--- Returns the fully qualified name of the current file.
-- @return string Fully qualified name of the current file.
function M.fqn()
  return M.path_to_fqn(M.filepath(), config.namespace_prefix)
end

function M.namespace()
  return M.path_to_namespace(M.filepath(), config.namespace_prefix)
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

--- Returns the type of a current file (class, interface, etc.).
-- @param basename string The base name of the file.
-- @return string The type of the file.
function M.snippet_type(basename)
  if basename:match('Interface$') then
    return 'interface'
  elseif basename:match('Trait$') then
    return 'trait'
  elseif basename:match('^Abstract') then
    return 'abstract class'
  end

  return 'class'
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

function M.visual(_, snip)
  local v = snip.env.LS_SELECT_RAW

  if #v > 0 then
    v[1] = v[1]:gsub('^%s+', '')
  end

  return v
end

--- Uppercase the first letter of a string.
function M.ucfirst(str)
  return str:gsub('^%l', string.upper)
end

return M
