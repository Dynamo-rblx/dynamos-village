-- @ScriptType: Script
game.ReplicatedStorage:WaitForChild("punch").OnServerEvent:Connect(function(plr)
	local char = plr.Character
	local animator = Instance.new("Animator")
	animator.Parent = char:WaitForChild("Humanoid")
	
	script:WaitForChild("dmg"):Clone().Parent = char:WaitForChild("RightHand")
	script:WaitForChild("dmg"):Clone().Parent = char:WaitForChild("RightLowerArm")
	
	animator:LoadAnimation(script.punch):Play()
	task.wait(2)
	if char.RightHand:FindFirstChild("dmg") then
		char.RightHand.dmg:Destroy()
	end
	if char.RightLowerArm:FindFirstChild("dmg") then
		char.RightLowerArm.dmg:Destroy()
	end
	
end)