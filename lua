-- Gui to Lua
-- Version: 3.2

-- Instances:

local Spawner = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local T = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local NFR = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local MFR = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local FR = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local NameBox = Instance.new("TextBox")
local UICorner_5 = Instance.new("UICorner")
local Spawn = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")

local petType = "NFR"

local function duplicatePet(petName)
    local success, Loads = pcall(function()
        return require(game.ReplicatedStorage.Fsys).load
    end)
    
    if not success then
        warn("Failed to load Fsys module")
        return
    end
    
    local ClientData = Loads("ClientData")
    local InventoryDB = Loads("InventoryDB")
    local Inventory = ClientData.get("inventory")

    local function generate_prop()
        return {
            flyable = true,
            rideable = true,
            neon = petType == "NFR" or petType == "MFR",
            mega_neon = petType == "MFR",
            age = 1
        }
    end

    local function cloneTable(original)
        local copy = {}
        for key, value in pairs(original) do
            if type(value) == "table" then
                copy[key] = cloneTable(value)
            else
                copy[key] = value
            end
        end
        return copy
    end

    if petName == "" or petName == nil then
        warn("Enter pet name!")
        return
    end

    for category_name, category_table in pairs(InventoryDB) do
        for id, item in pairs(category_table) do
            if category_name == "pets" and item.name and string.lower(item.name) == string.lower(petName) then
                local fake_uuid = game:GetService("HttpService"):GenerateGUID(false)
                local n_item = cloneTable(item)

                n_item["unique"] = "uuid_" .. fake_uuid
                n_item["category"] = "pets"
                n_item["properties"] = generate_prop()
                n_item["newness_order"] = math.random(1, 900000)

                if not Inventory[category_name] then
                    Inventory[category_name] = {}
                end

                Inventory[category_name][fake_uuid] = n_item
                warn("Pet " .. petName .. " added successfully!")
                return
            end
        end
    end
    
    warn("Pet " .. petName .. " not found in database")
end

Spawner.Name = "Spawner"
Spawner.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Spawner.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = Spawner
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderColor3 = Color3.fromRGB(60, 60, 60)
Main.BorderSizePixel = 2
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 480, 0, 320)

T.Name = "T"
T.Parent = Main
T.AnchorPoint = Vector2.new(0.5, 0.5)
T.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
T.BackgroundTransparency = 1.000
T.BorderColor3 = Color3.fromRGB(0, 0, 0)
T.BorderSizePixel = 0
T.Position = UDim2.new(0.5, 0, 0.1, 0)
T.Size = UDim2.new(0, 406, 0, 46)
T.Font = Enum.Font.GothamBold
T.Text = "Pet Spawner"
T.TextColor3 = Color3.fromRGB(255, 255, 255)
T.TextScaled = true
T.TextSize = 18.000
T.TextWrapped = true

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

