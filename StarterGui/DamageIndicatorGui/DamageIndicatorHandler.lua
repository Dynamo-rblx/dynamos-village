-- @ScriptType: LocalScript
local gui = script.Parent
local indicator = script:WaitForChild("DamageIndicator")

local remote = game:GetService("ReplicatedStorage"):WaitForChild("DamageIndicatorReplicatedStorage"):WaitForChild("DamageEvent")

local tweenService = game:GetService("TweenService")
local indicatorFadeTI = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

local camera = workspace.CurrentCamera

local timeAfterIndicatorExpires = 5



function getCentreCF(object:Instance)
	
	local instanceCF = object.CFrame
	
	local pos = instanceCF.Position
	local lookAt = instanceCF.LookVector * Vector3.new(1, 0, 1)
	
	local centreCF = CFrame.new(pos, pos + (lookAt))
	
	return centreCF
end

function calculateAngle(centre:CFrame, point:Vector3)
	
	local damageDir = centre:PointToObjectSpace(point)

	local theta = math.atan2(damageDir.Z, damageDir.X)
	local angleInDegrees = math.deg(theta) + 90
	
	return angleInDegrees
end

function damageDealt(originOfDamage:Vector3)
	
	local centreCF = getCentreCF(camera)
	local angleInDegrees = calculateAngle(centreCF, originOfDamage)
	
	local newIndicator = indicator:Clone()
	newIndicator.DamageIndicatorImage.ImageTransparency = 0
	newIndicator.Visible = true
	
	newIndicator.Rotation = angleInDegrees
	
	newIndicator.Parent = gui
	
	
	task.spawn(function()
		while newIndicator and newIndicator.Parent == gui do
			
			local centreCF = getCentreCF(camera)
			local angleInDegrees = calculateAngle(centreCF, originOfDamage)
			
			newIndicator.Rotation = angleInDegrees
			
			game:GetService("RunService").Heartbeat:Wait()
		end
	end)
	
	
	task.wait(timeAfterIndicatorExpires)
	
	local indicatorFadeTween = tweenService:Create(newIndicator.DamageIndicatorImage, indicatorFadeTI, {ImageTransparency = 1})
		
	indicatorFadeTween:Play()
	indicatorFadeTween.Completed:Wait()
		
	newIndicator:Destroy()
end


remote.OnClientEvent:Connect(damageDealt)