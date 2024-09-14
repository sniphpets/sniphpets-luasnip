local joomla = require('sniphpets-luasnip.joomla')

describe('sniphpets-luasnip.joomla', function()
  describe('extension_client()', function()
    it([[returns extension area: site, administrator, cli]], function()
      assert.are.same(
        'site',
        joomla.extension_client(
          '/home/user/projects/joomla/components/com_hello/src/Controller/DisplayController.php'
        )
      )
      assert.are.same(
        'site',
        joomla.extension_client(
          '/home/user/projects/joomla/site/src/Controller/DisplayController.php'
        )
      )

      assert.are.same(
        'administrator',
        joomla.extension_client(
          '/home/user/projects/joomla/administrator/components/com_hello/src/Controller/DisplayController.php'
        )
      )
      assert.are.same(
        'administrator',
        joomla.extension_client(
          '/home/user/projects/joomla/admin/src/Controller/DisplayController.php'
        )
      )

      assert.are.same(
        'api',
        joomla.extension_client(
          '/home/user/projects/joomla/api/components/com_hello/src/Controller/DisplayController.php'
        )
      )
    end)
  end)

  describe('extension_info()', function()
    it([[returns extension info: type, name, client]], function()
      local info = joomla.extension_info(
        '/home/user/projects/joomla/components/com_content/src/Controller/ArticleController.php'
      )
      assert.are.same('component', info.type)
      assert.are.same('content', info.name)

      info = joomla.extension_info(
        '/home/user/projects/joomla/administrator/modules/mod_menu/src/Menu/CssMenu.php'
      )
      assert.are.same('module', info.type)
      assert.are.same('menu', info.name)

      info = joomla.extension_info(
        '/home/user/projects/joomla/plugins/system/logout/src/Extension/Logout.php'
      )
      assert.are.same('plugin', info.type)
      assert.are.same('logout', info.name)
      assert.are.same('system', info.group)

      info = joomla.extension_info(
        '/home/user/projects/joomla/plg_system_logout/src/Extension/Logout.php'
      )
      assert.are.same('plugin', info.type)
      assert.are.same('logout', info.name)
      assert.are.same('system', info.group)

      info = joomla.extension_info('/home/user/projects/joomla/plg_logout/src/Extension/Logout.php')
      assert.are.same('plugin', info.type)
      assert.are.same('logout', info.name)
      assert.are.same('content', info.group)
    end)
  end)
end)
