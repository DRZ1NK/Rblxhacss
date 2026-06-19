if not game:IsLoaded() then
    game.Loaded:Wait()
end
local env = getgenv()

if not isfolder("PrivSettings") then makefolder("PrivSettings") end
if not isfile("PrivSettings/Config.json") then
    writefile("PrivSettings/Config.json", game:GetService("HttpService"):JSONEncode({
        settings = {
            auto_rejoin_on_kick = false,
            disable_3d_rendering = false
        }
    }))
end

function env.import(id)
    return game:GetObjects(id)[1]
end

function env.getgitpath(where)
    local mainBuild = "https://raw.githubusercontent.com/RobIoxlan/Src/refs/heads/main/"
    if where == "src" then
        return mainBuild .. "src/"
    elseif where == "games" then
        return mainBuild .. "src/games/"
    end
end

function env.setconfig(key, value)
    local httpservice = game:GetService("HttpService")
    local dec = httpservice:JSONDecode(readfile("PrivSettings/Config.json"))
    dec[tostring(game.PlaceId)] = dec[tostring(game.PlaceId)] or {}
    dec[tostring(game.PlaceId)][key] = value
    writefile("PrivSettings/Config.json", httpservice:JSONEncode(dec))
end

game:GetService("GuiService").ErrorMessageChanged:Connect(function()
    if env.autorjjjj then
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
end)

loadstring(game:HttpGet(getgitpath("src").."ui.lua"))()

if queue_on_teleport then
    queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/RobIoxlan/Src/refs/heads/main/"))()')
end
