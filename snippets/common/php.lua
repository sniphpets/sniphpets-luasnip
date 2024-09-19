local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')
local conds_expand = require('luasnip.extras.conditions.expand')
local prefix = config.common.prefix
local base = common.base
local namespace = common.namespace
local method_visibility = common.method_visibility
local property_visibility = common.property_visibility
local visual = common.visual
local file_header = common.file_header()

return {
  s(
    {
      trig = prefix .. 'base',
      name = 'Guess definition',
      dscr = 'Class/Interface/Trait definition',
    },
    fmt(file_header .. [[
namespace @#;

@#
{
    @#@#
}
    ]], { f(namespace), f(base), f(visual), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),

  s(
    { trig = prefix .. 'class', name = 'Class definition', dscr = 'Class definition' },
    fmt(file_header .. [[
namespace @#;

@#
{
    @#@#
}
    ]], { f(namespace), f(base), f(visual), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),

  s(
    { trig = prefix .. 'mc', name = 'Constructor', dscr = 'Class constructor' },
    fmt(
      [[
 public function __construct(@#)
 {
     @#@#
 }
  ]],
      { i(1), f(visual), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    { trig = prefix .. 'mm', name = 'Magic method', dscr = 'Class magic method' },
    fmt(
      [[
 public function __@#(@#)
 {
     @#@#
 }
  ]],
      { i(1, 'toString'), i(2), f(visual), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'm([uoisaf]?[uoisaf]?)',
      hidden = true,
      regTrig = true,
      name = 'Method',
      dscr = [[Method

u: pUblic (default)
o: prOtected
i: prIvate

s: static
f: final
      ]],
    },
    fmt(
      [[
 @# function @#(@#): @#
 {
     @#@#
 }
  ]],
      { f(method_visibility), i(1), i(2), i(3, 'void'), f(visual), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'p([uoisr]?[uoisr]?)',
      hidden = true,
      regTrig = true,
      name = 'Property',
      dscr = [[Property

u: pUblic
o: prOtected
i: prIvate (default)

s: static
r: readonly
      ]],
    },
    fmt([[@# @# $@#]], { f(property_visibility), i(1, 'string'), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),
}
