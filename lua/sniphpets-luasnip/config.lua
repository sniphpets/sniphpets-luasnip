local M = {}

local defaults = {
  lazy = true,
  priority = 1000,
  file_header = '<?php\n\n',
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
  laravel = {
    enabled = false,
    prefix = 'la',
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
  eloquent = {
    enabled = false,
    prefix = 'el',
  },
  joomla = {
    enabled = false,
    prefix = 'jo',
  },
}

function M.create_config(opts)
  return vim.tbl_deep_extend('force', vim.deepcopy(defaults), opts or {})
end

return M
