SMODS.Joker{
  key = "singularity", --joker key
  loc_txt = { -- local text
      name = "Singularity",
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
    if context.using_consumeable and context.consumeable.ability.set == "Planet" then

      -- Copied from card.lua#1160
      update_hand_text({sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3}, {handname="All Hands +1", chips = "...", mult = "...", level=""})
      G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.2, func = function()
        play_sound("tarot1")
        card:juice_up(0.8, 0.5)
        G.TAROT_INTERRUPT_PULSE = true
        return true end }))
      update_hand_text({delay = 0}, {mult = "+", StatusText = true})
      G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.9, func = function()
          play_sound("tarot1")
          card:juice_up(0.8, 0.5)
          return true end }))
      update_hand_text({delay = 0}, {chips = "+", StatusText = true})
      G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.9, func = function()
          play_sound("tarot1")
          card:juice_up(0.8, 0.5)
          G.TAROT_INTERRUPT_PULSE = nil
          return true end }))
      for k, v in pairs(G.GAME.hands) do
        level_up_hand(card, k, true)
      end
      update_hand_text({sound = "button", volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = "", level = ""})

    end
  end,
  in_pool = function(self,args)
    return true
  end,
}
