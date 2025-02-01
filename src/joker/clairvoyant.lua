SMODS.Joker{
    key = "clairvoyant", --joker key
    loc_txt = { -- local text
        name = "Clairvoyant",
        text = {
          "{C:chips}+#1#{} Chips per {C:purple}Tarot{}",
          "used this run",
          "{C:inactive}(Currently {C:chips}+#2#{C:inactive})"
        },
    },
    atlas = "Jokers", --atlas" key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 4}, --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chip_upgrade = 8,
      }
    },
  
    loc_vars = function(self,info_queue,center)
      return {vars = {center.ability.extra.chip_upgrade, center.ability.extra.chip_upgrade*(G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot or 0)}} --Replace 'filler'
    end,
  
    check_for_unlock = function(self, args)
        return true
    end,
  
  
    calculate = function(self,card,context)
      if context.using_consumeable then
        return {
          message = "+8 Chips",
          colour = G.C.ATTENTION
        }
      end
  
      if context.joker_main then
        return {
          chips = card.ability.extra.chip_upgrade*(G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot or 0)
        }
      end
    end,
  
    in_pool = function(self,args)
      return true
    end
  
  }
  