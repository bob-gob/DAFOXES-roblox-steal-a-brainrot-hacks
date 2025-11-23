 Demo UI (safe) - paste into a LocalScript under StarterPlayerScripts or a LocalScript inside a ScreenGui
-- This recreates the look: header, left nav, central "Paid Access" area, toggles, and keybind assignment behavior.
-- NONE of the features perform cheating or unauthorized actions. They're harmless demo toggles.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DemoSettingsUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = guiParent

-- Main container frame
local outer = Instance.new("Frame")
outer.Name = "Outer"
outer.Size = UDim2.new(0.9, 0, 0.6, 0)
outer.Position = UDim2.new(0.05, 0, 0.18, 0)
outer.AnchorPoint = Vector2.new(0,0)
outer.BackgroundColor3 = Color3.fromRGB(10,12,15)
outer.BorderSizePixel = 0
outer.BackgroundTransparency = 0
outer.Parent = screenGui
outer.ClipsDescendants = true
outer.Rotation = 0
outer.AutoButtonColor = false
outer.AnchorPoint = Vector2.new(0,0)
outer.BackgroundTransparency = 0

-- Rounded corner
local uiCorner = Instance.new("UICorner", outer)
uiCorner.CornerRadius = UDim.new(0, 12)

-- subtle border glow
local border = Instance.new("Frame")
border.Name = "Border"
border.Size = UDim2.new(1, 6, 1, 6)
border.Position = UDim2.new(-0.003, -3, -0.003, -3)
border.BackgroundColor3 = Color3.fromRGB(25, 40, 56)
border.BorderSizePixel = 0
border.ZIndex = 0
border.Parent = outer
local borderCorner = Instance.new("UICorner", border)
borderCorner.CornerRadius = UDim.new(0, 14)

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 56)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundTransparency = 1
header.Parent = outer

local headerText = Instance.new("TextLabel")
headerText.Name = "HeaderText"
headerText.Font = Enum.Font.GothamBold
headerText.Text = "Steal A Brainrot  •  Vemiz"
headerText.TextSize = 22
headerText.TextColor3 = Color3.fromRGB(190,230,255)
headerText.BackgroundTransparency = 1
headerText.Position = UDim2.new(0.02,0,0.12,0)
headerText.Size = UDim2.new(0.6,0,0.8,0)
headerText.TextXAlignment = Enum.TextXAlignment.Left
headerText.Parent = header

local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, -40, 0, 2)
headerLine.Position = UDim2.new(0.02, 0, 0.9, 0)
headerLine.BackgroundColor3 = Color3.fromRGB(63,156,205) -- neon accent
headerLine.BorderSizePixel = 0
headerLine.Parent = header

-- Left menu
local left = Instance.new("Frame")
left.Name = "Left"
left.Size = UDim2.new(0, 220, 1, -56)
left.Position = UDim2.new(0, 12, 0, 56)
left.BackgroundColor3 = Color3.fromRGB(12, 14, 16)
left.BorderSizePixel = 0
left.Parent = outer
local leftCorner = Instance.new("UICorner", left)
leftCorner.CornerRadius = UDim.new(0, 10)

local leftLayout = Instance.new("UIListLayout", left)
leftLayout.FillDirection = Enum.FillDirection.Vertical
leftLayout.Padding = UDim.new(0, 14)
leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
leftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
leftLayout.VerticalAlignment = Enum.VerticalAlignment.Top
leftLayout.Padding = UDim.new(0, 18)

local function makeLeftLabel(text, order)
	local t = Instance.new("TextLabel")
	t.Name = text:gsub("%s","")
	t.Size = UDim2.new(1, -20, 0, 28)
	t.Text = text
	t.Font = Enum.Font.GothamBold
	t.TextSize = 20
	t.TextColor3 = Color3.fromRGB(170,220,235)
	t.BackgroundTransparency = 1
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.LayoutOrder = order or 1
	t.Parent = left
	return t
