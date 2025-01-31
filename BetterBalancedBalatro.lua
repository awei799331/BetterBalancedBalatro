MOD_ID = "betterbalancedbalatro"
-- Turn on for more verbose logs in the console
local DEBUG = true
-- Absolute path to src directory
local SRC = SMODS.Mods[MOD_ID].path.."src/"
-- Absolute paths to src subdirectories
local BBB_JOKER_PATH = SRC.."joker/"
local BBB_CHALLENGE_PATH = SRC.."challenge/"
local BBB_SPECTRAL_PATH = SRC.."spectral/"
local BBB_DECK_PATH = SRC.."deck/"

-- Loads the jokers in this order. This affects the order they show up in the collection table in game!
-- NO SPACES IN FILE NAMES!!!
local BBB_JOKER_FILES = {
  "shiny_joker",
  "robespierre",
  "fried_egg",
  "golden_goose",
  "diversity",
  "procrastinator",
  "tour_guide",
  "showboat",
  "hubris",
  "vanity",
  "singularity",
  "emme",
  "alex",
  "jack"
}

-- Load a file using its path
local function loadFile(path)
  local chunk = NFS.load(path)
  if chunk == nil then
    sendErrorMessage("Error loading "..path, "BBB:loadJokers")
  else
    if DEBUG then
      sendDebugMessage("Successfully loaded "..path, "BBB:loadJokers")
    end
    chunk()
  end
end

-- Load all jokers in the joker_list in order
local function loadJokers(folder, joker_list)
  for i, file_prefix in pairs(joker_list) do
    local file = folder..file_prefix..".lua"
    loadFile(file)
  end
end

function Main()
  SMODS.Atlas{
    key = "Jokers", --atlas key
    path = "Jokers.png", --atlas" path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
  }

  loadFile(SRC.."utils.lua")
  loadJokers(BBB_JOKER_PATH, BBB_JOKER_FILES)
end

Main()
