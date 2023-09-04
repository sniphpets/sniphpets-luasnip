local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')
local prefix = config.common.prefix
local basename = common.basename
local namespace = common.namespace
local file_header = common.file_header()

return {
  s(
    prefix .. 'class',
    fmt(file_header .. [[
namespace @#;

class @#
{
    @#
}
    ]], { f(namespace), f(basename), i(0) }, { delimiters = '@#' })
  ),
}
