local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')
local joomla = require('sniphpets-luasnip.joomla')
local conds_expand = require('luasnip.extras.conditions.expand')
local prefix = config.joomla.prefix
local base = common.base
local namespace = joomla.namespace
local file_header = common.file_header()

local function table_alias()
  return common.basename():sub(1, 1):lower()
end

local function is_controller()
  return common.basename():sub(-10) == 'Controller'
end

local function get_app()
  if is_controller() then
    return '$this->app'
  end

  return 'Factory::getApplication()'
end

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
namespace @!;

\defined('_JEXEC') or die;

use Joomla\CMS\MVC\Model\ItemModel;
use Joomla\Database\ParameterType;

@! extends ItemModel
{
    public function getItem($pk = null): object
    {
        $pk = $pk ?? (int) $this->getState('item.id');

        $db = $this->getDatabase();
        $query = $db->createQuery();

        $query->select('*')
            ->from($db->quoteName('#__@!', '@!'))
            ->where($db->quoteName('@!.id') . ' = :pk')
            ->bind(':pk', $pk, ParameterType::INTEGER);

        $db->setQuery($query);

        $item = $db->loadObject();

        return $item;
    }
}
  ]], { f(namespace), f(base), i(0), f(table_alias), f(table_alias) }, { delimiters = '@!' }),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'modellist',
      name = 'Joomla: List model',
      dscr = 'Joomla: List model class definition',
    },
    fmt(file_header .. [[
namespace @!;

\defined('_JEXEC') or die;

use Joomla\CMS\MVC\Model\ListModel;
use Joomla\Database\DatabaseQuery;

@! extends ListModel
{
    protected function getListQuery(): DatabaseQuery|string
    {
        $db = $this->getDatabase();
        $query = $db->createQuery();

        $query->select('*')
            ->from($db->quoteName('#__@!', '@!'))
            ->where(@!);

        return $query;
    }
}
  ]], { f(namespace), f(base), i(1), f(table_alias), i(0) }, { delimiters = '@!' }),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'template',
      name = 'Joomla: PHP file',
      dscr = 'Joomla: PHP file with _JEXEC',
    },
    fmt(file_header .. [[
\defined('_JEXEC') or die;

use Joomla\CMS\HTML\HTMLHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Router\Route;

?>

@#
  ]], { i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'query',
      name = 'Joomla: Query',
      dscr = 'Joomla: SQL query',
    },
    fmt(
      [[
$db = $this->getDatabase();
$query = $db->createQuery();

$query->@#
  ]],
      { i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s({
    trig = prefix .. 'qv',
    name = 'Joomla: Quote value',
    dscr = 'Joomla: Quote value',
  }, fmt([[$db->quote('@#')@#]], { i(1), i(0) }, { delimiters = '@#' })),

  s({
    trig = prefix .. 'qn',
    name = 'Joomla: Quote name',
    dscr = 'Joomla: Quote name',
  }, fmt([[$db->quoteName('@#')@#]], { i(1), i(0) }, { delimiters = '@#' })),

  s({
    trig = prefix .. 'app',
    name = 'Joomla: Application',
    dscr = 'Joomla: Get application instance',
  }, f(get_app)),

  s({
    trig = prefix .. 'db',
    name = 'Joomla: Database',
    dscr = 'Joomla: Get database instance',
  }, t([[Factory::getContainer()->get(DatabaseInterface::class)]])),

  s({
    trig = prefix .. 'get',
    name = 'Joomla: Service',
    dscr = 'Joomla: Get service instance',
  }, fmt([[Factory::getContainer()->get(@#::class)@#]], { i(1), i(0) }, { delimiters = '@#' })),

  s({
    trig = prefix .. 'route',
    name = 'Joomla: Route',
    dscr = 'Joomla: Generate route URL',
  }, fmt([[Route::_('index.php?option=com_@#')@#]], { i(1), i(0) }, { delimiters = '@#' })),
}
