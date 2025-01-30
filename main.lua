--- STEAMODDED HEADER
--- MOD_NAME: BBB
--- MOD_ID: BetterBalancedBalatro
--- MOD_AUTHOR: [108_Pho, Akrone]
--- MOD_DESCRIPTION: Additional archetype support for enhanced cards, and hand types
--- PREFIX: bbb
----------------------------------------------
------------MOD CODE -------------------------

function contains(array, str)
  for _, value in ipairs(array) do
      if value == str then
          return true
      end
  end
  return false
end

SMODS.Atlas{
  key = 'Jokers', --atlas key
  path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
  px = 71, --width of one card
  py = 95 -- height of one card
}

SMODS.Joker{
  key = 'shiny_joker', --joker key
  loc_txt = { -- local text
      name = 'Shiny Joker',
      text = {
        '{C:purple}Wheel of Fortune{} has 100% chance of success',
        'but only adds editions to Shiny Joker.',
        'Editions can stack on Shiny Joker.',
        'Currently {C:blue}+#1#{} Chips,',
        '{C:red}+#2#{} Mult,',
        '{X:mult,C:white}X#3#{}'
      },
      --[[unlock = {
          'Be {C:legendary}cool{}',
      }]]
  },
  atlas = 'Jokers', --atlas' key
  rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 12, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = true, --whether or not it starts discovered
  blueprint_compat = true, --can it be blueprinted/brainstormed/other
  eternal_compat = true, --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { 
    extra = {
      chips = 0,
      mult = 0,
      Xmult = 1.0
    }
  },
  loc_vars = function(self,info_queue,center)
      return {vars = {center.ability.extra.chips, center.ability.extra.mult, center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
  end,
  check_for_unlock = function(self, args)
      return true
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.P_CENTERS.c_wheel_of_fortune.config.extra = 4
  end,
  calculate = function(self,card,context)
    sendDebugMessage("Ran calculate", "Shiny Joker")
    G.P_CENTERS.c_wheel_of_fortune.config.extra = 2000000000

    if context.joker_main then
      return {
        card = card,
        message = localize('k_nope_ex'),
        colour = G.C.PURPLE,
        chips = card.ability.extra.chips,
        mult = card.ability.extra.mult,
        xmult = card.ability.extra.Xmult
      }
    end

    if context.using_consumeable and context.consumeable.ability.name == 'The Wheel of Fortune' then
      sendDebugMessage("Wheel", "Shiny Joker")
      local edition_poll = pseudorandom(pseudoseed("Shiny Joker"))
  
      if edition_poll > 1 - 0.006*25 then
        card.ability.extra.Xmult = card.ability.extra.Xmult * 1.50
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.PURPLE,
          card = card
        }
      elseif edition_poll > 1 - 0.02*25 then
        card.ability.extra.mult = card.ability.extra.mult + 10
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          card = card
        }
      elseif edition_poll > 1 - 0.04*25 then
        card.ability.extra.chips = card.ability.extra.chips + 50
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.CHIPS,
          card = card
        }
      end
    end
  end,
  in_pool = function(self,args)
      --whether or not this card is in the pool, return true if it is, return false if its not
      return true
  end,
}

SMODS.Joker{
  key = 'robespierre_joker', --joker key
  loc_txt = { -- local text
      name = 'Robespierre',
      text = {
        'If first hand of round is a',
        'single face card, destroy it, and',
        'earn {C:gold}$5{}.'
      },
      --[[unlock = {
          'Be {C:legendary}cool{}',
      }]]
  },
  atlas = 'Jokers', --atlas' key
  rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 8, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = true, --whether or not it starts discovered
  blueprint_compat = false, --can it be blueprinted/brainstormed/other
  eternal_compat = false, --can it be eternal
  perishable_compat = false, --can it be perishable
  pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { 
    extra = {
      dollars = 10
    }
  },
  check_for_unlock = function(self, args)
      return true
  end,
  
  calculate = function(self,card,context)
    if context.cardarea == G.jokers and context.before then
      if #context.full_hand == 1 and (context.full_hand[1]:get_id() == 11 or context.full_hand[1]:get_id() == 12 or context.full_hand[1]:get_id() == 13) and G.GAME.current_round.hands_played == 0 then
        ease_dollars(5, true)
        return {
          message = '$5',
          colour = G.C.GOLD
        }
      end
    end
    if context.destroy_card and context.cardarea == G.play then
      sendDebugMessage('ya mum', 'robes')
      if #context.full_hand == 1 and (context.full_hand[1]:get_id() == 11 or context.full_hand[1]:get_id() == 12 or context.full_hand[1]:get_id() == 13) and G.GAME.current_round.hands_played == 0 then
        return {
         remove = true
        }
      end
    end
  end,

  in_pool = function(self,args)
      --whether or not this card is in the pool, return true if it is, return false if its not
      return true
  end,
}

