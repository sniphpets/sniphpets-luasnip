local sniphpets = require('sniphpets-luasnip')

describe('sniphpets-luasnip', function()
  describe('path_to_fqn()', function()
    local path_to_fqn = sniphpets.path_to_fqn

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
end)
