-- @ScriptType: Script
game:GetService("ReplicatedStorage"):WaitForChild("realIntro").OnServerEvent:Connect(function(plr)
	
	game.ReplicatedStorage.realIntro:FireClient(plr)
	
end)