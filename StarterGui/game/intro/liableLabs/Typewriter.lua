-- @ScriptType: LocalScript
game:GetService("ReplicatedStorage"):WaitForChild("realIntro").OnClientEvent:Wait()
function Type(GUI, txt)
	for i = 1, #txt, 1 do
	task.wait()
		GUI.Text = string.sub(txt, 1, i)
	end
end

-- Intro --
repeat task.wait() until game:IsLoaded()
task.wait(3)

script["starting up"]:Play()
Type(script.Parent, "A Liable Labs Production")
task.wait(2)
repeat task.wait() script.Parent.Transparency += 0.1 until script.Parent.Transparency == 1