-- @ScriptType: LocalScript
-- PLACE THIS SCRIPT INTO STARTERPLAYERSCRIPTS


UserInputService = game:GetService("UserInputService")
RunService = game:GetService("RunService")

--SETTINGS:
--[
defaultWalkSpeed = 16 --The speed the player walks when not running
runSpeed = 24 --The speed the player walks when running
stamina = 100 --The current stamina of the player (this variable can be used to check the stamina level of the player)
maxStamina = 100 --The maximum ammount of stamina the character will regen to
minStaminaToRun = 30 --The minimum amount of stamina required to run
staminaPerSecond = 10 --The ammount of stamina that is used per second when running or jumping
staminaRegenPerSecond = 5 --The amount of stamina that is regenerated every second when not running or jumping

staminaGui = script.StaminaGui --Change "StaminaGui" to the name of your Gui parented to this script
--]

isJumping = false --Is the character jumping?
isRunning = false --Is the character running?
isExhuasted = false --Is the character exhausted?

player = game.Players.LocalPlayer --The player

staminaGui.Parent = player.PlayerGui --Sets the stamina Gui's parent to the playerGui (therefore making it visible)

UserInputService.InputBegan:Connect(function(input)
	local character = game.Workspace:WaitForChild(player.Name)
	
	if input.KeyCode == Enum.KeyCode.LeftShift then
		if stamina >= minStaminaToRun then
			if isExhuasted == false then
				isRunning = true
				character:WaitForChild("Humanoid").WalkSpeed = runSpeed
				character:WaitForChild("Humanoid").JumpPower = 50
				
				RunService.RenderStepped:Connect(function()
					if isExhuasted == true then
						isRunning = false
						character.Humanoid.WalkSpeed = defaultWalkSpeed
					end
				end)
			else
				isRunning = false
				character.Humanoid.WalkSpeed = defaultWalkSpeed
			end
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	local character = game.Workspace:WaitForChild(player.Name)

	if input.KeyCode == Enum.KeyCode.LeftShift then
		isRunning = false
		character.Humanoid.WalkSpeed = defaultWalkSpeed
	end
end)


RunService.RenderStepped:Connect(function()
	if stamina > 0 then
		isExhuasted = false
	else
		player.Character:WaitForChild("Humanoid").JumpPower = 0
		isExhuasted = true
		isRunning = false
	end
	
	staminaGui.StaminaFrame.Bar.Size = UDim2.new(stamina / maxStamina, 0, 1, 0)
	staminaGui.StaminaFrame.StaminaLabel.Text = "Battery: "..stamina
	script.Parent.static.staticframe.Visible = true
	script.Parent:WaitForChild("static"):WaitForChild("staticframe").ImageTransparency = stamina/maxStamina
end)

player.Character:WaitForChild("Humanoid").StateChanged:Connect(function(old, new)
	if new == Enum.HumanoidStateType.Jumping then
		isJumping = true
	else
		isJumping = false
	end
end)

while task.wait(1) do
	if isRunning == true or isJumping == true then
		stamina -= staminaPerSecond
	else
		if stamina < maxStamina then
			stamina += staminaRegenPerSecond
		end
	end
end

game:GetService("ReplicatedStorage"):WaitForChild("digging").OnClientEvent:Connect(function()
	if stamina < 6 then
		stamina -= 7
	end
end)