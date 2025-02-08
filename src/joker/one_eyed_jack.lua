SMODS.Joker {
  key = "one_eyed_jack", --joker key
  loc_txt = {            -- local text
    name = "One Eyed Jack",
    text = {
      "All played Jacks",
      "become {C:attention}Wild{} cards",
      "when scored"
    },
  },
  atlas = "Jokers",         --atlas" key
  rarity = 1,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  --soul_pos = { x = 0, y = 0 },
  cost = 4,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 1, y = 2 },   --position in atlas, starts at 0, scales by the atlas" card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = {
    extra = {
    }
  },

  loc_vars = function(self, info_queue, center)
    return { vars = {} }   --Replace 'filler'
  end,

  check_for_unlock = function(self, args)
    return true
  end,

  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before then
      local jacks = {}
      for k, v in ipairs(context.scoring_hand) do
        if v:get_id() == 11 then
          jacks[#jacks + 1] = v
          v:set_ability(G.P_CENTERS.m_wild, nil, true)
          G.E_MANAGER:add_event(Event({
            func = function()
              v:juice_up()
              return true
            end
          }))
        end
      end
      if #jacks > 0 then 
        return {
            message = 'Wild!',
            colour = G.C.IMPORTANT,
            card = card
        }
    end
    end
  end,

  in_pool = function(self, args)
    return true
  end

}
