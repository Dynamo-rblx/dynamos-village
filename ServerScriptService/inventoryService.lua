-- @ScriptType: Script
game:GetService("ReplicatedStorage"):WaitForChild("putOn").OnServerEvent:Connect(function(plr, selected)
	local character = plr.Character
	selected:Clone().Parent = character
end)

game:GetService("ReplicatedStorage"):WaitForChild("takeOff").OnServerEvent:Connect(function(plr, item)
	item:Destroy()
end)