SMODS.Joker {
  key = "mega_arcana", --joker key
  loc_txt = {          -- local text
    name = "Mega Arcana",
    text = {
      "Gain a {C:attention}Charm Tag{}",
      "when {C:attention}Boss Blind{} is defeated"
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 2,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 4,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = false, --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 7, y = 0 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
      filler = 0
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.filler } } --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss then
      return {
        func = G.E_MANAGER:add_event(Event({
          func = (function()
            add_tag(Tag("tag_charm"))
            play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
            play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
            return true
          end)
        }))
      }
    end
  end,

  in_pool = function(self, args)
    return true
  end

}
