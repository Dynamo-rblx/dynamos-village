-- @ScriptType: Script
while task.wait() do
	if game.Workspace:WaitForChild("Builds"):FindFirstChild("SpawnShack") then
		script.Parent.Enabled = true
	else
		script.Parent.Enabled = false
	end
end