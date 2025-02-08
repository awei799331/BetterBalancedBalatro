SMODS.Joker {
  key = "wild_tarot", --joker key
  loc_txt = {         -- local text
    name = "Wild Tarot",
    text = {
      "{C:green}#1# in #2#{} chance for each",
      "played {C:attention}Wild Card{} to create a",
      "{C:tarot}Tarot{} card when scored",
      "{C:inactive}(Must have room)",
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
  pos = { x = 2, y = 2 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      prob = 3
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = { G.GAME.probabilities.normal, center.ability.extra.prob } } --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        if (HasEnhancement(context.other_card, G.P_CENTERS.m_wild.effect)) and (pseudorandom(self.key) < G.GAME.probabilities.normal / card.ability.extra.prob) then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          return {
            extra = {
              message = localize('k_plus_tarot'),
              func = function()
                G.E_MANAGER:add_event(Event({
                  trigger = 'before',
                  delay = 0.0,
                  func = (function()
                    local tarot = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, self.key)
                    tarot:add_to_deck()
                    G.consumeables:emplace(tarot)
                    G.GAME.consumeable_buffer = 0
                    return true
                  end)
                }))
              end
            },
            colour = G.C.SECONDARY_SET.Tarot,
            card = card
          }
        end
      end
    end
  end,

  in_pool = function(self, args)
    return true
  end

}