FR.Name = "FR"
FR.Parent = Main
FR.AnchorPoint = Vector2.new(0.5, 0.5)
FR.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FR.BorderColor3 = Color3.fromRGB(80, 80, 80)
FR.BorderSizePixel = 1
FR.Position = UDim2.new(0.25, 0, 0.35, 0)
FR.Size = UDim2.new(0, 100, 0, 50)
FR.Font = Enum.Font.GothamBold
FR.Text = "FR"
FR.TextColor3 = Color3.fromRGB(255, 255, 255)
FR.TextScaled = true
FR.TextSize = 14.000
FR.TextWrapped = true
FR.MouseButton1Click:Connect(function()
    FR.TextColor3 = Color3.fromRGB(0, 200, 0)
    FR.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    petType = "FR"
    
    NFR.TextColor3 = Color3.fromRGB(255, 255, 255)
    NFR.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    
    MFR.TextColor3 = Color3.fromRGB(255, 255, 255)
    MFR.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

UICorner_4.CornerRadius = UDim.new(0, 8)
UICorner_4.Parent = FR

NFR.Name = "NFR"
NFR.Parent = Main
NFR.AnchorPoint = Vector2.new(0.5, 0.5)
NFR.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
NFR.BorderColor3 = Color3.fromRGB(80, 80, 80)
NFR.BorderSizePixel = 1
NFR.Position = UDim2.new(0.5, 0, 0.35, 0)
NFR.Size = UDim2.new(0, 100, 0, 50)
NFR.Font = Enum.Font.GothamBold
NFR.Text = "NFR"
NFR.TextColor3 = Color3.fromRGB(0, 200, 0)
NFR.TextScaled = true
NFR.TextSize = 14.000
NFR.TextWrapped = true
NFR.MouseButton1Click:Connect(function()
    NFR.TextColor3 = Color3.fromRGB(0, 200, 0)
    NFR.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    petType = "NFR"
    
    FR.TextColor3 = Color3.fromRGB(255, 255, 255)
    FR.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    
    MFR.TextColor3 = Color3.fromRGB(255, 255, 255)
    MFR.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

UICorner_2.CornerRadius = UDim.new(0, 8)
UICorner_2.Parent = NFR

MFR.Name = "MFR"
MFR.Parent = Main
MFR.AnchorPoint = Vector2.new(0.5, 0.5)
MFR.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MFR.BorderColor3 = Color3.fromRGB(80, 80, 80)
MFR.BorderSizePixel = 1
MFR.Position = UDim2.new(0.75, 0, 0.35, 0)
MFR.Size = UDim2.new(0, 100, 0, 50)
MFR.Font = Enum.Font.GothamBold
MFR.Text = "MFR"
MFR.TextColor3 = Color3.fromRGB(255, 255, 255)
MFR.TextScaled = true
MFR.TextSize = 14.000
MFR.TextWrapped = true
MFR.MouseButton1Click:Connect(function()
    MFR.TextColor3 = Color3.fromRGB(0, 200, 0)
    MFR.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    petType = "MFR"
    
    FR.TextColor3 = Color3.fromRGB(255, 255, 255)
    FR.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    
    NFR.TextColor3 = Color3.fromRGB(255, 255, 255)
    NFR.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

UICorner_3.CornerRadius = UDim.new(0, 8)
UICorner_3.Parent = MFR

NameBox.Name = "NameBox"
NameBox.Parent = Main
NameBox.AnchorPoint = Vector2.new(0.5, 0.5)
NameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
NameBox.BorderColor3 = Color3.fromRGB(70, 70, 70)
NameBox.BorderSizePixel = 1
NameBox.Position = UDim2.new(0.5, 0, 0.55, 0)
NameBox.Size = UDim2.new(0, 380, 0, 45)
NameBox.Font = Enum.Font.GothamBold
NameBox.PlaceholderText = "Enter pet name"
NameBox.Text = ""
NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
NameBox.TextScaled = true
NameBox.TextSize = 14.000
NameBox.TextWrapped = true
NameBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)

UICorner_5.CornerRadius = UDim.new(0, 8)
UICorner_5.Parent = NameBox

Spawn.Name = "Spawn"
Spawn.Parent = Main
Spawn.AnchorPoint = Vector2.new(0.5, 0.5)
Spawn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Spawn.BorderColor3 = Color3.fromRGB(80, 80, 80)
Spawn.BorderSizePixel = 1
Spawn.Position = UDim2.new(0.5, 0, 0.8, 0)
Spawn.Size = UDim2.new(0, 200, 0, 50)
Spawn.Font = Enum.Font.GothamBold
Spawn.Text = "Spawn Pet"
Spawn.TextColor3 = Color3.fromRGB(255, 255, 255)
Spawn.TextScaled = true
Spawn.TextSize = 16.000
Spawn.TextWrapped = true

UICorner_6.CornerRadius = UDim.new(0, 10)
UICorner_6.Parent = Spawn

Spawn.MouseButton1Click:Connect(function()
    local petName = NameBox.Text
    if petName == "" then
        local originalText = Spawn.Text
        Spawn.Text = "Enter name!"
        wait(1)
        Spawn.Text = originalText
        return
    end
    
    local originalSize = Spawn.Size
    local originalText = Spawn.Text
    
    Spawn.Text = "Creating..."
    local tweenService = game:GetService("TweenService")
    
    tweenService:Create(
        Spawn,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 190, 0, 45)}
    ):Play()
    
    wait(0.1)
    
    tweenService:Create(
        Spawn,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = originalSize}
    ):Play()
    
    duplicatePet(petName)
    
    Spawn.Text = "Success!"
    wait(0.5)
    Spawn.Text = originalText
end)

local UIS = game:GetService('UserInputService')
local frame = Main
local dragToggle = nil
local dragSpeed = 0.25
local dragStart = nil
local startPos = nil

local function updateInput(input)
	local delta = input.Position - dragStart
	local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
end

frame.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
		dragToggle = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragToggle then
			updateInput(input)
		end
	end
end)

print("Pet spawner GUI loaded successfully!")
