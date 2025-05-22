-- @ScriptType: LocalScript
local bar = script.Parent.frame_main.frame_bar
local oxygenLabel = script.Parent.frame_main.number_value
local player = game.Players.LocalPlayer

local value_style = "Percentage"
local maxOxygen = 100
local currentOxygen = maxOxygen

local timePerLoss = 0.1

local isSwimming = false

local char = game.Players.LocalPlayer.Character
local hum = char:WaitForChild("Humanoid")

hum.StateChanged:Connect(function(oldState, newState)
	
	
	if newState == Enum.HumanoidStateType.Swimming then

		isSwimming = true
		
	else
		isSwimming = false
	end
end)


while task.wait(timePerLoss) do
	
	
	if isSwimming or game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RootPart.Position.Y >= 125 then
		
		currentOxygen = math.clamp(currentOxygen - 1, 0, maxOxygen)
		
	else
		currentOxygen = math.clamp(currentOxygen + 1, 0, maxOxygen)
	end
	
	
	if currentOxygen < 1 then
		hum.Health = 0
		bar.BackgroundTransparency = 1
		script.Disabled = true
	end
	
	
	local barScale = currentOxygen / maxOxygen
	bar:TweenSize(UDim2.new(barScale, 0, 1, 0), "InOut", "Linear", timePerLoss)
	if value_style == "Normal" then
		oxygenLabel.Text = 'Nitrogen: '.. currentOxygen .. " / " .. maxOxygen
	elseif value_style == "Percentage" then
		oxygenLabel.Text = 'Nitrogen: '.. currentOxygen ..''
	end
	delay(0, function()
	end)
end