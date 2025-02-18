local saved_create_card = create_card

function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  sendDebugMessage("type=" .. (_type or "nil"))
  if #SMODS.find_card('j_betterbalancedbalatro_totem') > 0 then
    if (_type == "Enhanced" or _type == "Base") and (area == G.shop_jokers or area == G.pack_cards) then
      sendDebugMessage("we are here")

      if _type == 'Base' then
        forced_key = 'c_base'
      end

      if forced_key and not G.GAME.banned_keys[forced_key] then
        center = G.P_CENTERS[forced_key]
        _type = (center.set ~= 'Default' and center.set or _type)
      else
        local _pool, _pool_key = get_current_pool(_type, _rarity, legendary, key_append)
        center = pseudorandom_element(_pool, pseudoseed(_pool_key))
        local it = 1
        while center == 'UNAVAILABLE' do
          it = it + 1
          center = pseudorandom_element(_pool, pseudoseed(_pool_key .. '_resample' .. it))
        end

        center = G.P_CENTERS[center]
      end

      local card = nil
      local front = nil

      if G.playing_cards ~= nil and #G.playing_cards > 0 then
        sendDebugMessage("picking card from deck...")
        local random_card = pseudorandom_element(G.playing_cards,
          pseudoseed('front' .. (key_append or '') .. G.GAME.round_resets.ante))
        if random_card == nil then
          sendDebugMessage("Random card is nil for some reason")
        end
        card = copy_card(random_card, nil, nil, G.playing_card)
      else
        front = ((_type == 'Base' or _type == 'Enhanced') and pseudorandom_element(G.P_CARDS, pseudoseed('front' .. (key_append or '') .. G.GAME.round_resets.ante))) or
            nil
      end

      if card == nil then
        card = Card(area.T.x + area.T.w / 2, area.T.y, G.CARD_W, G.CARD_H, front, center,
          {
            bypass_discovery_center = area == G.shop_jokers or area == G.pack_cards or area == G.shop_vouchers or
                (G.shop_demo and area == G.shop_demo) or area == G.jokers or area == G.consumeables,
            bypass_discovery_ui = area == G.shop_jokers or area == G.pack_cards or area == G.shop_vouchers or
                (G.shop_demo and area == G.shop_demo),
            discover = area == G.jokers or area == G.consumeables,
            bypass_back = G.GAME.selected_back.pos
          })
      end

      if card.ability.consumeable and not skip_materialize then card:start_materialize() end
      return card

      -- default behaviour when generating non playing card
    else
      return saved_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    end
  else
    return saved_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  end
end
