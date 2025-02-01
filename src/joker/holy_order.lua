SMODS.Joker {
  key = "holy_order", --joker key
  loc_txt = {         -- local text
    name = "Holy Order",
    text = {
      "This Joker gains {C:white,X:mult}X#2#{}",
      "if played hand",
      "is a {C:attention}Straight Flush{}",
      "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)"
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 2,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
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
      xmult = 1.0,
      xmult_mod = 0.4
    }
  },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.xmult, center.ability.extra.xmult_mod } }
  end,
  check_for_unlock = function(self, args)
    return true
  end,
  calculate = function(self, card, context)
    if context.before and not context.blueprint and next(context.poker_hands["Straight Flush"]) then
      card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
      return {
        message = localize('k_upgrade_ex'),
        colour = G.C.MULT,
        card = card
      }
    end
    if context.joker_main then
      return {
        xmult = card.ability.extra.xmult
      }
    end
  end,
  in_pool = function(self, args)
    return true
  end,
}