end

makeLeftLabel("Main", 1)
makeLeftLabel("Steals", 2)     -- safe name chosen earlier by you (visual only)
makeLeftLabel("Finder", 3)
makeLeftLabel("Discord", 4)

-- Right content area
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -260, 1, -76)
content.Position = UDim2.new(0, 260, 0, 76)
content.BackgroundColor3 = Color3.fromRGB(8,10,12)
content.BorderSizePixel = 0
content.Parent = outer
local contentCorner = Instance.new("UICorner", content)
contentCorner.CornerRadius = UDim.new(0,8)

-- Big "Paid Access" label area
local bigTitle = Instance.new("TextLabel")
bigTitle.Name = "BigTitle"
bigTitle.Font = Enum.Font.GothamBlack
bigTitle.Text = "Paid\nAccess"
bigTitle.TextSize = 64
bigTitle.TextColor3 = Color3.fromRGB(210,235,245)
bigTitle.BackgroundTransparency = 1
bigTitle.Position = UDim2.new(0.05,0,0.06,0)
bigTitle.Size = UDim2.new(0.6,0,0.6,0)
bigTitle.TextWrapped = true
bigTitle.TextYAlignment = Enum.TextYAlignment.Center
bigTitle.TextXAlignment = Enum.TextXAlignment.Left
bigTitle.Parent = content

-- Money icon (simple frame with neon border)
local money = Instance.new("Frame")
money.Size = UDim2.new(0.3, 0, 0.6, 0)
money.Position = UDim2.new(0.65, 0, 0.15, 0)
money.BackgroundTransparency = 1
money.Parent = content

local moneyIcon = Instance.new("ImageLabel")
moneyIcon.Size = UDim2.new(1,0,1,0)
moneyIcon.Position = UDim2.new(0,0,0,0)
moneyIcon.BackgroundTransparency = 1
-- We'll draw a simple placeholder using an image asset if available, else use a colored frame.
-- Use a neon rectangle look:
moneyIcon.Image = ""
moneyIcon.Parent = money

local neonFrame = Instance.new("Frame")
neonFrame.Size = UDim2.new(1, -20, 1, -20)
neonFrame.Position = UDim2.new(0,10,0,10)
neonFrame.BackgroundColor3 = Color3.fromRGB(20,165,215)
neonFrame.BorderSizePixel = 0
neonFrame.Parent = money
local nfCorner = Instance.new("UICorner", neonFrame)
nfCorner.CornerRadius = UDim.new(0,6)

-- Right panel list for toggles
local optionsFrame = Instance.new("Frame")
optionsFrame.Name = "Options"
optionsFrame.Size = UDim2.new(0.9, 0, 0.6, 0)
optionsFrame.Position = UDim2.new(0.05, 0, 0.55, 0)
optionsFrame.BackgroundTransparency = 1
optionsFrame.Parent = content

local listLayout = Instance.new("UIListLayout", optionsFrame)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
listLayout.Padding = UDim.new(0, 12)

