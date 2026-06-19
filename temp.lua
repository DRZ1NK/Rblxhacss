if not game:IsLoaded() then game.Loaded:Wait() end

local env = getgenv()

function env.getgitpath(where)
    local mainBuild = "https://raw.githubusercontent.com/RobIoxlan/Src/refs/heads/main/"
    if where == "src" then
        return mainBuild .. "src/"
    elseif where == "games" then
        return mainBuild .. "src/games/"
    end
end

local Tgame = env.getgitpath("games") .. game.PlaceId .. ".lua"
loadstring(game:HttpGet(Tgame))()
