local evaluate_hand_stored = evaluate_poker_hand


-- to find important code here look for big whitespace and comment


function evaluate_poker_hand(hand)
  if next(SMODS.find_card('j_betterbalancedbalatro_plumber')) then
    local results = {
      ["Flush Five"] = {},
      ["Flush House"] = {},
      ["Five of a Kind"] = {},
      ["Straight Flush"] = {},
      ["Four of a Kind"] = {},
      ["Full House"] = {},
      ["Flush"] = {},
      ["Straight"] = {},
      ["Three of a Kind"] = {},
      ["Two Pair"] = {},
      ["Pair"] = {},
      ["High Card"] = {},
      top = nil
    }

    for _, v in ipairs(SMODS.PokerHand.obj_buffer) do
      results[v] = {}
    end
    local parts = {
      _5 = get_X_same(5, hand),
      _4 = get_X_same(4, hand),
      _3 = get_X_same(3, hand),
      _2 = get_X_same(2, hand),
      _flush = get_flush(hand),
      _straight = get_straight(hand),
      _highest = get_highest(hand)
    }

    for _, _hand in pairs(SMODS.PokerHands) do
      if _hand.atomic_part and type(_hand.atomic_part) == 'function' then
        parts[_hand.key] = _hand.atomic_part(hand)
      end
    end
    if next(parts._5) and next(parts._flush) then
      results["Flush Five"] = parts._5
      if not results.top then results.top = results["Flush Five"] end
    end

    if next(parts._3) and next(parts._2) and next(parts._flush) then
      local fh_hand = {}
      local fh_3 = parts._3[1]
      local fh_2 = parts._2[1]
      for i = 1, #fh_3 do
        fh_hand[#fh_hand + 1] = fh_3[i]
      end
      for i = 1, #fh_2 do
        fh_hand[#fh_hand + 1] = fh_2[i]
      end
      table.insert(results["Flush House"], fh_hand)
      if not results.top then results.top = results["Flush House"] end
    end

    if next(parts._5) then
      results["Five of a Kind"] = parts._5
      if not results.top then results.top = results["Five of a Kind"] end
    end

    -- BBB MODIFIED: STRAIGHT FLUSH RESULT IS SET IN STRAIGHT CHECK
    -- if next(parts._flush) and next(parts._straight) then
    --   local _s, _f, ret = parts._straight, parts._flush, {}
    --   for _, v in ipairs(_f[1]) do
    --     ret[#ret + 1] = v
    --   end
    --   for _, v in ipairs(_s[1]) do
    --     local in_straight = nil
    --     for _, vv in ipairs(_f[1]) do
    --       if vv == v then in_straight = true end
    --     end
    --     if not in_straight then ret[#ret + 1] = v end
    --   end

    --   results["Straight Flush"] = parts._straight
    --   if not results.top then results.top = results["Straight Flush"] end
    -- end

    if next(parts._4) then
      results["Four of a Kind"] = parts._4
      if not results.top then results.top = results["Four of a Kind"] end
    end

    if next(parts._3) and next(parts._2) then
      local fh_hand = {}
      local fh_3 = parts._3[1]
      local fh_2 = parts._2[1]
      for i = 1, #fh_3 do
        fh_hand[#fh_hand + 1] = fh_3[i]
      end
      for i = 1, #fh_2 do
        fh_hand[#fh_hand + 1] = fh_2[i]
      end
      table.insert(results["Full House"], fh_hand)
      if not results.top then results.top = results["Full House"] end
    end

    if next(parts._flush) then
      results["Flush"] = parts._flush
      if not results.top then results.top = results["Flush"] end
    end

    if next(parts._straight) then
      results["Straight"] = parts._straight
      results["Straight Flush"] = parts._straight
      if not results.top then results.top = results["Straight Flush"] end
    end

    if next(parts._3) then
      results["Three of a Kind"] = parts._3
      if not results.top then results.top = results["Three of a Kind"] end
    end

    if (#parts._2 == 2) or (#parts._3 == 1 and #parts._2 == 1) then
      local fh_hand = {}
      local r = parts._2
      local fh_2a = r[1]
      local fh_2b = r[2]
      if not fh_2b then
        fh_2b = parts._3[1]
      end
      for i = 1, #fh_2a do
        fh_hand[#fh_hand + 1] = fh_2a[i]
      end
      for i = 1, #fh_2b do
        fh_hand[#fh_hand + 1] = fh_2b[i]
      end
      table.insert(results["Two Pair"], fh_hand)
      if not results.top then results.top = results["Two Pair"] end
    end

    if next(parts._2) then
      results["Pair"] = parts._2
      if not results.top then results.top = results["Pair"] end
    end

    if next(parts._highest) then
      results["High Card"] = parts._highest
      if not results.top then results.top = results["High Card"] end
    end

    if results["Five of a Kind"][1] then
      results["Four of a Kind"] = { results["Five of a Kind"][1], results["Five of a Kind"][2], results
          ["Five of a Kind"][3], results["Five of a Kind"][4] }
    end

    if results["Four of a Kind"][1] then
      results["Three of a Kind"] = { results["Four of a Kind"][1], results["Four of a Kind"][2], results
          ["Four of a Kind"][3] }
    end

    if results["Three of a Kind"][1] then
      results["Pair"] = { results["Three of a Kind"][1], results["Three of a Kind"][2] }
    end

    for _, _hand in pairs(SMODS.PokerHands) do
      if _hand.composite and type(_hand.composite) == 'function' then
        local other_hands
        results[_hand.key], other_hands = _hand.composite(parts)
        results[_hand.key] = results[_hand.key] or {}
        if other_hands and type(other_hands) == 'table' then
          for k, v in pairs(other_hands) do
            results[k] = v
          end
        end
      else
        results[_hand.key] = parts[_hand.key]
      end
    end
    results.top = nil
    for _, v in ipairs(G.handlist) do
      if not results.top and results[v] then
        results.top = results[v]
        break
      end
    end
    return results
  else
    return evaluate_hand_stored(hand)
  end
end
