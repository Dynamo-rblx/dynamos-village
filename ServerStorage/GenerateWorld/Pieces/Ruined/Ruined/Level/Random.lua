-- @ScriptType: Script
script.Parent.Value = math.random(1, 3)

if script.Parent.Value == 3 then
	game:GetService("ServerStorage"):WaitForChild("Ruined Clothes"):WaitForChild("DinoHat"):Clone().Parent = script.Parent.Parent
end

if script.Parent.Value == 2 then
	game:GetService("ServerStorage"):WaitForChild("Ruined Clothes"):WaitForChild("SkullCap"):Clone().Parent = script.Parent.Parent
end