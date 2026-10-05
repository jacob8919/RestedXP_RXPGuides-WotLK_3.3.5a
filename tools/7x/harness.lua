local root = arg[1]
local files = {"Guides/7x/Alliance-NightElf-7x.lua","Guides/7x/Alliance-Darkshore-7x.lua","Guides/7x/Alliance-Ashenvale-7x.lua","Guides/7x/Alliance-Dustwallow-7x.lua","Guides/7x/Alliance-Tanaris-7x.lua","Guides/7x/Alliance-Ungoro-7x.lua","Guides/7x/Alliance-Hellfire-7x.lua","Guides/7x/Alliance-Borean-7x.lua","Guides/7x/Alliance-Dragonblight-7x.lua"}
if arg[2] then files = {arg[2]} end
if os.getenv("FILES") then files = {} for f in os.getenv("FILES"):gmatch("%S+") do files[#files+1] = f end end
local src = io.open(arg[3] or ((os.getenv("S") or "tools/7x").."/newloader.lua")):read("*a")
local chunk = assert(loadstring("return function(root) " .. src .. " return newLoader end"))
local newLoader = chunk()(root)
local bad = 0
for _, f in ipairs(files) do
    local source = assert(io.open(root .. "/" .. f, "rb")):read("*a")
    for block in source:gmatch("RXPGuides%.RegisterGuide%(%[%[(.-)%]%]%)") do
        local classes = {"WARRIOR","HUNTER","ROGUE","PRIEST","DRUID"}
        if os.getenv("CLASSES") then classes = {} for c in os.getenv("CLASSES"):gmatch("%w+") do classes[#classes+1] = c end end
        for _, class in ipairs(classes) do
            local addon = newLoader(class, "NightElf", nil, "Alliance", 40)
            local guide, err = addon.ParseGuide(block)
            if not guide or err then
                bad = bad + 1
                print(string.format("PARSE ERROR %s %s: %s", f, class, tostring(err)))
            else
                local n = 0
                for _, st in ipairs(guide.steps) do n = n + 1 end
                print(string.format("%-42s %-8s steps=%-4d next=%s", guide.name or "?", class, n, tostring(guide.next)))
            end
        end
    end
end
print("parse errors: " .. bad)
