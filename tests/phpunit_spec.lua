local phpunit = require('sniphpets-luasnip.phpunit')

describe('sniphpets-luasnip.phpunit', function()
  describe('sut()', function()
    local sut = phpunit.sut

    local test_fqn = ''
    require('sniphpets-luasnip.common').fqn = function()
      return test_fqn
    end

    it("returns SUT's fully qualified name", function()
      test_fqn = 'App\\Tests\\Utils\\ValidatorTest'

      assert.are.same('App\\Utils\\Validator', sut())
    end)

    it('removes "Unit" from SUT\'s fully qualified name', function()
      test_fqn = 'App\\Tests\\Unit\\Utils\\ValidatorTest'

      assert.are.same('App\\Utils\\Validator', sut())
    end)
  end)
end)
