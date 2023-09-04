local M = {}

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
    test_suffix = 'Test',
  },
  doctrine = {
    enabled = false,
    prefix = 'dc',
  },
}

function M.create_config(opts)
  local config = vim.tbl_deep_extend('force', vim.deepcopy(defaults), opts or {})

  return setmetatable(config, {
    __newindex = function()
      error('Config is read only.')
    end,
  })
end

return M
