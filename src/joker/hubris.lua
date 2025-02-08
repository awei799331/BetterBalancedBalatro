SMODS.Joker {
  key = "hubris", --joker key
  loc_txt = {     -- local text
    name = "Hubris",
    text = {
      "Lose all hands except 1.",
      "Gain {X:mult,C:white}X#1#{} Mult",
      "for each hand lost.",
      "Gain an additional {X:mult,C:white}X#1#{}",
      "if you own {C:attention}Vanity{}"
    },
    --[[unlock = {
          "Be {C:legendary}cool{}",
      }]]
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
  pos = { x = 6, y = 1 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      Xmult = 1.0,
      currentXmult = 1.0
    }
  },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.Xmult } }
  end,
  check_for_unlock = function(self, args)
    return true
  end,
  calculate = function(self, card, context)
    if context.setting_blind and not self.getting_sliced then
      card.ability.extra.currentXmult = 1.0
      local current_hands = G.GAME.current_round.hands_left
      local hands_to_cut = current_hands - 1
      card.ability.extra.currentXmult = card.ability.extra.currentXmult + hands_to_cut
      ease_hands_played(-hands_to_cut)
      return {
        message = "-" .. hands_to_cut .. " Hands",
        colour = G.C.IMPORTANT
      }
    elseif context.joker_main then
      if #SMODS.find_card('j_betterbalancedbalatro_vanity') >= 1 then
        card.ability.extra.currentXmult = card.ability.extra.currentXmult + 1
      end
      return {
        xmult = card.ability.extra.currentXmult
      }
    end
  end,
  in_pool = function(self, args)
    return true
  end,
}
