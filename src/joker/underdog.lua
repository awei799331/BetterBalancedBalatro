SMODS.Joker {
  key = "underdog", --joker key
  loc_txt = {          -- local text
    name = "Underdog",
    text = {
      "Gain {C:mult}+#1#{} Mult",
      "for each {C:attention}played card{}",
      "that isn't scored"
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
  pos = { x = 5, y = 4 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      mult_mod = 7
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.mult_mod } } --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    local unscored = 0
    if context.joker_main then
      if not next(find_joker('Splash')) then
        unscored = #context.full_hand - #context.scoring_hand
        return {
          mult = card.ability.extra.mult_mod * unscored
        }
      end
    end
  end,

  in_pool = function(self, args)
    return true
  end

}
