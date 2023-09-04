local config = require('sniphpets-luasnip').config()
local common = require('sniphpets-luasnip.common')
local phpunit = require('sniphpets-luasnip.phpunit')
local prefix = config.phpunit.prefix
local basename = common.basename
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
