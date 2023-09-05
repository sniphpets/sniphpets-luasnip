local M = {}

local defaults = {
  namespace_prefix = 'App',
  strict_types = false,
  final_classes = false,
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
  return vim.tbl_deep_extend('force', vim.deepcopy(defaults), opts or {})
end

return M
