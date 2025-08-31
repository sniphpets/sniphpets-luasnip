local config = require('sniphpets-luasnip').config
local common = require('sniphpets-luasnip.common')
local conds_expand = require('luasnip.extras.conditions.expand')
local prefix = config.eloquent.prefix
local base = common.base
local namespace = common.namespace
local visual = common.visual
local file_header = common.file_header()

return {
  s(
    {
      trig = prefix .. 'model',
      name = 'Eloquent: Model',
      dscr = 'Eloquent: Model class',
    },
    fmt(file_header .. [[
namespace @#;

use Illuminate\Database\Eloquent\Model;

@# extends Model
{
    @#@#
}
    ]], { f(namespace), f(base), f(visual), i(0) }, { delimiters = '@#' }),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'fillable',
      name = 'Eloquent: $fillable',
      dscr = 'Eloquent: $fillable',
    },
    fmt(
      [[
 protected $fillable = [
     '@#',@#
 ];
  ]],
      { i(1), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'guarded',
      name = 'Eloquent: $guarded',
      dscr = 'Eloquent: $guarded',
    },
    fmt(
      [[
 protected $guarded = [
     '@#',@#
 ];
  ]],
      { i(1), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'defaults',
      name = 'Eloquent: $attributes',
      dscr = 'Eloquent: Default values',
    },
    fmt(
      [[
 protected $attributes = [
     '@#' => @#,@#
 ];
  ]],
      { i(1), i(2), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'casts',
      name = 'Eloquent: Casts',
      dscr = 'Eloquent: Casts',
    },
    fmt(
      [[
 protected function casts(): array
 {
     return [
         '@#' => '@#',@#
     ];
 }
  ]],
      { i(1), i(2), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'scope',
      name = 'Eloquent: Model scope',
      dscr = 'Eloquent: Model scope',
    },
    fmt(
      [[
 #[Scope]
 protected function @!(Builder $query@!): void
 {
    $query->@!@!
 }
  ]],
      { i(1), i(2), f(visual), i(3) },
      { delimiters = '@!' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'get',
      name = 'Eloquent: Accessor',
      dscr = 'Eloquent: Attribute accessor',
    },
    fmt(
      [[
 protected function @#(): Attribute
 {
    return Attribute::make(
        get: fn (mixed $value, array $attributes) => @#,
    );
 }
  ]],
      { i(1), i(2) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'set',
      name = 'Eloquent: Mutator',
      dscr = 'Eloquent: Attribute mutator',
    },
    fmt(
      [[
 protected function @#(): Attribute
 {
    return Attribute::make(
        set: fn (mixed $value, array $attributes) => @#,
    );
 }
  ]],
      { i(1), i(2) },
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
      { i(1), rep(2), i(2), i(3), i(4) },
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
      { i(1), rep(2), i(2), i(3), i(4) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'hasthrough',
      name = 'Eloquent: Model HasOneThrough/HasManyThrough',
      dscr = 'Eloquent: Model HasOneThrough/HasManyThrough relation',
    },
    fmt(
      [[
 public function @#(): Has@#Through
 {
    return $this->has@#Through(@#::class, @#::class);
 }
  ]],
      { i(1), rep(2), i(2), i(3), i(4) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'through',
      name = 'Eloquent: Model through()->has()',
      dscr = 'Eloquent: Model HasOneThrough/HasManyThrough relation',
    },
    fmt(
      [[
 public function @#(): Has@#Through
 {
    return $this->through('@#')->has('@#');
 }
  ]],
      { i(1), i(2), i(3), i(4) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'morph',
      name = 'Eloquent: Model morph',
      dscr = 'Eloquent: Model MorphOne/MorphMany relation',
    },
    fmt(
      [[
 public function @#(): Morph@#
 {
    return $this->morph@#(@#::class, '@#');
 }
  ]],
      { i(1), rep(2), i(2), i(3), i(4) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'col',
      name = 'Eloquent: $table->...',
      dscr = 'Eloquent: $table->...',
    },
    fmt(
      [[
 $table->@#('@#')@#;
  ]],
      { i(1), i(2), i(3) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'str',
      name = 'Eloquent: $table->string',
      dscr = 'Eloquent: $table->string',
    },
    fmt(
      [[
 $table->string('@#')@#;
  ]],
      { i(1), i(2) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'text',
      name = 'Eloquent: $table->text',
      dscr = 'Eloquent: $table->text',
    },
    fmt(
      [[
 $table->text('@#')@#;
  ]],
      { i(1), i(2) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'int',
      name = 'Eloquent: $table->integer',
      dscr = 'Eloquent: $table->integer',
    },
    fmt(
      [[
 $table->integer('@#')@#;
  ]],
      { i(1), i(2) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'foreign',
      name = 'Eloquent: $table->foreignId',
      dscr = 'Eloquent: $table->foreignId',
    },
    fmt(
      [[
 $table->foreignId('@#_id')->constrained()->cascadeOnDelete();
  ]],
      { i(1) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'schema',
      name = 'Eloquent: Schema::create()',
      dscr = 'Eloquent: Schema::create()',
    },
    fmt(
      [[
 Schema::@#('@#', function (Blueprint $table) {
    @#
 });
  ]],
      { i(1, 'create'), i(2), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),

  s(
    {
      trig = prefix .. 'state',
      name = 'Eloquent: factory state',
      dscr = 'Eloquent: factory state',
    },
    fmt(
      [[
 public function @#(): Factory
 {
     return $this->state(function (array $attributes) {
         return [
             @#,
         ];
     });
 }
  ]],
      { i(1), i(0) },
      { delimiters = '@#' }
    ),
    { condition = conds_expand.line_begin }
  ),
}
