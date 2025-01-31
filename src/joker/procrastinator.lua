SMODS.Joker{
  key = "procrastinator", --joker key
  loc_txt = { -- local text
      name = "Procrastinator",
      text = {
        "{X:mult,C:white}X#1#{} Mult",
        "When {C:attention}Small Blind{} or",
        "{C:attention}Big Blind{} is selected,",
        "lose {X:mult,C:white}X#2#{} Mult",
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
      Xmult = 4.0,
      minus = 0.5
    }
  },
  loc_vars = function(self,info_queue,center)
    return {vars = {center.ability.extra.Xmult, center.ability.extra.minus}} --#1# is replaced with card.ability.extra.Xmult
  end,
  check_for_unlock = function(self, args)
    return true
  end,
  calculate = function(self,card,context)
    if context.joker_main then
      return {
        card = card,
        xmult = card.ability.extra.Xmult,
        -- message = "X"..card.ability.extra.Xmult,
        colour = G.C.MULT,
      }
    elseif context.setting_blind and not self.getting_sliced and G.GAME.blind:get_type() ~= "Boss" then
      card.ability.extra.Xmult = math.max(1.0, card.ability.extra.Xmult - card.ability.extra.minus)
      return {
        card = card,
        message = "-"..card.ability.extra.minus,
        colour = G.C.RED
      }
    end
  end,
  in_pool = function(self,args)
    --whether or not this card is in the pool, return true if it is, return false if its not
    return G.GAME.round_resets.ante <= 4
  end,
}
