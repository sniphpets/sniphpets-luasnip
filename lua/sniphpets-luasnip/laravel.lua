local common = require('sniphpets-luasnip.common')
local pluralize = require('sniphpets-luasnip.pluralize')

local M = {}

function M.controller_model()
  return common.basename('Controller')
end

function M.controller_model_var()
  return common.lcfirst(M.controller_model())
end

function M.controller_models_var()
  return pluralize(common.lcfirst(M.controller_model()))
end

function M.controller_model_view()
  return pluralize(common.lcfirst(M.controller_model()))
end

return M
