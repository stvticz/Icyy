-- Synapse X Only

local Theme

if getgenv().Theme == nil then
    Theme = {
        Toggle = Enum.KeyCode.LeftShift,
        Back = Color3.fromRGB(30, 30, 30),
        Border = Color3.fromRGB(60, 60, 60),
        Accent = Color3.fromRGB(0, 101, 169),
        Fore = Color3.fromRGB(255, 255, 255),
    }    
end

local Settings = {
    Name = "Icyy",
    Credits = {
        ["Owner"] = "stvticz",
    },
    EKey = "maya",
}

local Config = {
    SeenAlpha = false,
}

local Load = function()
    Config = game:GetService("HttpService"):JSONDecode(readfile(Settings.Name..".json"))
end

local Save = function()
    writefile(Settings.Name..".json", game:GetService("HttpService"):JSONEncode(Config))
end

local ConfigExists = function()
    local x = pcall(function()
        readfile(Settings.Name..".json")    
    end)
    return x
end

if ConfigExists() then
    Load()
end

local Alpha = {
    ShowAds = function()
        if not Config.SeenAlpha then
            local Ads = {
                "https://i.imgur.com/obousW0.png",
                "https://i.imgur.com/xgHr4dG.png",
                "https://i.imgur.com/P0sbOqI.png",
                "https://i.imgur.com/Mu8kPoC.png",
            }
            
            for i,v in next, Ads do
                local x = Drawing.new("Image")
                x.Data = game:HttpGet(v)
                x.Position = Vector2.new(0, 0)
                x.Size = Vector2.new(670, 503)
                x.Visible = true
                wait(4)
                x:Remove()
            end
        end
        Config.SeenAlpha = true
    end
}

local Internet = {
    Get = game.HttpGetAsync or game.HttpGet,
    Post = syn.request or request,
}

local Account = {
    Check = function(u, p)
        
    end,
}

local New = function(Name, T)
    local Inst = Instance.new(Name)
    for i,v in next, T do
        Inst[i] = v
    end
    return Inst  
end

function Dragify(frame)
    dragToggle = nil
    dragSpeed = 0 -- You can edit this.
    dragInput = nil
    dragStart = nil
    dragPos = nil
    
    function updateInput(input)
        Delta = input.Position - dragStart
        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        game:GetService("TweenService"):Create(Frame, TweenInfo.new(dragSpeed), {Position = Position}):Play()
    end
    
    Frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = true
            dragStart = input.Position
            startPos = Frame.Position
            input.Changed:Connect(function()
                if (input.UserInputState == Enum.UserInputState.End) then
                    dragToggle = false
                end
            end)
        end
    end)
    
    Frame.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if (input == dragInput and dragToggle) then
            updateInput(input)
        end
    end)
end

for i,v in next, game.CoreGui:GetChildren() do
    if v.Name == Settings.Name then
        v:Destroy()
    end
end
    
function Tween(Object, Length, Style, Direction, Properties)
    local TweenService = game:GetService("TweenService")
	local Tween = TweenService:Create(
		Object,
		TweenInfo.new(Length, Enum.EasingStyle[Style].Value, Enum.EasingDirection[Direction].Value),
		Properties
	)
	-- Features:Tween(Frame, 1, "Linear", "Out", { BackgroundColor3 = Color3.new() })
	Tween:Play()
	Tween.Completed:Wait()
	Tween:Destroy()
end

for _,v in pairs(game:GetService('CoreGui'):GetChildren()) do
	if v.Name == Settings.Name then
		v:Destroy()
	end
end

-- Damn this got popular REAL fast

-- This specific edit is for Arsenal

local players = game:GetService("Players")
local camera = workspace.CurrentCamera
local espcolorline = Color3.fromRGB(59, 153, 253)
local espcolorname = Color3.fromRGB(59, 153, 253)
local espcolorbox = Color3.fromRGB(59, 153, 253)
local boxesp = false
local nameesp = false
local BoxFilled = false
local gs = game:GetService("GuiService"):GetGuiInset()
local ESPMain = {}
local tracers = false

createline = function()
    local line = Drawing.new("Line")
    line.Thickness = 1.5
    line.Transparency = 1
    line.Visible = true
    line.Color = espcolorline
    line.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2 + 400)
    return line
end

createlabel = function(text)
    local label = Drawing.new("Text")
    label.Transparency = 1
    label.Visible = true
    label.Color = espcolorname
    label.Center = true
	label.Outline = true
    label.Text = text
    label.Size = 15
    return label
