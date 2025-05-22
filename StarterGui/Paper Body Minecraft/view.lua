-- @ScriptType: LocalScript
task.wait(10)
char = game.Players.LocalPlayer.Character
cam = Instance.new("Camera",script.Parent)

game:GetService("RunService").RenderStepped:Connect(function()
	for i,v in pairs(script.Parent.ViewportFrame.Character1:GetDescendants()) do
		v:Destroy()
	end
	for i,v in pairs(char:GetChildren()) do
	local v2 = v:Clone()
	if v2:IsA("Script") or v2:IsA("LocalScript") or v2:IsA("ModuleScript") then
		v2:Destroy()
	else
	v2.Parent = script.Parent.ViewportFrame.Character1
	if v2:IsA("Humanoid") then
		v2.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	end
	end



end
	script.Parent.ViewportFrame.CurrentCamera = cam
	cam.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,3,-5) *  CFrame.Angles(math.rad(30),math.rad(180),0)
end)