-- @ScriptType: Script
local db = false
local lastHealth = script.Parent.Parent:WaitForChild("Humanoid").Health

script.Parent.Parent:WaitForChild("Humanoid").HealthChanged:Connect(function()
	if lastHealth > script.Parent.Parent:WaitForChild("Humanoid").Health then
		script.Parent.Parent:WaitForChild("RightHand"):WaitForChild("dmg").Enabled = true
		script.Parent.Parent:WaitForChild("RightLowerArm"):WaitForChild("dmg").Enabled = true
		script.Parent.Parent:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(script.punch):Play()
		task.wait(2.5)
		script.Parent.Parent:WaitForChild("RightHand"):WaitForChild("dmg").Enabled = false
		script.Parent.Parent:WaitForChild("RightLowerArm"):WaitForChild("dmg").Enabled = false
	end
	lastHealth = script.Parent.Parent:WaitForChild("Humanoid").Health
end)

--script.Parent.Touched:Connect(function(bp)
--	if bp.Parent:FindFirstChild("Humanoid") and game.Players:FindFirstChild(bp.Parent.Name) then
--		script.Parent.Parent.PrimaryPart.CFrame = CFrame.lookAt(script.Parent.Parent.PrimaryPart.CFrame.Position, bp.Parent.PrimaryPart.CFrame.Position, script.Parent.Parent.PrimaryPart.CFrame.UpVector)
--	end
--end)