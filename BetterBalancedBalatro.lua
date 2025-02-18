MOD_ID = "betterbalancedbalatro"
-- Turn on for more verbose logs in the console
local DEBUG = true
-- Absolute path to src directory
local SRC = SMODS.Mods[MOD_ID].path .. "src/"
-- Absolute paths to src subdirectories
local BBB_JOKER_PATH = SRC .. "joker/"
local BBB_CHALLENGE_PATH = SRC .. "challenge/"
local BBB_SPECTRAL_PATH = SRC .. "spectral/"
local BBB_DECK_PATH = SRC .. "deck/"
local BBB_HOOK_PATH = SRC .. "hooks/"

-- Loads the jokers in this order. This affects the order they show up in the collection table in game!
-- NO SPACES IN FILE NAMES!!!
local BBB_JOKER_FILES = {
  "robespierre",
  "fried_egg",
  "golden_goose",
  "vanity",
  "showboat",
  "mega_arcana",
  "clairvoyant",
  "selling_chips",
  "climber",
  "bonus_joker",
  "mult_joker",
  "hubris",
  "moderation",
  "wildcard_joker",
  "one_eyed_jack",
  "wild_tarot",
  "wild_retrigger",
  "shiny_joker",
  "totem",
  "singularity",
  "procrastinator",
  "tour_guide",
  "skip_hand",
  "skip_retrigger",
  "diversity",
  "underdog",
  "palindrome",
  "theneighborhood",
  "big_stack_bully",
  "holy_order",
  "emme",
  "alex",
  "jack"
}

local BBB_HOOK_FILES = {
  "emme",
  "totem"
}

-- Load a file using its path
local function loadFile(path)
  local chunk = NFS.load(path)
  if chunk == nil then
    sendErrorMessage("Error loading " .. path, "BBB:loadJokers")
  else
    if DEBUG then
      sendDebugMessage("Successfully loaded " .. path, "BBB:loadJokers")
    end
    chunk()
  end
end

-- Load all jokers in the joker_list in order
local function loadFolder(folder, joker_list)
  for i, file_prefix in pairs(joker_list) do
    local file = folder .. file_prefix .. ".lua"
    loadFile(file)
  end
end

function Main()
  SMODS.Atlas {
    key = "Jokers",      --atlas key
    path = "Jokers.png", --atlas" path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71,             --width of one card
    py = 95              -- height of one card
  }

  loadFile(SRC .. "utils.lua")
  loadFolder(BBB_JOKER_PATH, BBB_JOKER_FILES)
  loadFolder(BBB_HOOK_PATH, BBB_HOOK_FILES)
end

Main()
