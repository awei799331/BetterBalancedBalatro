SMODS.Joker{
  key = "golden_goose", --joker key
  loc_txt = { -- local text
      name = "Golden Goose",
      text = {
        "Sells for {C:gold}$#1#{}"
      },
      --[[unlock = {
          "Be {C:legendary}cool{}",
      }]]
  },
  atlas = "Jokers", --atlas" key
  rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 1, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = false, --whether or not it starts discovered
  blueprint_compat = false, --can it be blueprinted/brainstormed/other
  eternal_compat = false, --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = {x = 3, y = 0}, --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      bonus_value = 24
    }
  },
  set_ability = function(self, card, initial, delay_sprites)
    if G.GAME.pool_flags.fried_egg_hatched == nil then
      G.GAME.pool_flags.fried_egg_hatched = false
    end
    card.ability.extra_value = card.ability.extra.bonus_value
    card:set_cost()
  end,
  loc_vars = function(self,info_queue,center)
    return {vars = {center.ability.extra.bonus_value + 1}} --#1# is replaced with card.ability.extra.Xmult
  end,
  check_for_unlock = function(self, args)
    return G.GAME.pool_flags.fried_egg_hatched == true
  end,
  calculate = function(self,card,context)
  end,
  in_pool = function(self,args)
    --whether or not this card is in the pool, return true if it is, return false if its not
    return G.GAME.pool_flags.fried_egg_hatched == true
  end,
}