-- Helper: create option row with label, sublabel and toggle
local function createOptionRow(title, subtitle, defaultOn)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 58)
	row.BackgroundColor3 = Color3.fromRGB(14,16,18)
	row.BorderSizePixel = 0
	row.Parent = optionsFrame
	local rc = Instance.new("UICorner", row)
	rc.CornerRadius = UDim.new(0,6)
	
	local leftLabel = Instance.new("TextLabel")
	leftLabel.Font = Enum.Font.GothamBold
	leftLabel.Text = title
	leftLabel.TextSize = 20
	leftLabel.TextColor3 = Color3.fromRGB(200,225,235)
	leftLabel.BackgroundTransparency = 1
	leftLabel.Position = UDim2.new(0.02, 0, 0.06, 0)
	leftLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
	leftLabel.TextXAlignment = Enum.TextXAlignment.Left
	leftLabel.Parent = row
	
	local sub = Instance.new("TextLabel")
	sub.Font = Enum.Font.Gotham
	sub.Text = subtitle or ""
	sub.TextSize = 14
	sub.TextColor3 = Color3.fromRGB(140,170,185)
	sub.BackgroundTransparency = 1
	sub.Position = UDim2.new(0.02, 0, 0.5, 0)
	sub.Size = UDim2.new(0.6, 0, 0.4, 0)
	sub.TextXAlignment = Enum.TextXAlignment.Left
	sub.Parent = row
	
	local toggle = Instance.new("ImageButton")
	toggle.Name = "Toggle"
	toggle.Size = UDim2.new(0, 52, 0, 28)
	toggle.Position = UDim2.new(0.78, 0, 0.2, 0)
	toggle.BackgroundColor3 = Color3.fromRGB(30,34,38)
	toggle.BorderSizePixel = 0
	toggle.Parent = row
	local togCorner = Instance.new("UICorner", toggle)
	togCorner.CornerRadius = UDim.new(0,16)
	
	local knob = Instance.new("Frame")
	knob.Name = "Knob"
	knob.Size = UDim2.new(defaultOn and 0.5 or 0.5, -2, 1, -4)
	knob.Position = UDim2.new(defaultOn and 0.5 or 0, 2, 0, 2)
	knob.BackgroundColor3 = defaultOn and Color3.fromRGB(60,200,240) or Color3.fromRGB(70,70,70)
	knob.Parent = toggle
	local nk = Instance.new("UICorner", knob)
	nk.CornerRadius = UDim.new(0,14)
	
	local state = defaultOn and true or false
	toggle.MouseButton1Click:Connect(function()
		state = not state
		if state then
			knob:TweenPosition(UDim2.new(0.5,2,0,2), "Out", "Quart", 0.16, true)
			knob.BackgroundColor3 = Color3.fromRGB(60,200,240)
		else
			knob:TweenPosition(UDim2.new(0,2,0,2), "Out", "Quart", 0.16, true)
			knob.BackgroundColor3 = Color3.fromRGB(70,70,70)
		end
		-- Demo reaction: harmless visual effect
		if title == "Auto Steal" then
			-- show a harmless notification
			local note = Instance.new("TextLabel", screenGui)
			note.Text = state and "Auto Demo feature: ON" or "Auto Demo feature: OFF"
			note.Font = Enum.Font.GothamBold
			note.TextColor3 = Color3.fromRGB(220,235,255)
			note.BackgroundColor3 = Color3.fromRGB(12,14,16)
			note.BackgroundTransparency = 0
			note.Position = UDim2.new(0.5, -120, 0.02, 0)
			note.Size = UDim2.new(0,240,0,28)
			note.AnchorPoint = Vector2.new(0.5,0)
			local c = Instance.new("UICorner", note)
			c.CornerRadius = UDim.new(0,8)
			delay(1.2, function()
				note:Destroy()
			end)
		end
	end)
	
	return row, function() return state end
end

-- Create safe demo options with similar labels (non-malicious)
local o1 = createOptionRow("Invisible (V keybind)", "Demo visual - harmless", false)
local o2 = createOptionRow("Steal Upstairs (Y keybind)", "Demo navigation hint", false)
local o3 = createOptionRow("Auto Steal", "Demo auto: harmless", false)
local o4 = createOptionRow("Auto Steal Nearest Brainrot", "Demo selection", false)
local o5 = createOptionRow("Auto kick on steal", "Demo kick simulation (harmless)", false)

-- Keybind assignment behavior (demo)
local keybinds = {
	["Invisible (V keybind)"] = Enum.KeyCode.V,
	["Steal Upstairs (Y keybind)"] = Enum.KeyCode.Y,
}

