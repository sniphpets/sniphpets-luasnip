local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')

local M = {}

function M.namespace()
  return common.path_to_namespace(common.filepath(), config.phpunit.namespace_prefix)
end

function M.sut()
  return common
    .fqn()
    :gsub(config.phpunit.test_suffix .. '$', '')
    :gsub('^' .. config.phpunit.namespace_prefix, config.namespace_prefix)
    :gsub('\\Unit\\', '\\')
end

return M
