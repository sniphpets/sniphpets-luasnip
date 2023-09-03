local sniphpets = require('sniphpets-luasnip')
local phpunit = require('sniphpets-luasnip.phpunit')
local basename = sniphpets.basename
local namespace = phpunit.namespace
local opts = sniphpets.opts.phpunit

return {
  s(
    opts.prefix .. 'case',
    fmt(
      [[
    <?php

    namespace @#;

    use PHPUnit\Framework\TestCase;

    class @# extends TestCase
    {
        @#
    }
    ]],
      { f(namespace), f(basename), i(0) },
      { delimiters = '@#' }
    )
  ),
}
