SMODS.Joker {
  key = "jack_joker", --joker key
  loc_txt = {         -- local text
    name = "Jack",
    text = {
      "{C:purple}Death{} always appears in {C:attention}Arcana Packs{}.",
      "Whenever you use {C:purple}Death{}, create",
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



  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable.ability.name == "Death" then
      local rightmost =G.hand.highlighted[1]
      for i = 1, #G.hand.highlighted do
        if G.hand.highlighted[i].T.x > rightmost.T.x then
          rightmost = G.hand.highlighted[i]
        end
      end
      local new_card = copy_card(rightmost, nil, nil, G.playing_card)
      new_card.states.visible = nil
      func = G.E_MANAGER:add_event(Event({
        func = (function()
          new_card:add_to_deck()
          G.deck.config.card_limit = G.deck.config.card_limit + 1
          table.insert(G.playing_cards, new_card)
          G.hand:emplace(new_card)
          return true
        end)
      }))
      G.E_MANAGER:add_event(Event({
        func = function()
            new_card:start_materialize()
            return true
        end
    })) 
    return {
        message = localize('k_copied_ex'),
        colour = G.C.CHIPS,
        card = card,
        playing_cards_created = {true}
    }
    end
  end,
  --THIS JOKER NEEDS FUNCTIONALITY STILL, DOES NOT WORK




  check_for_unlock = function(self, args)
    return true
  end,

  in_pool = function(self, args)
    --whether or not this card is in the pool, return true if it is, return false if its not
    return false
  end,
}
