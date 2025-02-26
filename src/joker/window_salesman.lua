SMODS.Joker {
  key = "window_salesman", --joker key
  loc_txt = {              -- local text
    name = "Window Salesman",
    text = {
      "Glass can't break.",
      "Played {C:attention}Glass{} cards give",
      "{C:gold}$#1#{} when scored"
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 3,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 8,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 7, y = 3 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      money = 1
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.money } } --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.individual then
      if context.cardarea == G.play and HasEnhancement(context.other_card, G.P_CENTERS.m_glass.effect) then
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
        G.E_MANAGER:add_event(Event({ func = (function()
          G.GAME.dollar_buffer = 0; return true
        end) }))
        return {
          dollars = card.ability.extra.money,
          card = card
        }
      end
    end
  end,

  in_pool = function(self, args)
    return true
  end

}
