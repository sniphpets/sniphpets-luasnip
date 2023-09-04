local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')
local phpunit = require('sniphpets-luasnip.phpunit')
local conds_expand = require('luasnip.extras.conditions.expand')
local prefix = config.phpunit.prefix
local basename = common.basename
local namespace = phpunit.namespace
local sut = phpunit.sut
local file_header = common.file_header()

return {
  s(
    { trig = prefix .. 'case', name = 'PHPUnit: test case', dscr = 'PHPUnit: test case' },
    fmt(file_header .. [[
namespace @#;

use PHPUnit\Framework\TestCase;
use @#;

class @# extends TestCase
{
    @#
}
  ]], { f(namespace), f(sut), f(basename), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),
}
