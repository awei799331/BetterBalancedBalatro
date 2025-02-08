SMODS.Joker {
  key = "jack_joker", --joker key
  loc_txt = {         -- local text
    name = "Jack",
    text = {
      "{C:purple}Death{} always appears",
      "in {C:attention}Arcana Packs{}.",
      "Whenever you use {C:purple}Death{} create",
      "a permanent copy of the chosen",
      "card and draw it to hand"
    },
    --[[unlock = {
          "Be {C:legendary}cool{}",
      }]]
  },
  atlas = "Jokers",          --atlas" key
  rarity = 4,                --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 20,                 --cost
  unlocked = true,           --where it is unlocked or not: if true,
  discovered = true,         --whether or not it starts discovered
  blueprint_compat = false,  --can it be blueprinted/brainstormed/other
  eternal_compat = false,    --can it be eternal
  perishable_compat = false, --can it be perishable
  pos = { x = 7, y = 5 },    --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
    }
  },




  --THIS JOKER NEEDS FUNCTIONALITY STILL, DOES NOT WORK




  check_for_unlock = function(self, args)
    return true
  end,

  in_pool = function(self, args)
    --whether or not this card is in the pool, return true if it is, return false if its not
    return false
  end,
}
