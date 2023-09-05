local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')
local phpunit = require('sniphpets-luasnip.phpunit')
local conds_expand = require('luasnip.extras.conditions.expand')
local prefix = config.phpunit.prefix
local base = common.base
local namespace = phpunit.namespace
local sut = phpunit.sut
local file_header = common.file_header()

return {
  s(
    {
      trig = prefix .. 'base',
      name = 'PHPUnit: Guess definition',
      dscr = 'PHPUnit: Class/Interface/Trait definition',
    },
    fmt(file_header .. [[
namespace @#;

@#
{
    @#
}
  ]], { f(namespace), f(base), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),

  s(
    { trig = prefix .. 'case', name = 'PHPUnit: Test case', dscr = 'PHPUnit: Test case' },
    fmt(file_header .. [[
namespace @#;

use PHPUnit\Framework\TestCase;
use @#;

@# extends TestCase
{
    @#
}
  ]], { f(namespace), f(sut), f(base), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),
}
