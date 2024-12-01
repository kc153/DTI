local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local autoOutfitButton = Instance.new("TextButton", frame)
autoOutfitButton.Size = UDim2.new(0.8, 0, 0.3, 0)
autoOutfitButton.Position = UDim2.new(0.1, 0, 0.1, 0)
autoOutfitButton.Text = "Auto-Outfit"
autoOutfitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoOutfitButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

-- Thematic Asset Libraries
local themeAssets = {
    faces = {
        happy = "rbxassetid://7074786",
        spooky = "rbxassetid://66666666",
        elegant = "rbxassetid://12345999"
    },
    hair = {
        casual = "rbxassetid://12345678",
        formal = "rbxassetid://23456789",
        messy = "rbxassetid://88888888"
    },
    clothes = {
        summer = "rbxassetid://13579111",
        royal = "rbxassetid://98765432",
        spooky = "rbxassetid://99999999"
    }
}

-- Function to Generate Outfits
local function generateOutfit(theme)
    local selectedFace = themeAssets.faces.happy
    local selectedHair = themeAssets.hair.casual
    local selectedClothes = themeAssets.clothes.summer

    if theme:lower():find("spooky") then
        selectedFace = themeAssets.faces.spooky
        selectedHair = themeAssets.hair.messy
        selectedClothes = themeAssets.clothes.spooky
    elseif theme:lower():find("royal") then
        selectedFace = themeAssets.faces.elegant
        selectedHair = themeAssets.hair.formal
        selectedClothes = themeAssets.clothes.royal
    end

    return selectedFace, selectedHair, selectedClothes
end

-- Apply Outfit Function
local function applyOutfit(theme)
    local face, hair, clothes = generateOutfit(theme)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidDescription = Players:GetHumanoidDescriptionFromUserId(player.UserId)

    humanoidDescription.Face = face
    humanoidDescription.HairAccessory = hair
    humanoidDescription.Shirt = clothes

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:ApplyDescription(humanoidDescription)
    end
end

-- Button Click Event
autoOutfitButton.MouseButton1Click:Connect(function()
    local themeInput = Instance.new("TextBox", frame)
    themeInput.Size = UDim2.new(0.8, 0, 0.3, 0)
    themeInput.Position = UDim2.new(0.1, 0, 0.5, 0)
    themeInput.PlaceholderText = "Enter Theme..."
    themeInput.Text = ""

    themeInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local theme = themeInput.Text
            applyOutfit(theme)
            themeInput:Destroy()
        end
    end)
end)
