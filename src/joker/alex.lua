SMODS.Joker{
  key = "alex_joker", --joker key
  loc_txt = { -- local text
      name = "Alex Joker",
      text = {
        "When a {C:planet}Planet{} card",
        "is used, increase the level of",
        "each {C:attention}poker hand{} by #1#"
      },
  },
  atlas = "Jokers", --atlas" key
  rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 12, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = true, --whether or not it starts discovered
  blueprint_compat = true, --can it be blueprinted/brainstormed/other
  eternal_compat = true, --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = {x = 7, y = 1}, --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { 
    extra = {
      level = 1
    }
  },
  loc_vars = function(self,info_queue,center)
    return {vars = {center.ability.extra.level}}
  end,
  check_for_unlock = function(self, args)
      return true
  end,
  calculate = function(self,card,context)
    -- TODO
  end,
  in_pool = function(self,args)
    return true
  end,
}
