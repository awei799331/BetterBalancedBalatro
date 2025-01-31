function contains(array, str)
  for _, value in ipairs(array) do
      if value == str then
          return true
      end
  end
  return false
end
