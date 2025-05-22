-- @ScriptType: Script
game.Players.PlayerAdded:Connect(function(plr)
	game.Loaded:Connect(function()
		local char = plr.Character
		local color = BrickColor.random()

		for i, v in pairs(char:GetChildren()) do
			if v.ClassName ~= "Humanoid" then
				v.BrickColor = color
			end
		end	
	end)
end)