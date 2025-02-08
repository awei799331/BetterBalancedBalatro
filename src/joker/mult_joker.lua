SMODS.Joker {
  key = "mult_joker", --joker key
  loc_txt = {         -- local text
    name = "Mult Joker",
    text = {
      "{C:chips}+#1#{} Chips for every {C:attention}Mult Card{}",
      "in your {C:attention}full deck",
      "{C:inactive}(Currently {C:chips} +#2# {C:inactive} Chips)"
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 1,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 3,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 5, y = 1 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      chips = 30,
      mult_tally = 0
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips, center.ability.extra.mult_tally * center.ability.extra.chips } }
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  update = function(self, card, dt)
    card.ability.extra.mult_tally = 0
    if G.playing_cards == nil then
      return
    end
    for k, v in pairs(G.playing_cards) do
      if v.config.center == G.P_CENTERS.m_mult then card.ability.extra.mult_tally = card.ability.extra.mult_tally + 1 end
    end
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chips = card.ability.extra.mult_tally * card.ability.extra.chips
      }
    end
  end,

  in_pool = function(self, args)
    return true
  end
}
