SMODS.Joker{
  key = "tour_guide", --joker key
  loc_txt = { -- local text
      name = "Tour Guide",
      text = {
        "Sell this joker after",
        "skipping #2# blinds for",
        "{C:attention}-1{} Ante",
        "Currently: {C:attention}#1#{} skips"
      },
      --[[unlock = {
          "Be {C:legendary}cool{}",
      }]]
  },
  atlas = "Jokers", --atlas" key
  rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 5, --cost
  unlocked = true, --where it is unlocked or not: if true, 
  discovered = true, --whether or not it starts discovered
  blueprint_compat = false, --can it be blueprinted/brainstormed/other
  eternal_compat = false, --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = {x = 5, y = 0}, --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { 
    extra = {
      skipped_blinds = 0,
      required_skips = 3
    }
  },
  set_ability = function(self, card, initial, delay_sprites)
    card.ability.skipped_blinds = 0
  end,
  loc_vars = function(self,info_queue,center)
    return {vars = {center.ability.extra.skipped_blinds, center.ability.extra.required_skips}}
  end,
  check_for_unlock = function(self, args)
    return true
  end,
  calculate = function(self,card,context)
    if context.skip_blind then
      card.ability.extra.skipped_blinds = card.ability.extra.skipped_blinds + 1
      if card.ability.extra.skipped_blinds >= self.config.extra.required_skips then
        juice_card_until(card, (function() return true end), true, 1.5)
        return {
          card = card,
          message = "Ready!",
          colour = G.C.GOLD
        }
      end
      return {
        card = card,
        message = "Skipped!",
        colour = G.C.GOLD
      }
    end
    if context.selling_self then
      if card.ability.extra.skipped_blinds >= self.config.extra.required_skips then
        ease_ante(-1)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1
        G.HUD:recalculate()
      end
    end
  end,
  in_pool = function(self,args)
    --whether or not this card is in the pool, return true if it is, return false if its not
    return G.GAME.round_resets.ante >= 3
  end,
}
