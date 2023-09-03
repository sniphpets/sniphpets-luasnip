local sniphpets = require('sniphpets-luasnip')
local basename = sniphpets.basename
local namespace = sniphpets.namespace
local opts = sniphpets.opts.common

return {
  s(
    opts.prefix .. 'class',
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
