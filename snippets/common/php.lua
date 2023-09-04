local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')
local conds_expand = require('luasnip.extras.conditions.expand')
local prefix = config.common.prefix
local basename = common.basename
local namespace = common.namespace
local file_header = common.file_header()

return {
  s(
    { trig = prefix .. 'class', name = 'Class definition', dscr = 'Class definition' },
    fmt(file_header .. [[
namespace @#;

class @#
{
    @#
}
    ]], { f(namespace), f(basename), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),
}
