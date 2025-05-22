-- @ScriptType: LocalScript
local UIS = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer
local pUI = plr.PlayerGui

task.wait(10)

UIS.InputBegan:Connect(function(key,gpe)
	if gpe == false then
		if key.KeyCode == Enum.KeyCode.P then
			local pos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.Position
			local temporaryPoint = script:WaitForChild("waypointTemplate"):Clone()
			temporaryPoint.Name	= tostring(#game.Workspace:WaitForChild("waypoints"):GetChildren())
			if game.Workspace:WaitForChild("waypoints"):FindFirstChild(temporaryPoint.Name) then
				local same = 0
				for i, v in pairs(game.Workspace.waypoints:GetChildren()) do
					if v.Name == temporaryPoint.Name then same += 1 end
				end
				local newSame = tostring(same)
				temporaryPoint.Name = temporaryPoint.Name..newSame
			end
			temporaryPoint:WaitForChild("LocalScript").Name = temporaryPoint.Name
			temporaryPoint:WaitForChild(temporaryPoint.Name).Parent = script.Parent
			temporaryPoint.Parent = game.Workspace:WaitForChild("waypoints")
			temporaryPoint.Position = pos
			temporaryPoint.BillboardGui:WaitForChild("Frame").BackgroundColor = BrickColor.random()
			temporaryPoint.Beam.Color = ColorSequence.new(temporaryPoint.BillboardGui.Frame.BackgroundColor3)
			temporaryPoint:WaitForChild("BillboardGui").Enabled = true
		end		
	end
end)