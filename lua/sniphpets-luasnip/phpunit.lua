local config = require('sniphpets-luasnip').config()
local common = require('sniphpets-luasnip.common')

local M = {}

function M.namespace()
  return common.path_to_namespace(common.filepath(), config.phpunit.namespace_prefix)
end

return M
