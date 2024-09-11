local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')

local M = {}

function M.extension_client(path)
  if path:find('/admin%w*/') then
    return 'administrator'
  end

  if path:find('/api/') then
    return 'api'
  end

  return 'site'
end

function M.extension_info(path)
  local client = M.extension_client(path)

  local pos, len = path:find('com_%w+')
  if pos then
    return {
      type = 'component',
      name = path:sub(pos + 4, len),
      client = client,
    }
  end

  pos, len = path:find('mod_%w+')
  if pos then
    return {
      type = 'module',
      name = path:sub(pos + 4, len),
      client = client,
    }
  end

  pos, len = path:find('plugins/%w+/%w+')
  if pos then
    local name, group = path:sub(pos + 8, len)
    group, name = name:match('(%w+)/(%w+)')
    return {
      type = 'plugin',
      group = group,
      name = name,
      client = client,
    }
  end

  return {
    type = 'component',
    name = 'MyComponent',
    client = client,
  }
end

function M.namespace()
  local filepath = common.filepath()
  local extinfo = M.extension_info(filepath)

  return config.namespace_prefix
    .. '\\'
    .. common.ucfirst(extinfo.type)
    .. '\\'
    .. common.ucfirst(extinfo.name)
    .. '\\'
    .. common.ucfirst(extinfo.client)
    .. '\\'
    .. common.path_to_namespace(filepath, '')
end

return M
