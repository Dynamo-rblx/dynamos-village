-- @ScriptType: LocalScript
repeat task.wait() until game:IsLoaded()

script.Parent.Parent.Parent:WaitForChild("theme").Changed:Connect(function()
	task.wait()
	script.Parent.TextColor3 = script.Parent.Parent.Parent:WaitForChild("theme"):FindFirstChild(script.Parent.Parent.Parent.theme.Value).headerColor.Value
end)