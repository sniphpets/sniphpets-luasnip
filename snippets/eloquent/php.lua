local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')
local conds_expand = require('luasnip.extras.conditions.expand')
local prefix = config.eloquent.prefix
local visual = common.visual

return {
  s(
    { trig = prefix .. 'scope', name = 'Eloquent: Model scope', dscr = 'Eloquent: Model scope' },
    fmt(
      [[
 public function scope@#(Builder $query@#): void
 {
    $query->@#@#
 }
  ]],
      { i(1), i(2), f(visual), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),
  s(
    {
      trig = prefix .. 'has',
      name = 'Eloquent: Model HasOne/HasMany',
      dscr = 'Eloquent: Model HasOne/HasMany relation',
    },
    fmt(
      [[
 public function @#(): Has@#
 {
    return $this->has@#(@#::class@#);
 }
  ]],
      { i(1), rep(2), i(2), i(3), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),
  s(
    {
      trig = prefix .. 'belongs',
      name = 'Eloquent: Model BelongsTo/BelongsToMany',
      dscr = 'Eloquent: Model BelongsTo/BelongsToMany relation',
    },
    fmt(
      [[
 public function @#(): BelongsTo@#
 {
    return $this->belongsTo@#(@#::class@#);
 }
  ]],
      { i(1), rep(2), i(2), i(3), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),
}
