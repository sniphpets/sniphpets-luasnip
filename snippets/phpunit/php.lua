local sniphpets = require('sniphpets-luasnip')
local phpunit = require('sniphpets-luasnip.phpunit')
local prefix = sniphpets.config.phpunit.prefix
local basename = sniphpets.basename
local namespace = phpunit.namespace

return {
  s(
    prefix .. 'case',
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
