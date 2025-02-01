SMODS.Joker {
  key = "fried_egg", --joker key
  loc_txt = {        -- local text
    name = "Fried Egg",
    text = {
      "After {C:attention}3{} rounds, this egg hatches and ",
      "Golden Goose may appear in the shop",
      "Played rounds: {C:blue}#1#{}"
    },
    --[[unlock = {
          "Be {C:legendary}cool{}",
      }]]
  },
  atlas = "Jokers",         --atlas" key
  rarity = 1,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 1,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = false, --can it be blueprinted/brainstormed/other
  eternal_compat = false,   --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 2, y = 0 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      hatch_time = 3,
      played_rounds = 0
    }
  },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.played_rounds } } --#1# is replaced with card.ability.extra.Xmult
  end,
  check_for_unlock = function(self, args)
    return true
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if G.GAME.pool_flags.fried_egg_hatched == nil then
      G.GAME.pool_flags.fried_egg_hatched = false
    end
  end,
  calculate = function(self, card, context)
    if context.end_of_round and context.cardarea == G.jokers then
      card.ability.extra.played_rounds = card.ability.extra.played_rounds + 1
      if card.ability.extra.played_rounds >= card.ability.extra.hatch_time then
        G.GAME.pool_flags.fried_egg_hatched = true
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.3,
          func = function()
            card:remove()
            return true
          end
        }))
      else
        juice_card(card)
      end
      if G.GAME.pool_flags.fried_egg_hatched == true then
        return {
          message = "Hatched!",
          colour = G.C.GOLD
        }
      end
    end
  end,
  in_pool = function(self, args)
    --whether or not this card is in the pool, return true if it is, return false if its not
    return G.GAME.pool_flags.fried_egg_hatched == false
  end,
}
