SMODS.Joker {
  key = "diversity", --joker key
  loc_txt = {        -- local text
    name = "Diversity Specialist",
    text = {
      "The first scoring card of each ",
      "unique enhancement gains {C:white,X:mult}X#1#{}"
    },
    --[[unlock = {
          "Be {C:legendary}cool{}",
      }]]
  },
  atlas = "Jokers",         --atlas" key
  rarity = 3,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 10,                --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 4, y = 0 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      Xmult = 1.5,
    }
  },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.Xmult } } --#1# is replaced with card.ability.extra.Xmult
  end,
  check_for_unlock = function(self, args)
    return true
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local enhancement = GetEnhancement(context.other_card)
      if enhancement == nil then return end
      local first_enhanced = nil
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
  in_pool = function(self, args)
    --whether or not this card is in the pool, return true if it is, return false if its not
    return true
  end,
}
