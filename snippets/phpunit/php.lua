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
    {
      trig = prefix .. 'case',
      name = 'PHPUnit: Test case',
      dscr = 'PHPUnit: Test case',
    },
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

  s(
    {
      trig = prefix .. 'test',
      name = 'PHPUnit: Test method',
      dscr = 'PHPUnit: Test method',
    },
    fmt(
      [[
public function test@#(): void
{
    @#
}
  ]],
      { i(1), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'a',
      name = 'PHPUnit: Assert',
      dscr = 'PHPUnit: Assert',
    },
    fmt(
      [[
$this->assert@#(@#);
  ]],
      { i(1), i(2) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'eq',
      name = 'PHPUnit: Assert equals',
      dscr = 'PHPUnit: Assert equals',
    },
    fmt(
      [[
$this->assertEquals(@#, @#);
  ]],
      { i(1), i(2) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'same',
      name = 'PHPUnit: Assert same',
      dscr = 'PHPUnit: Assert same',
    },
    fmt(
      [[
$this->assertSame(@#, @#);
  ]],
      { i(1), i(2) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'exception',
      name = 'PHPUnit: Expect exception',
      dscr = 'PHPUnit: Expect exception',
    },
    fmt(
      [[
$this->expectException(@#::class);
$this->expectExceptionMessage('@#');
    ]],
      { i(1), i(2) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'pro',
      name = 'PHPUnit: Prophesize',
      dscr = 'PHPUnit: Prophesize',
    },
    fmt(
      [[
$@# = $this->prophesize(@#::class);
    ]],
      { i(1), i(2) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'mock',
      name = 'PHPUnit: Mock',
      dscr = 'PHPUnit: Mock',
    },
    fmt(
      [[
$@# = $this->createMock(@#::class);
    ]],
      { i(1), i(2) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'stub',
      name = 'PHPUnit: Stub',
      dscr = 'PHPUnit: Stub',
    },
    fmt(
      [[
$@# = $this->createStub(@#::class);
$@#->method('@#')
    ->willReturn(@#);
    ]],
      { i(1), i(2), rep(1), i(3), i(4) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'fake',
      name = 'PHPUnit: Fake',
      dscr = 'PHPUnit: Fake',
    },
    fmt(
      [[
$@# = $this->createStub(@#::class);
$@#->method('@#')
    ->willReturnCallback(
        function(@#) {
            @#
        }
    );
    ]],
      { i(1), i(2), rep(1), i(3), i(4), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'expects',
      name = 'PHPUnit: Expects',
      dscr = 'PHPUnit: Expects',
    },
    fmt(
      [[
$@#->expects($this->@#())
    ->method('@#');
    ]],
      { i(1), i(2, 'once'), i(3) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),
}
