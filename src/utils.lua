function Contains(array, str)
  for _, value in ipairs(array) do
    if value == str then
      return true
    end
  end
  return false
end

--[[
This function is different from Card:get_edition
This returns the edition object, which may look something like
  {
    chips = 0,
    mult = 10,
    x_mult = 0,
    type = "holo",
    holo = true
  }
]]
function GetEditionObj(card)
  if not card then return nil end
  return card.edition
end

function GetEnhancement(card)
  if not card then return nil end
  -- the name of the enhancement, this might not be in the enhancement pool
  -- if the mod was disabled/deleted during the run
  local enhancement_name = card.ability.effect
  -- the enhancement's effect if it is found, otherwise nil
  local enhancement = nil
  local enhancements_map = get_current_pool("Enhanced")
  for i, k in pairs(enhancements_map) do
    if G.P_CENTERS[k].effect == enhancement_name then
      enhancement = G.P_CENTERS[k].effect
      break
    end
  end
  return enhancement
end

-- Returns true if card has no edition and _edition_name is nil
function HasEdition(card, _edition_name)
  local edition = GetEditionObj(card)
  local edition_name = edition and edition.name or nil
  return edition_name == _edition_name
end

-- Returns true if card has no enhancement and enhancement_name is nil
function HasEnhancement(card, enhancement_name)
  return GetEnhancement(card) == enhancement_name
end

function TableToString(tbl, depth, indent)
  -- parameterize this if needed
  local maxDepth = 3
  depth = depth or 0
  indent = indent or 0
  local toStr = string.rep("  ", indent + 1) .. "{\n"

  if depth >= maxDepth then
    toStr = toStr .. string.rep("  ", indent) .. "(table)\n"
    return toStr
  end

  for k, v in pairs(tbl) do
    local keyStr = "[" .. tostring(k) .. "]"
    local valueStr

    if type(v) == "table" then
      valueStr = TableToString(v, depth + 1, indent + 1)
    else
      valueStr = v ~= nil and tostring(v) or "nil"
    end

    toStr = toStr .. "\n" .. string.rep("  ", indent + 1) .. keyStr .. " = " .. valueStr
  end

  toStr = toStr .. "\n" .. string.rep("  ", indent) .. "}"
  return toStr
end
