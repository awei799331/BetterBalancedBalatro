SMODS.Joker {
  key = "wild_retrigger", --joker key
  loc_txt = {             -- local text
    name = "Wild Retrigger",
    text = {
      "Retrigger all played",
      "{C:attention}Wild{} cards twice"
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
  pos = { x = 3, y = 2 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      triggers = 2
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.triggers } } --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.cardarea == G.play and HasEnhancement(context.other_card, G.P_CENTERS.m_wild.effect) and context.repetition then
      return {
        message = localize('k_again_ex'),
        repetitions = card.ability.extra.triggers,
        card = card
      }
    end
  end,

  in_pool = function(self, args)
    return true
  end

}
