SMODS.Joker{
  key = "vanity", --joker key
  loc_txt = { -- local text
      name = "Vanity",
      text = {
        "Lose all discards.",
        "Earn {C:gold}$#1#{} for each discard lost.",
        "Earn an additional {C:gold}$#1#{}",
        "if you own {C:attention}Hubris{}"
      },
      --[[unlock = {
          "Be {C:legendary}cool{}",
      }]]
  },
  atlas = "Jokers", --atlas" key
  rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 6, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = true, --whether or not it starts discovered
  blueprint_compat = true, --can it be blueprinted/brainstormed/other
  eternal_compat = true, --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = {x = 5, y = 0}, --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { 
    extra = {
      dollars = 3
    }
  },
  loc_vars = function(self,info_queue,center)
    return {vars = {center.ability.extra.dollars}}
  end,
  check_for_unlock = function(self, args)
    return true
  end,
  calculate = function(self,card,context)
      if context.setting_blind and not self.getting_sliced then
          local discards_to_cut = G.GAME.current_round.discards_left
          ease_discard(-discards_to_cut, true)
          local ease_moneys = discards_to_cut*card.ability.extra.dollars
          if #SMODS.find_card('j_betterbalancedbalatro_hubris') >= 1 then
            ease_moneys = ease_moneys + 3
          end
          ease_dollars(ease_moneys, true)
          return {
          message = "-"..discards_to_cut.." Discards",
          colour = G.C.IMPORTANT
          }
      end
    end,
  in_pool = function(self,args)
    return true
  end
}
