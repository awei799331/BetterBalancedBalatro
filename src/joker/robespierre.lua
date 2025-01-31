SMODS.Joker{
  key = "robespierre_joker", --joker key
  loc_txt = { -- local text
      name = "Robespierre",
      text = {
        "If first hand of round is a",
        "single face card, destroy it, and",
        "earn {C:gold}$5{}."
      },
      --[[unlock = {
          "Be {C:legendary}cool{}",
      }]]
  },
  atlas = "Jokers", --atlas" key
  rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 8, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = true, --whether or not it starts discovered
  blueprint_compat = false, --can it be blueprinted/brainstormed/other
  eternal_compat = false, --can it be eternal
  perishable_compat = false, --can it be perishable
  pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { 
    extra = {
      dollars = 10
    }
  },
  check_for_unlock = function(self, args)
      return true
  end,
  
  calculate = function(self,card,context)
    if context.setting_blind and not self.getting_sliced and context.cardarea == G.jokers then
      juice_card_until(
        card,
        (function() return context.setting_blind and G.GAME.current_round.hands_played == 0 end),
        true,
        nil)
    end
    if context.cardarea == G.jokers and context.before then
      if #context.full_hand == 1 and (context.full_hand[1]:get_id() == 11 or context.full_hand[1]:get_id() == 12 or context.full_hand[1]:get_id() == 13) and G.GAME.current_round.hands_played == 0 then
        ease_dollars(5, true)
        return {
          message = "$5",
          colour = G.C.GOLD
        }
      end
    end
    if context.destroy_card and context.cardarea == G.play then
      if #context.full_hand == 1 and (context.full_hand[1]:get_id() == 11 or context.full_hand[1]:get_id() == 12 or context.full_hand[1]:get_id() == 13) and G.GAME.current_round.hands_played == 0 then
        return {
          remove = true
        }
      end
    end
  end,

  in_pool = function(self,args)
      --whether or not this card is in the pool, return true if it is, return false if its not
      return true
  end,
}