end

createbox = function()
    local box = Drawing.new("Square")
    box.Transparency = 1
    box.Thickness = 1.5
    box.Visible = true
    box.Color = espcolorbox
    box.Filled = BoxFilled
    return box
end

local player = players.LocalPlayer
function isInTeam(char)
	if teamcheck then
        if player and players:GetPlayerFromCharacter(char) and players:GetPlayerFromCharacter(char).Team and player.Team then
            if players:GetPlayerFromCharacter(char).Team ~= player.Team then
                return false
            else
                return (player.Team == players:GetPlayerFromCharacter(char).Team)
            end
    	end
	else
    	return false
	end
end

game:GetService("RunService").RenderStepped:Connect(
    function()
        spawn(
            function()
                for i, v in pairs((game:GetService("Players")):GetChildren()) do
                    if      v.Name ~= game:GetService("Players").LocalPlayer.Name and
                            v.Name ~= game.Players.LocalPlayer.Name and
                            v.Character and
                            v.Character:FindFirstChild("HumanoidRootPart") and
                        	v.Character:FindFirstChild("LowerTorso") and
                            (not isInTeam(v.Character)) and 
                            v.Character:FindFirstChild("Spawned")
                    then
                        if not ESPMain[v.Name] then
                            ESPMain[v.Name] = {
                                v.Character
                            }
                        end
                        local vector, onScreen = camera:WorldToScreenPoint(v.Character["UpperTorso"].Position - Vector3.new(0, 0.5, 0))
                        local vectorhead, onScreenhead = camera:WorldToScreenPoint(v.Character["Head"].Position + Vector3.new(0, 1, 0))
                        local vectorfeet, onScreenfeet = camera:WorldToScreenPoint(v.Character["HumanoidRootPart"].Position - Vector3.new(0, 2, 0))
                        if nameesp then
                            if ESPMain[v.Name][4] then
                                ESPMain[v.Name][4].Visible = (onScreen and nameesp and v.Character:FindFirstChild("Spawned") ~= nil)
                                ESPMain[v.Name][4].Position = Vector2.new(vectorhead.X, vectorhead.Y + (gs.Y / 2))
                               
								ESPMain[v.Name][4].Color = espcolorname
                            else
                                ESPMain[v.Name][4] = createlabel(v.Name)
                                ESPMain[v.Name][4].Visible = (onScreen and nameesp)
                                ESPMain[v.Name][4].Position = Vector2.new(vectorhead.X, vectorhead.Y + (gs.Y / 2))
                                
								ESPMain[v.Name][4].Color = espcolorname
                            end
                        else
                            if ESPMain[v.Name] then
                                if ESPMain[v.Name][4] then
                                    ESPMain[v.Name][4]:Remove()
                                    ESPMain[v.Name][4] = nil
                                end
                            end
                        end -- Buggy... Need more time on this. !Don't comment the name esp bit it'll break tracers!
                        -- Update, it's not the name esp it's some weird bug idk how to fix other than this abomination here
                        if true then
							local calc = vectorhead.y - vectorfeet.y
                            if ESPMain[v.Name][5] then
                                ESPMain[v.Name][5].Visible = false
								ESPMain[v.Name][5].Color = espcolorline
                                ESPMain[v.Name][5].To = Vector2.new(vector.X, vector.Y + gs.Y - calc / 2)
                                ESPMain[v.Name][5].From =
                                    Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2 + 400)
                            else
                                ESPMain[v.Name][5] = createline()
                                ESPMain[v.Name][5].Visible = false
                                ESPMain[v.Name][5].To = Vector2.new(vector.X, vector.Y + gs.Y - calc / 2)
                                ESPMain[v.Name][5].From =
                                    Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2 + 400)
								ESPMain[v.Name][5].Color = espcolorline
                            end
                        else
                            if ESPMain[v.Name][5] then
                                ESPMain[v.Name][5]:Remove()
                                ESPMain[v.Name][5] = nil
                            end
                        end
                        if tracers then
							local calc = vectorhead.y - vectorfeet.y
                            if ESPMain[v.Name][2] then
                                ESPMain[v.Name][2].Visible = (onScreen and tracers)
								ESPMain[v.Name][2].Color = espcolorline
                                ESPMain[v.Name][2].To = Vector2.new(vector.X, vector.Y + gs.Y - calc / 2)
                                ESPMain[v.Name][2].From =
                                    Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2 + 400)
                            else
                                ESPMain[v.Name][2] = createline()
                                ESPMain[v.Name][2].Visible = (onScreen and tracers)
                                ESPMain[v.Name][2].To = Vector2.new(vector.X, vector.Y + gs.Y - calc / 2)
                                ESPMain[v.Name][2].From =
                                    Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2 + 400)
								ESPMain[v.Name][2].Color = espcolorline
                            end
                        else
                            if ESPMain[v.Name][2] then
                                ESPMain[v.Name][2]:Remove()
                                ESPMain[v.Name][2] = nil
                            end
                        end
                        if boxesp then
							local calc = vectorhead.y - vectorfeet.y
                            if ESPMain[v.Name][3] then
                                ESPMain[v.Name][3].Visible = (onScreen and boxesp)
                                ESPMain[v.Name][3].Size = Vector2.new(1400 / vector.Z, calc)
								ESPMain[v.Name][3].Color = espcolorbox
                                ESPMain[v.Name][3].Position =
                                    Vector2.new(
                                    vector.X - ESPMain[v.Name][3].Size.X / 2,
                                    vector.Y + game:GetService("GuiService"):GetGuiInset().Y -
                                        ESPMain[v.Name][3].Size.Y / 2
                                )
                            else
                                ESPMain[v.Name][3] = createbox()
                                ESPMain[v.Name][3].Visible = (onScreen and boxesp)
                                ESPMain[v.Name][3].Size = Vector2.new(1400 / vector.Z, calc)
								ESPMain[v.Name][3].Color = espcolorbox
                                ESPMain[v.Name][3].Position =
                                    Vector2.new(
                                    vector.X - ESPMain[v.Name][3].Size.X / 2,
                                    vector.Y + game:GetService("GuiService"):GetGuiInset().Y -
                                        ESPMain[v.Name][3].Size.Y / 2
                                )
                            end
                        else
                            if ESPMain[v.Name][3] then
                                ESPMain[v.Name][3]:Remove()
                                ESPMain[v.Name][3] = nil
                            end
                        end
                    else
                        if ESPMain[v.Name] then
                            if ESPMain[v.Name][2] then
                                ESPMain[v.Name][2]:Remove()
                                ESPMain[v.Name][2] = nil
                            end
                            if ESPMain[v.Name][3] then
                                ESPMain[v.Name][3]:Remove()
                                ESPMain[v.Name][3] = nil
                            end
                            if ESPMain[v.Name][4] then
                                ESPMain[v.Name][4]:Remove()
                                ESPMain[v.Name][4] = nil
                            end
                        end
                    end
                end
            end
        )
    end
)

