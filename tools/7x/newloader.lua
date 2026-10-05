    local function newLoader(class, race, character, faction, level)
        local env = setmetatable({}, {__index = _G})
        env._G = env
        env.strlower, env.strupper = string.lower, string.upper
        env.tinsert, env.tremove = table.insert, table.remove
        env.UnitLevel = function() return level or 10 end
        env.UnitSex = function() return 2 end
        env.bit = {band = function(value) return value % 4294967296 end}
        env.LibStub = function() return {} end
        env.RXPCData = character or {
            guideMetaData = {}, guideDisabled = {}, guideProgress = {},
        }
        local addon = {
            player = {class = class, race = race, faction = faction or "Horde"},
            game = "WOTLK", gameVersion = 30300, RXPGuides = {},
            locale = {Get = function(text) return text end},
            settings = {profile = {}, ReplaceColors = function(text) return text end},
            separators = {}, guideCache = {}, db = {},
            RXPFrame = {GenerateMenuTable = function() end}, error = error,
        }
        addon.functions = setmetatable({}, {__index = function(_, tag)
            return function(raw, text, first, second)
                return {text = text, first = first, second = second, tag = tag}
            end
        end})
        env.RXPGuides = {}
        local chunk = assert(loadfile(root .. "/Guide/Loader.lua"))
        setfenv(chunk, env)("RXPGuides", addon)
        return addon, env
    end
