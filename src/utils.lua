function Contains(array, str)
  for _, value in ipairs(array) do
    if value == str then
      return true
    end
  end
  return false
end

function GetEnhancement(card)
  local enhancement_name = card.ability.effect
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
