SMODS.Joker {
  key = "climber", --joker key
  loc_txt = {      -- local text
    name = "Climber",
    text = {
      "This joker gains {C:chips}+#1#{} Chips",
      "if the played hand has a higher",
      "rank than the last hand",
      "Incompatible with modded hand types",
      "{C:inactive}(Last hand {C:attention}#3#{C:inactive})",
      "{C:inactive}(Currently: {C:chips}+#2#{C:inactive} Chips)"
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
  pos = { x = 4, y = 4 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      chip_mod = 5,
      chips = 0,
      last_hand_name = ""
    }
  },

  loc_vars = function(self, info_queue, center)
    local last_hand_name = "N/A"
    local hand = G.GAME.hands and G.GAME.hands[center.ability.extra.last_hand_name] or nil
    if hand ~= nil then
      last_hand_name = center.ability.extra.last_hand_name
    end
    return { vars = { center.ability.extra.chip_mod, center.ability.extra.chips, last_hand_name } } --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      local last_hand = card.ability.extra.last_hand_name and G.GAME.hands[card.ability.extra.last_hand_name] or nil
      local current_hand = G.GAME.hands[context.scoring_name]

      card.ability.extra.last_hand_name = context.scoring_name
      if last_hand == nil then return end
      if current_hand.order > 12 or current_hand.order < 1 or last_hand.order > 12 or last_hand.order < 1 then return end

      if current_hand.order < last_hand.order then
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.CHIPS,
          card = card
        }
      end
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
