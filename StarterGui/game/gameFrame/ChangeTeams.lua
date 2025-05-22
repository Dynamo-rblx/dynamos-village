-- @ScriptType: LocalScript
while task.wait() do
	if script.Parent.Parent:WaitForChild("playing").Value == true then
		task.wait(math.random(6, 9))
		if script.Parent.Parent:WaitForChild("playing").Value == true and game.Players.LocalPlayer.Team == game:GetService("Teams"):WaitForChild("Spectating") then
			script.Parent.Parent.Enabled = false
			script.Parent.Parent:WaitForChild("sound"):FindFirstChildOfClass("Sound"):Stop()
			script.Parent.Parent:WaitForChild('Ambience'):Play()
			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SwitchTeams"):FireServer(game:GetService("Teams"):WaitForChild("Active"))
		end
	end
end