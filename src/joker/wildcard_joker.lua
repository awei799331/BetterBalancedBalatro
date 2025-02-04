SMODS.Joker {
  key = "wildcard_joker", --joker key
  loc_txt = {             -- local text
    name = "Wildcard Joker",
    text = {
      "Creates {C:tarot}The Lovers{}",
      "at the end of the {C:attention}shop",
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 1,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 3,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 4, y = 4 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
    }
  },

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.ending_shop then
      if not (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
        return
      end
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = (function()
          G.E_MANAGER:add_event(Event({
            func = function()
              local lovers = SMODS.add_card({
                type = "Tarot",
                area = G.consumeables,
                legendary = nil,
                rarity = nil,
                skip_materialize = nil,
                soulable = nil,
                key =
                    G.P_CENTERS.c_lovers.key,
                key_append = "wildcard_joker"
              })
              G.GAME.consumeable_buffer = 0
              return true
            end
          }))
          return true
        end)
      }))
    end
  end,

  in_pool = function(self, args)
    return true
  end

}
