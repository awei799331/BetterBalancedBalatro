SMODS.Joker {
  key = "palindrome", --joker key
  loc_txt = {          -- local text
    name = "Palindrome",
    text = {
      "{X:mult,C:white}X#1#{} Mult if",
      "played hand contains a {C:attention}Two Pair{}",
      "and a pair of {C:attention}2's{}"
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
  pos = { x = 6, y = 4 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      xmult = 2.2
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.xmult } } --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.joker_main and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) then
      local two_count = 0
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i]:get_id() == 2 then
          two_count = two_count + 1
        end
      end
      if two_count >= 2 then
        return {
          xmult = card.ability.extra.xmult
        }
      end
    end
  end,

  in_pool = function(self, args)
    return true
  end

}
