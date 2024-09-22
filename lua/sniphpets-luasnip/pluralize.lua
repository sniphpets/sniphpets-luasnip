local pluralization_rules = {
  ['child'] = 'children',
  ['foot'] = 'feet',
  ['man'] = 'men',
  ['tooth'] = 'teeth',
  ['woman'] = 'women',
}

local function pluralize(word)
  if pluralization_rules[word] then
    return pluralization_rules[word]
  end

  if word:sub(#word, #word) == 's' then
    return word .. 'es'
  end

  return word .. 's'
end

return pluralize
