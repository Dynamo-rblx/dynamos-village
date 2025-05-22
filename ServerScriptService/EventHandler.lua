-- @ScriptType: Script
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SwitchTeams").OnServerEvent:Connect(function(plr, team)
	plr.Team = team
	print("teams swapped")
	plr:LoadCharacter()
end)

game.ReplicatedStorage:WaitForChild("NM").OnServerEvent:Connect(function(plr)
	local char = plr. Character
	
	if char.Head.flashlight.Enabled == false then
		char.Head.flashlight.Enabled = true
		char.RightLowerArm.Material = Enum.Material.Neon
		char.LeftLowerArm.Material = Enum.Material.Neon
		char.RightLowerLeg.Material = Enum.Material.Neon
		char.RightLowerLeg.Material = Enum.Material.Neon
	else
		char.Head.flashlight.Enabled = false
		char.RightLowerArm.Material = Enum.Material.ForceField
		char.LeftLowerArm.Material = Enum.Material.ForceField
		char.RightLowerLeg.Material = Enum.Material.ForceField
		char.RightLowerLeg.Material = Enum.Material.ForceField
	end
end)