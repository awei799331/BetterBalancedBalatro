SMODS.Joker {
  key = "skip_retrigger", --joker key
  loc_txt = {             -- local text
    name = "Skip Retrigger",
    text = {
      "When a {C:attention}Blind{} is skipped,",
      "Retrigger all cards played",
      "in the next {C:attention}selected Blind{}",
      "{C:inactive}(Skipped {C:attention}#1#{C:inactive})"
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 3,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 7,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 4, y = 3 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      triggers = 1,
      skipped = false
    }
  },

  loc_vars = function(self, info_queue, center)
    local string = Ternary(center.ability.extra.skipped == true, "Yes", "No")
    return { vars = { string } } --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.skip_blind and not context.blueprint then
      card.ability.extra.skipped = true
    elseif context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
      card.ability.extra.skipped = false
    elseif context.repetition and context.cardarea == G.play and card.ability.extra.skipped then
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