SMODS.Joker{
  key = 'fried_egg', --joker key
  loc_txt = { -- local text
      name = 'Fried Egg',
      text = {
        'After three rounds, this egg hatches and ',
        'Golden Goose may appear in the shop',
        'Played rounds: {C:blue}#1#{}'
      },
      --[[unlock = {
          'Be {C:legendary}cool{}',
      }]]
  },
  atlas = 'Jokers', --atlas' key
  rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 1, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = true, --whether or not it starts discovered
  blueprint_compat = false, --can it be blueprinted/brainstormed/other
  eternal_compat = false, --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = {x = 2, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      hatch_time = 3,
      played_rounds = 0
    }
  },
  loc_vars = function(self,info_queue,center)
    return {vars = {center.ability.extra.played_rounds}} --#1# is replaced with card.ability.extra.Xmult
  end,
  check_for_unlock = function(self, args)
      return true
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if G.GAME.pool_flags.fried_egg_hatched == nil then
      G.GAME.pool_flags.fried_egg_hatched = false
    end
  end,
  calculate = function(self,card,context)
    if context.end_of_round and context.cardarea == G.jokers then
      sendDebugMessage("Ran calculate", "Fried Egg")
      card.ability.extra.played_rounds = card.ability.extra.played_rounds + 1
      if card.ability.extra.played_rounds >= card.ability.extra.hatch_time then
        G.GAME.pool_flags.fried_egg_hatched = true
        card:remove()
        return
      end
    end
  end,
  in_pool = function(self,args)
      --whether or not this card is in the pool, return true if it is, return false if its not
      return G.GAME.pool_flags.fried_egg_hatched == false
  end,
}

SMODS.Joker{
  key = 'golden_goose', --joker key
  loc_txt = { -- local text
      name = 'Golden Goose',
      text = {
        'Sells for {C:gold}$#1#{}'
      },
      --[[unlock = {
          'Be {C:legendary}cool{}',
      }]]
  },
  atlas = 'Jokers', --atlas' key
  rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 1, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = false, --whether or not it starts discovered
  blueprint_compat = false, --can it be blueprinted/brainstormed/other
  eternal_compat = false, --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = {x = 3, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      bonus_value = 24
    }
  },
  set_ability = function(self, card, initial, delay_sprites)
    if G.GAME.pool_flags.fried_egg_hatched == nil then
      G.GAME.pool_flags.fried_egg_hatched = false
    end
    card.ability.extra_value = card.ability.extra.bonus_value
    card:set_cost()
  end,
  loc_vars = function(self,info_queue,center)
    return {vars = {center.ability.extra.bonus_value + 1}} --#1# is replaced with card.ability.extra.Xmult
  end,
  check_for_unlock = function(self, args)
    return G.GAME.pool_flags.fried_egg_hatched == true
  end,
  calculate = function(self,card,context)
  end,
  in_pool = function(self,args)
    --whether or not this card is in the pool, return true if it is, return false if its not
    return G.GAME.pool_flags.fried_egg_hatched == true
  end,
}

SMODS.Joker{
  key = 'diversity', --joker key
  loc_txt = { -- local text
      name = 'Diversity Specialist',
      text = {
        'The first scoring card of each ',
        'unique enhancement gains {C:red}X#1#{}'
      },
      --[[unlock = {
          'Be {C:legendary}cool{}',
      }]]
  },
  atlas = 'Jokers', --atlas' key
  rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 10, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = true, --whether or not it starts discovered
  blueprint_compat = true, --can it be blueprinted/brainstormed/other
  eternal_compat = true, --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = {x = 4, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      Xmult = 1.5,
    }
  },
  loc_vars = function(self,info_queue,center)
      return {vars = {center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
  end,
  check_for_unlock = function(self, args)
      return true
  end,
  calculate = function(self,card,context)
    if context.individual and context.cardarea == G.play then
      sendDebugMessage("Ran calculate", "Diversity Specialist")

      local first_enhanced = nil
      local enhancement = context.other_card.ability.effect

      local found_enhancement = false
      local enhancements_map = get_current_pool("Enhanced")
      for i, k in pairs(enhancements_map) do
        if G.P_CENTERS[k].effect == enhancement then
          found_enhancement = true
          break
        end
      end

      if not found_enhancement then return end

      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i].ability.effect == enhancement then
          first_enhanced = context.scoring_hand[i]
          break
        end
      end

      if first_enhanced ~= nil and first_enhanced == context.other_card then
        return {
          x_mult = self.config.extra.Xmult,
          card = context.other_card
        }
      end
    end
  end,
  in_pool = function(self,args)
      --whether or not this card is in the pool, return true if it is, return false if its not
      return true
  end,
}

