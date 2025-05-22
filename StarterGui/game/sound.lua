-- @ScriptType: LocalScript
while true do
	task.wait()
	script:FindFirstChildOfClass("Sound").Playing = true
	
	for i, v in pairs(script.inactive:GetChildren()) do
		v.Playing = false
		v.TimePosition = 0
	end
end