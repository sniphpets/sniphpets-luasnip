local sniphpets = require('sniphpets-luasnip')

local M = {}

function M.namespace()
  return sniphpets.path_to_namespace(
    sniphpets.filepath(),
    sniphpets.config.phpunit.namespace_prefix
  )
end

return M
