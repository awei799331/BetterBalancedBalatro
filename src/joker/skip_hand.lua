SMODS.Joker {
  key = "skip_hand", --joker key
  loc_txt = {        -- local text
    name = "Skip Hand Size",
    text = {
      "When {C:attention}Small Blind{} is skipped,",
      "Gain {C:attention}+#1#{} hand size",
      "When {C:attention}Big Blind{} is skipped,",
      "Gain {C:attention}+#2#{} hand size",
      "{C:inactive}(Skipped {C:attention}#3#{C:inactive})"
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 2,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 5,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 3, y = 3 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      small = 1,
      big = 2,
      hand_size = 0
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.small, center.ability.extra.big, center.ability.extra.hand_size } } --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.skip_blind and not context.blueprint then
      if G.GAME.blind_on_deck == "Big" then
        card.ability.extra.hand_size = card.ability.extra.hand_size + card.ability.extra.small
      elseif G.GAME.blind_on_deck == "Boss" then
        card.ability.extra.hand_size = card.ability.extra.hand_size + card.ability.extra.big
      end
      return {
        message = "Skipped!",
        colour = G.C.IMPORTANT
      }
    elseif context.setting_blind and not self.getting_sliced and not context.blueprint then
      G.hand:change_size(card.ability.extra.hand_size)
      G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.hand_size
      return {
        message = "+" .. card.ability.extra.hand_size .. " Hand Size",
        colour = G.C.IMPORTANT
      }
    end
  end,

  in_pool = function(self, args)
    return true
  end
}
