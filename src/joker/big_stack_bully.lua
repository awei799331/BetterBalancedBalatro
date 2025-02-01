SMODS.Joker {
  key = "big_stack_bully", --joker key
  loc_txt = {              -- local text
    name = "Big Stack Bully",
    text = {
      "Gains {C:chips}+#2#{} Chips",
      "if played hand",
      "is a {C:attention}Straight Flush{}",
      "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 1,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 5,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 7, y = 1 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      chips = 0,
      chip_mod = 100
    }
  },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips, center.ability.extra.chip_mod } }
  end,
  check_for_unlock = function(self, args)
    return true
  end,
  calculate = function(self, card, context)
    if context.before and not context.blueprint and next(context.poker_hands["Straight Flush"]) then
      card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
      return {
        message = localize('k_upgrade_ex'),
        colour = G.C.CHIPS,
        card = card
      }
    end
    if context.joker_main then
      return {
        chips = card.ability.extra.chips
      }
    end
  end,
  in_pool = function(self, args)
    return true
  end,
}
