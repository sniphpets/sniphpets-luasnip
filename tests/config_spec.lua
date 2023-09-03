local config = require('sniphpets-luasnip.config')

describe('sniphpets-luasnip.config', function()
  describe('create_config()', function()
    local create_config = config.create_config

    it('creates configuration with default values', function()
      local opts = {
        strict_types = true,
        namespace_prefix = 'MyApp',
        common = {
          enabled = true,
        },
        phpunit = {
          enabled = true,
          prefix = 'p',
        },
      }

      local config = create_config(opts)

      -- Custom values
      assert.are.same(config.strict_types, true)
      assert.are.same(config.namespace_prefix, 'MyApp')
      assert.are.same(config.common.enabled, true)
      assert.are.same(config.phpunit.enabled, true)
      assert.are.same(config.phpunit.prefix, 'p')

      -- Default values
      assert.are.same(config.symfony.enabled, false)
      assert.are.same(config.symfony.prefix, 'sf')
      assert.are.same(config.doctrine.enabled, false)
      assert.are.same(config.doctrine.prefix, 'dc')
    end)
  end)
end)
