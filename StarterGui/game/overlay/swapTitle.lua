-- @ScriptType: LocalScript
script.Parent.Parent.currentPage.Changed:Connect(function()
	print("page changed")
	script.Parent.pageTitle:TweenPosition(UDim2.new(0,0,-0.13,0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.3)
	task.wait(0.4)
	script.Parent.pageTitle.Text = script.Parent.Parent.currentPage.Value:FindFirstChild("pageName").Value
	script.Parent.pageTitle:TweenPosition(UDim2.new(0,0,0,0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.3, true)
	print("tweened back")
end)