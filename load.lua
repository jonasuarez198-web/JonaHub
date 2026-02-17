-- Jona Hub V1 FINAL (Speed con valores numéricos)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "JonaHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,220,0,260)
frame.Position = UDim2.new(0.05,0,0.25,0)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0.1,0)
title.Text = "Jona Hub V1"
title.TextScaled = true
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold

local y = 30
local function btn(txt)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(0.55,0,0,30)
	b.Position = UDim2.new(0.05,0,0,y)
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.TextColor3 = Color3.new(1,1,1)
	b.Text = txt
	b.Font = Enum.Font.Gotham
	y = y + 35
	return b
end

local function box()
	local t = Instance.new("TextBox", frame)
	t.Size = UDim2.new(0.3,0,0,30)
	t.Position = UDim2.new(0.65,0,0,y-35)
	t.BackgroundColor3 = Color3.fromRGB(30,30,30)
	t.TextColor3 = Color3.new(1,1,1)
	t.Text = "16"
	return t
end

local speed = btn("Speed: OFF")
local speedBox = box()

local ij = btn("Infinite Jump: OFF")
local inv = btn("Invisible: OFF")
local noclip = btn("Noclip: OFF")
local hbBtn = btn("Hitbox")

local min = Instance.new("TextButton", frame)
min.Size = UDim2.new(0.9,0,0,30)
min.Position = UDim2.new(0.05,0,0.9,0)
min.Text = "Minimizar"
min.BackgroundColor3 = Color3.fromRGB(20,20,20)
min.TextColor3 = Color3.new(1,1,1)

-- BURBUJA
local bubble = Instance.new("TextButton", gui)
bubble.Size = UDim2.new(0,50,0,50)
bubble.Position = UDim2.new(0.05,0,0.5,0)
bubble.BackgroundColor3 = Color3.fromRGB(0,0,0)
bubble.Text = "J"
bubble.TextScaled = true
bubble.Font = Enum.Font.GothamBold
bubble.TextColor3 = Color3.new(1,1,1)
bubble.Visible = false
bubble.Active = true
bubble.Draggable = true
Instance.new("UICorner", bubble).CornerRadius = UDim.new(1,0)

-- HITBOX FLOAT
local hbFloat = Instance.new("Frame", gui)
hbFloat.Size = UDim2.new(0,140,0,70)
hbFloat.Position = UDim2.new(0.35,0,0.5,0)
hbFloat.BackgroundColor3 = Color3.fromRGB(0,0,0)
hbFloat.Visible = false
hbFloat.Active = true
hbFloat.Draggable = true
Instance.new("UICorner", hbFloat)

local hbTitle = Instance.new("TextLabel", hbFloat)
hbTitle.Size = UDim2.new(1,0,0.4,0)
hbTitle.Text = "Hitbox"
hbTitle.BackgroundTransparency = 1
hbTitle.TextColor3 = Color3.new(1,1,1)
hbTitle.TextScaled = true

local hbToggle = Instance.new("TextButton", hbFloat)
hbToggle.Size = UDim2.new(0.45,0,0.4,0)
hbToggle.Position = UDim2.new(0.05,0,0.5,0)
hbToggle.Text = "OFF"
hbToggle.BackgroundColor3 = Color3.fromRGB(20,20,20)
hbToggle.TextColor3 = Color3.new(1,1,1)

local hbValue = Instance.new("TextBox", hbFloat)
hbValue.Size = UDim2.new(0.4,0,0.4,0)
hbValue.Position = UDim2.new(0.55,0,0.5,0)
hbValue.Text = "6"
hbValue.BackgroundColor3 = Color3.fromRGB(20,20,20)
hbValue.TextColor3 = Color3.new(1,1,1)

-- SPEED
local sp = false
speed.MouseButton1Click:Connect(function()
	sp = not sp
	speed.Text = "Speed: "..(sp and "ON" or "OFF")
end)

RunService.RenderStepped:Connect(function()
	if sp then
		lp.Character.Humanoid.WalkSpeed = tonumber(speedBox.Text) or 16
	end
end)

-- INFINITE JUMP
local inf = false
ij.MouseButton1Click:Connect(function()
	inf = not inf
	ij.Text = "Infinite Jump: "..(inf and "ON" or "OFF")
end)

UIS.JumpRequest:Connect(function()
	if inf then
		lp.Character.Humanoid:ChangeState("Jumping")
	end
end)

-- NOCLIP
local nc = false
noclip.MouseButton1Click:Connect(function()
	nc = not nc
	noclip.Text = "Noclip: "..(nc and "ON" or "OFF")
end)

RunService.Stepped:Connect(function()
	if nc then
		for _,v in pairs(lp.Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- HITBOX
hbBtn.MouseButton1Click:Connect(function()
	hbFloat.Visible = not hbFloat.Visible
end)

local h = false
hbToggle.MouseButton1Click:Connect(function()
	h = not h
	hbToggle.Text = h and "ON" or "OFF"
end)

RunService.RenderStepped:Connect(function()
	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= lp and plr.Character then
			local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				if h then
					local s = tonumber(hbValue.Text) or 6
					hrp.Size = Vector3.new(s,s,s)
					hrp.Transparency = 0.9
					hrp.Material = Enum.Material.Neon
					hrp.CanCollide = false -- 🔥 TRASPASABLE
				else
					hrp.Size = Vector3.new(2,2,1)
					hrp.Transparency = 1
				end
			end
		end
	end
end)

-- MINIMIZAR (🔥 HITBOX SIGUE ACTIVA)
min.MouseButton1Click:Connect(function()
	frame.Visible = false
	bubble.Visible = true
end)

bubble.MouseButton1Click:Connect(function()
	frame.Visible = true
	bubble.Visible = false
end)
