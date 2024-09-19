local create_config = require('sniphpets-luasnip.config').create_config
local loaders = require('luasnip.loaders.from_lua')

local M = {}

M.config = create_config()

function M.setup(opts)
  M.config = create_config(opts)

  local snippets_path = M.root() .. '/snippets'

  local snippets = {
    'common',
    'phpunit',
    'symfony',
    'doctrine',
    'eloquent',
    'joomla',
  }

  for _, name in ipairs(snippets) do
    local config = M.config[name]

    if config.enabled or false then
      local loader_opts = {
        paths = snippets_path .. '/' .. name,
        default_priority = config.priority or M.config.priority or 1000,
      }

      if config.lazy or M.config.lazy or true then
        loaders.lazy_load(loader_opts)
      else
        loaders.load(loader_opts)
      end
    end
  end
end

function M.root()
  local path = debug.getinfo(1, 'S').source:sub(2)

  return vim.fn.fnamemodify(path, ':p:h:h:h')
end

return M
