SMODS.Joker {
  key = "recycler", --joker key
  loc_txt = {       -- local text
    name = "Recycler",
    text = {
      "Every other broken {C:attention}Glass{}",
      "card grants a {C:tarot}Justice{}",
      "{C:inactive}(Broken {C:attention}#1#{C:inactive})"
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
  pos = { x = 5, y = 3 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      broken = 0
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.broken } } --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.remove_playing_cards and not context.blueprint then
      for k, v in ipairs(context.removed) do
        if v.shattered then
          card.ability.extra.broken = card.ability.extra.broken + 1

          if card.ability.extra.broken % 2 == 0 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            return {
              extra = {
                message = localize('c_justice') .. "!",
                func = function()
                  G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                      local justice = SMODS.add_card({
                        type = "Tarot",
                        area = G.consumeables,
                        legendary = nil,
                        rarity = nil,
                        skip_materialize = nil,
                        soulable = nil,
                        key =
                            G.P_CENTERS.c_justice.key,
                        key_append = "recycler"
                      })
                      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
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
    end
  end,

  in_pool = function(self, args)
    return true
  end

}
