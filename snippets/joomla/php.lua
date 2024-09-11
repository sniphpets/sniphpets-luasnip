local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')
local joomla = require('sniphpets-luasnip.joomla')
local conds_expand = require('luasnip.extras.conditions.expand')
local prefix = config.joomla.prefix
local base = common.base
local namespace = joomla.namespace
local file_header = common.file_header()

return {
  s(
    {
      trig = prefix .. 'controller',
      name = 'Joomla: Controller',
      dscr = 'Joomla: Controller class definition',
    },
    fmt(file_header .. [[
namespace @#;

\defined('_JEXEC') or die;

use Joomla\CMS\MVC\Controller\BaseController;

@# extends BaseController
{
    @#
}
  ]], { f(namespace), f(base), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'view',
      name = 'Joomla: View',
      dscr = 'Joomla: View class definition',
    },
    fmt(file_header .. [[
namespace @#;

\defined('_JEXEC') or die;

use Joomla\CMS\MVC\View\HtmlView as BaseHtmlView;

@# extends BaseHtmlView
{
    public function display($tpl = null): void
    {
        @#
    }
}
  ]], { f(namespace), f(base), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'modelitem',
      name = 'Joomla: Item model',
      dscr = 'Joomla: Item model class definition',
    },
    fmt(file_header .. [[
namespace @#;

\defined('_JEXEC') or die;

use Joomla\CMS\MVC\Model\ItemModel;

@# extends ItemModel
{
    public function getItem($pk = null): object
    {
        @#
    }
}
  ]], { f(namespace), f(base), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'modellist',
      name = 'Joomla: List model',
      dscr = 'Joomla: List model class definition',
    },
    fmt(file_header .. [[
namespace @#;

\defined('_JEXEC') or die;

use Joomla\CMS\MVC\Model\ListModel;
use Joomla\Database\DatabaseQuery;

@# extends ListModel
{
    protected function getListQuery(): DatabaseQuery|string
    {
        $query = $this->getDatabase()->getQuery(true);

        @#

        return $query;
    }
}
  ]], { f(namespace), f(base), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),
}