local function createKeybindSetter(optionRow, title)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.18, 0, 0.6, 0)
	btn.Position = UDim2.new(0.64, 0, 0.2, 0)
	btn.Text = "[" .. tostring(string.match(tostring(keybinds[title] or Enum.KeyCode.Unknown), "KeyCode%.(%w+)") or "?") .. "]"
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.TextColor3 = Color3.fromRGB(220,235,245)
	btn.BackgroundColor3 = Color3.fromRGB(18,20,22)
	btn.BorderSizePixel = 0
	btn.Parent = optionRow
	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0,6)
	
	local waiting = false
	btn.MouseButton1Click:Connect(function()
		btn.Text = "[Press key]"
		waiting = true
		local conn
		conn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				keybinds[title] = input.KeyCode
				btn.Text = "[" .. tostring(string.match(tostring(input.KeyCode), "KeyCode%.(%w+)") or "?") .. "]"
				waiting = false
				conn:Disconnect()
			end
		end)
	end)
end

-- Attach keybind setters to the two keybind rows (if present)
local children = optionsFrame:GetChildren()
for _,child in ipairs(children) do
	if child:IsA("Frame") then
		local t = child:FindFirstChildWhichIsA("TextLabel")
		if t and (t.Text == "Invisible (V keybind)" or t.Text == "Steal Upstairs (Y keybind)") then
			createKeybindSetter(child, t.Text)
		end
	end
end

-- Demo: listen for assigned keybinds to toggle visual effects (harmless)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	for title, kc in pairs(keybinds) do
		if input.KeyCode == kc then
			-- toggles the corresponding "visual" effect as a demonstration
			local notif = Instance.new("TextLabel", screenGui)
			notif.Text = title .. " (demo) triggered"
			notif.Font = Enum.Font.GothamBold
			notif.TextColor3 = Color3.fromRGB(255,255,255)
			notif.BackgroundColor3 = Color3.fromRGB(10,12,15)
			notif.Position = UDim2.new(0.5, -140, 0.05, 0)
			notif.Size = UDim2.new(0,280,0,30)
			notif.AnchorPoint = Vector2.new(0.5,0)
			local c = Instance.new("UICorner", notif)
			c.CornerRadius = UDim.new(0,6)
			delay(1.1, function() notif:Destroy() end)
		end
	end
end)

-- Small credits avatar area bottom-left (like screenshot)
local avatarFrame = Instance.new("Frame", outer)
avatarFrame.Size = UDim2.new(0,140,0,48)
avatarFrame.Position = UDim2.new(0, 12, 1, -60)
avatarFrame.BackgroundTransparency = 1

local avIcon = Instance.new("ImageLabel")
avIcon.Size = UDim2.new(0,40,0,40)
avIcon.Position = UDim2.new(0,0,0.08,0)
avIcon.BackgroundColor3 = Color3.fromRGB(18,20,22)
avIcon.BorderSizePixel = 0
avIcon.Parent = avatarFrame
local avCorner = Instance.new("UICorner", avIcon)
avCorner.CornerRadius = UDim.new(0,8)

local nameLabel = Instance.new("TextLabel")
nameLabel.Font = Enum.Font.GothamBold
nameLabel.Text = (player and player.Name) or "Player"
nameLabel.TextSize = 16
nameLabel.TextColor3 = Color3.fromRGB(200,230,245)
nameLabel.BackgroundTransparency = 1
nameLabel.Position = UDim2.new(0,50,0,6)
nameLabel.Size = UDim2.new(0.6,0,0.6,0)
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.Parent = avatarFrame

-- Done: give it a little entrance animation
outer.Position = outer.Position + UDim2.new(0,0,0.06,0)
outer.BackgroundTransparency = 1
outer:TweenPosition(UDim2.new(0.05, 0, 0.18, 0), "Out", "Quad", 0.45, true)
outer:TweenSize(UDim2.new(0.9, 0, 0.6, 0), "Out", "Quad", 0.45, true)
outer.BackgroundTransparency = 0

print("Demo settings UI loaded (safe demo).")