SMODS.Joker{
  key = 'procrastinator', --joker key
  loc_txt = { -- local text
      name = 'Procrastinator',
      text = {
        '{X:mult,C:white}X#1#{} Mult',
        'When {C:attention}Small Blind{} or',
        '{C:attention}Big Blind{} is selected,',
        'lose {X:mult,C:white}X#2#{} Mult',
      },
      --[[unlock = {
          'Be {C:legendary}cool{}',
      }]]
  },
  atlas = 'Jokers', --atlas' key
  rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 6, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = true, --whether or not it starts discovered
  blueprint_compat = true, --can it be blueprinted/brainstormed/other
  eternal_compat = true, --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = {x = 5, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { 
    extra = {
      Xmult = 4.0,
      minus = 0.5
    }
  },
  loc_vars = function(self,info_queue,center)
    return {vars = {center.ability.extra.Xmult, center.ability.extra.minus}} --#1# is replaced with card.ability.extra.Xmult
  end,
  check_for_unlock = function(self, args)
    return true
  end,
  calculate = function(self,card,context)
    if context.joker_main then
      return {
        card = card,
        xmult = card.ability.extra.Xmult,
        -- message = "X"..card.ability.extra.Xmult,
        colour = G.C.MULT,
      }
    elseif context.setting_blind and G.GAME.blind:get_type() ~= 'Boss' then
      card.ability.extra.Xmult = math.max(1.0, card.ability.extra.Xmult - card.ability.extra.minus)
      return {
        card = card,
        message = "-"..card.ability.extra.minus,
        colour = G.C.RED
      }
    end
  end,
  in_pool = function(self,args)
    --whether or not this card is in the pool, return true if it is, return false if its not
    return G.GAME.round_resets.ante <= 4
  end,
}

SMODS.Joker{
  key = 'tour_guide', --joker key
  loc_txt = { -- local text
      name = 'Tour Guide',
      text = {
        'Sell this joker after skipping 3 blinds for',
        '{C:attention}-1{} Ante'
      },
      --[[unlock = {
          'Be {C:legendary}cool{}',
      }]]
  },
  atlas = 'Jokers', --atlas' key
  rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 6, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = true, --whether or not it starts discovered
  blueprint_compat = true, --can it be blueprinted/brainstormed/other
  eternal_compat = true, --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = {x = 5, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { 
    extra = {
      skipped_blinds = 0,

    }
  },
  loc_vars = function(self,info_queue,center)
    return {vars = {center.ability.extra.Xmult, center.ability.extra.minus}} --#1# is replaced with card.ability.extra.Xmult
  end,
  check_for_unlock = function(self, args)
    return true
  end,
  calculate = function(self,card,context)
    if context.joker_main then
      return {
        card = card,
        xmult = card.ability.extra.Xmult,
        -- message = "X"..card.ability.extra.Xmult,
        colour = G.C.MULT,
      }
    elseif context.setting_blind and G.GAME.blind:get_type() ~= 'Boss' then
      card.ability.extra.Xmult = math.max(1.0, card.ability.extra.Xmult - card.ability.extra.minus)
      return {
        card = card,
        message = "-"..card.ability.extra.minus,
        colour = G.C.RED
      }
    end
  end,
  in_pool = function(self,args)
    --whether or not this card is in the pool, return true if it is, return false if its not
    return G.GAME.round_resets.ante <= 4
  end,
}

-- this is a test
SMODS.Joker{
  key = 'emme_joker', --joker key
  loc_txt = { -- local text
      name = 'Emme',
      text = {
        '{C:attention}Lucky{} cards always',
        'Trigger {C:red}+Mult{}'
      },
      --[[unlock = {
          'Be {C:legendary}cool{}',
      }]]
  },
  atlas = 'Jokers', --atlas' key
  rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 20, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = true, --whether or not it starts discovered
  blueprint_compat = true, --can it be blueprinted/brainstormed/other
  eternal_compat = false, --can it be eternal
  perishable_compat = false, --can it be perishable
  pos = {x = 5, y = 5}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {},
  check_for_unlock = function(self, args)
      return true
  end,

  in_pool = function(self,args)
      --whether or not this card is in the pool, return true if it is, return false if its not
      return false
  end,
}

----------------------------------------------
------------MOD CODE END----------------------
