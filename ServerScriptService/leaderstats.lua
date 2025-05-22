-- @ScriptType: Script
local DS = game:GetService("DataStoreService")

game.Players.PlayerAdded:Connect(function(plr)
	plr.Team = game:GetService("Teams"):WaitForChild("Spectating")
	
	local lb = Instance.new("Folder", plr)
	lb.Name = "leaderstats"
	
	local Rep = 0
	
end)