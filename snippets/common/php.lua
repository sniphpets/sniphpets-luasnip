local sniphpets = require('sniphpets-luasnip')
local prefix = sniphpets.config.common.prefix
local basename = sniphpets.basename
local namespace = sniphpets.namespace

return {
  s(
    prefix .. 'class',
    fmt(
      [[
    <?php

    namespace @#;

    class @#
    {
        @#
    }
    ]],
      { f(namespace), f(basename), i(0) },
      { delimiters = '@#' }
    )
  ),
}
