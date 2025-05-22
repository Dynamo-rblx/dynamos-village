-- @ScriptType: Script
local folder = game:GetService("ServerStorage"):WaitForChild("GenerateWorld")
local Pieces = folder:WaitForChild("Pieces"):GetChildren()
local prev = game.Workspace
local spawnBlock = game.Workspace:WaitForChild('SpawnLocation')
local t = {}
local ruined = 0

for i, p in pairs(folder:WaitForChild("Pieces"):GetChildren()) do
	print("Start Cloning")
	print(p.Name .."-".. p:WaitForChild("Rarity").Value)
	for i = 1, p:WaitForChild("Rarity").Value, 1 do
		table.insert(t, p.Name)
		task.wait()
	end
end
print(t)

local point = Vector3.new(0,0,0)

local function findPlainSpots()
	local tempAvailable = game.Workspace:WaitForChild("Choices"):GetChildren()
	local safeSpot = tempAvailable[math.random(1, #tempAvailable)]
	
	if safeSpot.Name == "Plain" then
		return safeSpot
	else
		return findPlainSpots()
	end
end

for i = 1, 40, 1 do
	for j = 1, 40, 1 do
		repeat
			print("choosing new")
			choice = folder:WaitForChild("Pieces"):FindFirstChild(t[math.random(1, #t)])
			
			if choice.Name == "Ruined" then
				if ruined < 10 then
					ruined += 1
				else
					choice = folder:WaitForChild("Pieces"):FindFirstChild("Plain")
				end
			end
			
		until choice ~= prev
		
		prev = choice
		local temp = choice:Clone()
		temp.Parent = game.Workspace:WaitForChild("Choices")
		temp:SetPrimaryPartCFrame(CFrame.new(i*50,0,j*50) * CFrame.Angles(0, math.rad(90 * math.random(-2, 2),0), 0))
		temp.PrimaryPart.Orientation = Vector3.new(0,0,0)
	end
end



local start = folder:WaitForChild("Buildings"):WaitForChild("SpawnShack"):Clone()
local shackSpawn = findPlainSpots()
start:SetPrimaryPartCFrame(CFrame.new(shackSpawn.PrimaryPart.Position + Vector3.new(0, 9, 0)))
spawnBlock.Position = shackSpawn.PrimaryPart.Position + Vector3.new(1, 1, 0)
start.Parent = game.Workspace:WaitForChild("Builds")