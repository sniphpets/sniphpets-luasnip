local common = require('sniphpets-luasnip.common')
local config = require('sniphpets-luasnip').config

describe('sniphpets-luasnip', function()
  before_each(function()
    config.file_header = '<?php\n\n'
    config.strict_types = false
    config.final_classes = false
  end)

  describe('path_to_fqn()', function()
    local path_to_fqn = common.path_to_fqn

    it('returns namespace prefix when fails', function()
      assert.are.same('App', path_to_fqn('/home/user/projects/my-app/classes/app.php', 'App'))
      assert.are.same('', path_to_fqn('/home/user/projects/my-app/classes/app.php', ''))
    end)

    it('returns a proper FQN for Unix-like paths', function()
      assert.are.same(
        'App\\Entity\\User',
        path_to_fqn('/home/user/workspace/my-app/src/Entity/User.php', 'App')
      )
      assert.are.same(
        'App\\Entity\\User',
        path_to_fqn('/home/user/workspace/MyApp/src/Entity/User.php', 'App')
      )
      assert.are.same(
        'MyApp\\HelloController',
        path_to_fqn(
          '/home/user/workspace/MyApp/src/folder one/controllers/HelloController.php',
          'MyApp'
        )
      )
    end)
  end)

  describe('base()', function()
    local base = common.base

    local basename = ''
    common.basename = function()
      return basename
    end

    it('returns file type', function()
      basename = 'User'
      assert.are.same('class User', base())
    end)

    it('makes class final if needed', function()
      config.final_classes = true
      basename = 'User'
      assert.are.same('final class User', base())
    end)

    it('never makes abstract class final', function()
      config.final_classes = true
      basename = 'AbstractUser'
      assert.are.same('abstract class AbstractUser', base())
    end)
  end)

  describe('snippet_type()', function()
    local snippet_type = common.snippet_type

    it('detects classes', function()
      assert.are.same('class', snippet_type('User'))
    end)

    it('detects abstract classes', function()
      assert.are.same('abstract class', snippet_type('AbstractUser'))
    end)

    it('detects interfaces', function()
      assert.are.same('interface', snippet_type('UserInterface'))
    end)

    it('detects traits', function()
      assert.are.same('trait', snippet_type('UserTrait'))
    end)
  end)

  describe('file_header()', function()
    local file_header = common.file_header

    it('returns file header by default', function()
      assert.are.same('<?php\n\n', file_header())
    end)

    it('allows to set custom file header', function()
      config.file_header = '<?php // Custom header\n\n'
      assert.are.same('<?php // Custom header\n\n', file_header())
    end)

    it('enables strict types', function()
      config.strict_types = true
      assert.are.same('<?php\n\ndeclare(strict_types=1);\n\n', file_header())
    end)
  end)

  describe('ucfirst()', function()
    local ucfirst = common.ucfirst

    it('returns a capitalized first character', function()
      assert.are.same('User', ucfirst('user'))
      assert.are.same('User', ucfirst('User'))
      assert.are.same('', ucfirst(''))
    end)
  end)
end)
