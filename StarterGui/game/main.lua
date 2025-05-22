-- @ScriptType: LocalScript
game:GetService("ReplicatedStorage"):WaitForChild("realIntro").OnClientEvent:Wait()
script.Parent.Enabled = true
script.Parent.Parent:WaitForChild("Barrier").Enabled = false
script.Parent.Parent:WaitForChild("Barrier"):Destroy()
-- INTRO

local intro = script.Parent:WaitForChild("intro")
intro.Visible = true
local hdLogo = intro:WaitForChild("HD")
local TW = game:GetService("TweenService")
local hdColorTween = TW:Create(intro,TweenInfo.new(1),{BackgroundColor3=Color3.fromRGB(255, 64, 64)})
local fadeOutColorTween = TW:Create(intro,TweenInfo.new(1),{BackgroundColor3=Color3.fromRGB(0, 0, 0)})
local titleColorTween = TW:Create(intro,TweenInfo.new(1),{BackgroundColor3=Color3.fromRGB(54, 141, 64)})
local titleBGTween = TW:Create(intro:WaitForChild("titleBg"), TweenInfo.new(1), {ImageTransparency=0.5})

repeat task.wait() until game:IsLoaded()

task.wait(7)

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All,false)
game.StarterGui:SetCore("ResetButtonCallback",false)
script.Parent.gameFrame.Position = UDim2.new(-1,0,0,0)

local function intro()

	hdLogo.Position = UDim2.new(1,0,0.5,0)
	
	hdColorTween:Play()
	script.hdSwish:Play()
	hdLogo:TweenPosition(UDim2.new(0.286, 0,0.5, 0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.5)
	task.wait(2)
	hdLogo:TweenPosition(UDim2.new(-0.5, 0,0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.3)
	fadeOutColorTween:Play()
	task.wait(4)
	titleColorTween:Play()
	titleBGTween:Play()
	script.Parent.intro.gameTitle.Visible = true
	script.Parent.sound.Enabled = true
	script.Parent.intro.gameTitle:TweenSizeAndPosition(UDim2.new(0.54,0,0.473,0), UDim2.new(0.5,0,0.5,0), Enum.EasingDirection.In, Enum.EasingStyle.Linear,0.2)
	task.wait(10)
	script.Parent.intro.gameTitle:TweenSizeAndPosition(UDim2.new(0.001,0,0,0.001), UDim2.new(0.5,0,0.5,0), Enum.EasingDirection.In, Enum.EasingStyle.Linear,0.2)
	script.Parent.intro:TweenPosition(UDim2.new(0,0,-1,0),Enum.EasingDirection.In, Enum.EasingStyle.Linear,1.3)
	script.Parent.intro.Visible = false
end

local function initiateGame()
	script.Parent.homeMenu:TweenPosition(UDim2.new(1,0,0,0), Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.5)
	script.Parent.gameFrame:TweenPosition(UDim2.new(0,0,0,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.5)
	script.Parent.currentPage.Value = script.Parent.gameFrame
end

local function terminateGame()
	script.Parent.gameFrame:TweenPosition(UDim2.new(-1,0,0,0), Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.5)
	script.Parent.homeMenu:TweenPosition(UDim2.new(0,0,0,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.5)
	script.Parent.currentPage.Value = script.Parent.homeMenu
end

script.Parent.playing.Changed:Connect(function(val)
	if val == true then
		initiateGame()
	else
		terminateGame()
	end
end)

intro()
script.Parent:WaitForChild("currentPage").Value = script.Parent.homeMenu