local phpunit = require('sniphpets-luasnip.phpunit')
local config = require('sniphpets-luasnip').config

describe('sniphpets-luasnip.phpunit', function()
  before_each(function()
    config.namespace_prefix = 'App'
    config.phpunit.namespace_prefix = 'App\\Tests'
    config.phpunit.test_suffix = 'Test'
  end)

  describe('namespace()', function()
    local namespace = phpunit.namespace

    local test_filepath = ''
    require('sniphpets-luasnip.common').filepath = function()
      return test_filepath
    end

    it([[returns test class namespace]], function()
      test_filepath = '/home/user/projects/symfony-demo/tests/Utils/ValidatorTest.php'
      assert.are.same('App\\Tests\\Utils', namespace())
    end)
  end)

  describe('sut()', function()
    local sut = phpunit.sut

    local test_fqn = ''
    require('sniphpets-luasnip.common').fqn = function()
      return test_fqn
    end

    it([[returns SUT's fully qualified name]], function()
      test_fqn = 'App\\Tests\\Utils\\ValidatorTest'
      assert.are.same('App\\Utils\\Validator', sut())

      test_fqn = 'Tests\\Utils\\ValidatorSpec'
      config.namespace_prefix = 'AppBundle'
      config.phpunit.namespace_prefix = 'Tests'
      config.phpunit.test_suffix = 'Spec'
      assert.are.same('AppBundle\\Utils\\Validator', sut())
    end)

    it([[removes "Unit" from SUT's fully qualified name]], function()
      test_fqn = 'App\\Tests\\Unit\\Utils\\ValidatorTest'

      assert.are.same('App\\Utils\\Validator', sut())
    end)
  end)
end)
