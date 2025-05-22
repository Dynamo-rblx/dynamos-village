-- @ScriptType: LocalScript
script.Parent.MouseEnter:Connect(function()
	script.Parent.Text = "<u>Skip</u> >>"
end)

script.Parent.MouseLeave:Connect(function()
	script.Parent.Text = "Skip >>"
end)

script.Parent.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild("realIntro"):FireServer()
	script.Parent.Parent.Parent:Destroy()
end)