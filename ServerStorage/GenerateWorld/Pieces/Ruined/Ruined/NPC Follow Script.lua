-- @ScriptType: Script
function FindTarget()
	local maxDistance = 100
	local attackDistance = 3
	local target = nil
	local attackAnim = script:WaitForChild("Attack")
	local hum = script.Parent:WaitForChild("Humanoid"):WaitForChild("Animator")
	local animate = hum:LoadAnimation(attackAnim)
	
	for i,v in pairs(workspace:GetChildren()) do
		if v:FindFirstChild("Humanoid") then
			if (v.Head.Position-script.Parent.Head.Position).magnitude < maxDistance  and game.Players:FindFirstChild(v.Name) then
				target = v.Head
				if (target.Position - script.Parent.Head.Position).magnitude <= attackDistance then
					animate:Play()
					v:FindFirstChildOfClass("Humanoid"):TakeDamage(5 * script.Parent:WaitForChild("Level").Value)
					task.wait(1)
				end
			end
		end
	end
	return target
end

while task.wait(0.1) do
	local target = FindTarget()
	if target then
		script.Parent.Humanoid:MoveTo(target.Position)
	end
end