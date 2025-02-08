SMODS.Joker {
  key = 'shiny_joker', --joker key
  loc_txt = {          -- local text
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
  atlas = 'Jokers',         --atlas' key
  rarity = 3,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 12,                --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 4, y = 2 },   --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      chips = 0,
      mult = 0,
      Xmult = 1.0
    }
  },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips, center.ability.extra.mult, center.ability.extra.Xmult } } --#1# is replaced with card.ability.extra.Xmult
  end,
  check_for_unlock = function(self, args)
    return true
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.P_CENTERS.c_wheel_of_fortune.config.extra = 4
  end,
  calculate = function(self, card, context)
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

      if edition_poll > 1 - 0.006 * 25 then
        card.ability.extra.Xmult = card.ability.extra.Xmult * 1.50
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.PURPLE,
          card = card
        }
      elseif edition_poll > 1 - 0.02 * 25 then
        card.ability.extra.mult = card.ability.extra.mult + 10
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          card = card
        }
      elseif edition_poll > 1 - 0.04 * 25 then
        card.ability.extra.chips = card.ability.extra.chips + 50
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.CHIPS,
          card = card
        }
      end
    end
  end,
  in_pool = function(self, args)
    --whether or not this card is in the pool, return true if it is, return false if its not
    return true
  end,
}
