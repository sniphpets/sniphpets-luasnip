local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')
local laravel = require('sniphpets-luasnip.laravel')
local conds_expand = require('luasnip.extras.conditions.expand')
local prefix = config.laravel.prefix
local namespace = common.namespace
local base = common.base
local model = laravel.controller_model
local model_var = laravel.controller_model_var
local models_var = laravel.controller_models_var
local model_view = laravel.controller_model_view
local visual = common.visual
local file_header = common.file_header()

return {
  s(
    {
      trig = prefix .. 'controller',
      name = 'Laravel: Controller',
      dscr = 'Laravel: Controller class',
    },
    fmt(file_header .. [[
namespace @#;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\View\View;

@# extends Controller
{
    @#@#
}
    ]], { f(namespace), f(base), f(visual), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'index',
      name = 'Laravel: Controller index',
      dscr = 'Laravel: Controller index',
    },
    fmt(
      [[
public function index(): View
{
    $@# = @#::findAll($id);@#

    return view('@#.show', [
        '@#' => $@#,
    ]);
}
    ]],
      { f(models_var), f(model), i(0), f(model_view), f(models_var), f(models_var) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'show',
      name = 'Laravel: Controller show',
      dscr = 'Laravel: Controller show',
    },
    fmt(
      [[
public function show(int $id): View
{
    $@# = @#::findOrFail($id);@#

    return view('@#.show', [
        '@#' => $@#,
    ]);
}
    ]],
      { f(model_var), f(model), i(0), f(model_view), f(model_var), f(model_var) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),
}
