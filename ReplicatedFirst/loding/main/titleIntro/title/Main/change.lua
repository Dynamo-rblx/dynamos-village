-- @ScriptType: LocalScript
while true do
	for _, font in pairs(Enum.Font:GetEnumItems()) do
		script.Parent.Parent.Font = font
		local t = math.random(1, string.len(script.Parent.Parent.Text))
		local l = string.sub(script.Parent.Parent.Text, t, t)
		if math.random(1,2) == 1 then
			l:upper()
		else
			l:lower()
		end
		task.wait(0.1)
	end
end