-- @ScriptType: LocalScript
local tI = TweenInfo.new(2)
local tI2 = TweenInfo.new(4)
local t = game:GetService("TweenService")
local twen1 = t:Create(script.Parent.Parent,tI,{BackgroundTransparency=1})
local twen2 = t:Create(script.Parent,tI,{TextTransparency=1})

function Type(GUI, txt)
	for i = 1, #txt do
		wait()
		GUI.Text = string.sub(txt, 1, i)
	end
end

-- Intro --
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
script.change.Enabled = true
script.Sound:Play()
Type(script.Parent, "Loading")
task.wait(15)
script.Parent.TextColor3 = Color3.fromRGB(255, 68, 35)
script.change.Enabled = false
script.Parent.Font = Enum.Font.Code
Type(script.Parent, "Have Fun!")
task.wait(15)
twen2:Play()
twen1:Play()
twen1.Completed:Wait()
task.wait(0.04)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
game.ReplicatedStorage:WaitForChild("realIntro"):FireServer()
script.Parent.Parent.Parent:Destroy()

