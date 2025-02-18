local get_chip_mult_stored = Card.get_chip_mult

function Card.get_chip_mult(self)
  if #SMODS.find_card('j_betterbalancedbalatro_emme_joker') < 1 then
    return get_chip_mult_stored(self)
  elseif #SMODS.find_card('j_betterbalancedbalatro_emme_joker') >= 1 and self.ability.effect == "Lucky Card" then
    self.lucky_trigger = true
    return G.P_CENTERS.m_lucky.config.mult
  else
    return self.ability.mult
  end
end
