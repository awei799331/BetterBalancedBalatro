SMODS.Joker {
  key = "moderation", --joker key
  loc_txt = {         -- local text
    name = "Moderation",
    text = {
      "{X:mult,C:white} X#1# {} Mult if you have",
      "between {C:attention}#2#{} and {C:attention}#3#{} Enhanced",
      "cards in your full deck",
      "{C:inactive}(Currently {C:attention}#4#{C:inactive})",
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 3,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 6,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 7, y = 1 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      xmult = 3.0,
      min = 6,
      max = 9,
      tally = 0
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.xmult, center.ability.extra.min, center.ability.extra.max, center.ability.extra.tally } }
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  update = function(self, card, dt)
    card.ability.extra.tally = 0
    if G.playing_cards == nil then
      return
    end
    for k, v in pairs(G.playing_cards) do
      if v.config.center ~= G.P_CENTERS.c_base then card.ability.extra.tally = card.ability.extra.tally + 1 end
    end
  end,

  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.tally >= card.ability.extra.min and card.ability.extra.tally <= card.ability.extra.max then
      return {
        xmult = card.ability.extra.xmult
      }
    end
  end,

  in_pool = function(self, args)
    return true
  end
}
