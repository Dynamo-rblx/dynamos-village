-- @ScriptType: Script
script.Parent.Touched:Connect(function(bp)
	if bp.Parent:FindFirstChild("Humanoid") and game.Players:FindFirstChild(bp.Parent.Name) then
		script.hit:Play()
		bp.Parent:WaitForChild("Humanoid"):TakeDamage(script.Parent.Parent.Level.Value * 3)
		script.Enabled = false
	end
end)