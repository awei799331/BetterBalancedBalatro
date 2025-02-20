SMODS.Joker {
  key = "free_aura", --joker key
  loc_txt = {        -- local text
    name = "Free Aura",
    text = {
      "Gain an {C:spectral,T:c_hex}Aura{}",
      "when {C:attention}Blind{} is defeated"
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 3,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 6,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = false, --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 6, y = 2 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
    }
  },

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.end_of_round and context.cardarea == G.jokers then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        return {
          extra = {
            message = "Aura!",
            func = function()
              G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                  local aura = SMODS.add_card({
                    type = "Spectral",
                    area = G.consumeables,
                    legendary = nil,
                    rarity = nil,
                    skip_materialize = nil,
                    soulable = nil,
                    key =
                        G.P_CENTERS.c_aura.key,
                    key_append = "free_aura"
                  })
                  G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                  return true
                end)
              }))
            end
          },
          colour = G.C.SECONDARY_SET.Spectral,
          card = card
        }
      end
    end
  end,

  in_pool = function(self, args)
    return true
  end

}