players.PlayerRemoving:Connect(
    function(plr)
        if ESPMain[plr.Name] then
            if ESPMain[plr.Name][2] then
                ESPMain[plr.Name][2]:Remove()
                ESPMain[plr.Name][2] = nil
            end
            if ESPMain[plr.Name][3] then
                ESPMain[plr.Name][3]:Remove()
                ESPMain[plr.Name][3] = nil
            end
            if ESPMain[plr.Name][4] then
                ESPMain[plr.Name][4]:Remove()
                ESPMain[plr.Name][4] = nil
            end
            ESPMain[plr.Name] = nil
        end
    end
)

local ESP = {}

function ESP:BoxESPToggle(status)
    boxesp = status
end
function ESP:TracersToggle(status)
    tracers = status
end
function ESP:NameESPToggle(status)
    nameesp = status
end
function ESP:SetESPColorBox(color)
    espcolorbox = color
end
function ESP:SetESPColorLine(color)
    espcolorline = color
end
function ESP:SetESPColorName(color)
    espcolorname = color
end
function ESP:TeamcheckToggle(status)
    teamcheck = status
end

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/stvticz/Icyy/main/UILibrary.lua"))()

local Verification = {
    
}

local Security = {
    Encrypt = function(s)
        return syn.crypt.encrypt(s, Settings.EKey)
    end,
    Decrypt = function(s)
        return syn.crypt.decrypt(s, Settings.EKey)
    end,
    Random = function(l)
        return syn.crypt.random(l)
    end,
}

Alpha.ShowAds()

Save()

-- Universal:

local Window =   Material.Load({
	Title = Settings.Name,
	Style = 3,
	SizeX = 400,
	SizeY = 300,
	Theme = "Dark",
})

local Universal = Window.New({
	Title = "1"
})
