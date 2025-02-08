SMODS.Joker {
  key = "selling_chips", --joker key
  loc_txt = {            -- local text
    name = "Selling Chips",
    text = {
      "Whenever a card is {C:attention}sold{},",
      "This Joker gains {C:chips}+#1#{} Chips",
      "for each dollar gained",
      "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 1,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 2,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = false, --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 1, y = 1 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      chip_mod = 6,
      chips = 0
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chip_mod, center.ability.extra.chips } } --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.selling_card then
      card.ability.extra.chips = card.ability.extra.chips + (context.card.sell_cost * card.ability.extra.chip_mod)
      return {
        message = localize('k_upgrade_ex'),
        colour = G.C.CHIPS
      }
    elseif context.joker_main then
      return {
        chips = card.ability.extra.chips
      }
    end
  end,

  in_pool = function(self, args)
    return true
  end

}
