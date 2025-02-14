local saved_create_card = create_card

function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  if next(SMODS.find_card('j_betterbalancedbalatro_totem')) then
    -- asdfasdfasfd
  else
    return saved_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  end
end
