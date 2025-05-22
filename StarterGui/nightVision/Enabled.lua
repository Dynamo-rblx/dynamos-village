-- @ScriptType: LocalScript
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.N then
				script.Parent.Enabled = not(script.Parent.Enabled)
				game.ReplicatedStorage.NM:FireServer()
			end
		end
	end
end)