SMODS.Joker {
  key = "showboat", --joker key
  loc_txt = {       -- local text
    name = "Showboat",
    text = {
      "Earn {C:gold}$7{}",
      "at end of round if",
      "{C:attention}Blind{} was defeated",
      "with one hand"
    },
    --[[unlock = {
          "Be {C:legendary}cool{}",
      }]]
  },
  atlas = "Jokers",         --atlas" key
  rarity = 1,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 6,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 4, y = 0 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
    }
  },
  check_for_unlock = function(self, args)
    return true
  end,

  calc_dollar_bonus = function(self, card)
    if G.GAME.current_round.hands_played == 1 then
      return 7
    end
  end,
}
