-- @ScriptType: LocalScript
script.Parent.PartyGuiFrame.Visible = false
script.Parent.PartyGuiFrame.PartyListFrame.Visible = true
script.Parent.PartyGuiFrame.CreateFrame.PartyNameBox.Text = game.Players.LocalPlayer.Name .. "'s Guild"


script.Parent.PartyButton.MouseButton1Click:Connect(function()
	
	script.Parent.PartyGuiFrame.Visible = not script.Parent.PartyGuiFrame.Visible
end)


local creatingParty = false
local inParty = false

script.Parent.PartyGuiFrame.CreateButton.MouseButton1Click:Connect(function()
	
	if inParty then return end
	
	creatingParty = not creatingParty
	
	if creatingParty then
		
		script.Parent.PartyGuiFrame.CreateButton.Text = "Return"
		
		script.Parent.PartyGuiFrame.CreateFrame.Visible = true
		script.Parent.PartyGuiFrame.PartyListFrame.Visible = false
		
	else
		
		script.Parent.PartyGuiFrame.CreateButton.Text = "Create Guild"
		
		script.Parent.PartyGuiFrame.PartyListFrame.Visible = true
		script.Parent.PartyGuiFrame.CreateFrame.Visible = false
	end
end)



game.ReplicatedStorage.PartySystemRE.OnClientEvent:Connect(function(joiningParty, partyName)
	
	inParty = joiningParty and true or false
	
	if inParty then	
		
		script.Parent.PartyGuiFrame.PartyFrame.PartyTitle.Text = partyName
		
		script.Parent.PartyGuiFrame.PartyFrame.Visible = true
		script.Parent.PartyGuiFrame.PartyListFrame.Visible = false
		script.Parent.PartyGuiFrame.CreateButton.Visible = false
		
		local function displayPlayers()
			
			for i, child in pairs(script.Parent.PartyGuiFrame.PartyFrame.PlayerList:GetChildren()) do
				if child:IsA("Frame") then
					child:Destroy()
				end
			end
			
			for i, player in pairs(game.ReplicatedStorage.Parties[partyName].Players:GetChildren()) do
				
				local template = script.PlayerTemplate:Clone()
				template.PlayerName.Text = player.Value
				
				if game.Players.LocalPlayer.Name ~= game.ReplicatedStorage.Parties[partyName].Players["Party Leader"].Value and game.Players.LocalPlayer.Name ~= player.Value then
					template.LeaveButton:Destroy()
					print("e")
				else
					
					template.LeaveButton.MouseButton1Click:Connect(function()
						game.ReplicatedStorage.PartySystemRE:FireServer("kickPlayer", partyName, player)
					end)
				end
				
				template.Parent = script.Parent.PartyGuiFrame.PartyFrame.PlayerList
				
				script.Parent.PartyGuiFrame.PartyFrame.PlayerList.CanvasSize = UDim2.new(0, 0, 0, script.Parent.PartyGuiFrame.PartyFrame.PlayerList.UIListLayout.AbsoluteContentSize.Y)
			end
		end
		
		displayPlayers()
		game.ReplicatedStorage.Parties[partyName].Players.ChildAdded:Connect(displayPlayers)
		game.ReplicatedStorage.Parties[partyName].Players.ChildRemoved:Connect(displayPlayers)
		
	else		
		script.Parent.PartyGuiFrame.PartyListFrame.Visible = true
		script.Parent.PartyGuiFrame.PartyFrame.Visible = false
		script.Parent.PartyGuiFrame.CreateButton.Visible = true
	end
end)


script.Parent.PartyGuiFrame.PartyFrame.StartButton.MouseButton1Click:Connect(function()
	creatingParty = false
	script.Parent.PartyGuiFrame.CreateButton.Text = "Create Guild"
	script.Parent.PartyGuiFrame.Visible = false
end)


script.Parent.PartyGuiFrame.CreateFrame.ConfirmButton.MouseButton1Click:Connect(function()
	
	local partyName = script.Parent.PartyGuiFrame.CreateFrame.PartyNameBox.Text or game.Players.LocalPlayer.Name .. "'s Guild"
	local playerLimit = tonumber(script.Parent.PartyGuiFrame.CreateFrame.PlayerLimitBox.Text) or 10
	
	game.ReplicatedStorage.PartySystemRE:FireServer("createParty", partyName, playerLimit)
	
	creatingParty = false
	script.Parent.PartyGuiFrame.CreateButton.Text = "Create Guild"
	script.Parent.PartyGuiFrame.PartyListFrame.Visible = true
	script.Parent.PartyGuiFrame.CreateFrame.Visible = false
end)


function updatePartyList()
	
	for i, child in pairs(script.Parent.PartyGuiFrame.PartyListFrame:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
	
	for i, party in pairs(game.ReplicatedStorage.Parties:GetChildren()) do
		
		local partyName = party.Name
		local playerLimit = party:WaitForChild("PlayerLimit").Value
		local playerCount = #party.Players:GetChildren()
		
		local template = script.PartyTemplate:Clone()
		template.PartyName.Text = partyName
		template.PlayerCount.Text = playerCount .. "/" .. playerLimit
		
		party.Players.ChildAdded:Connect(function() template.PlayerCount.Text = #party.Players:GetChildren() .. "/" .. playerLimit end)
		party.Players.ChildRemoved:Connect(function() template.PlayerCount.Text = #party.Players:GetChildren() .. "/" .. playerLimit end)
		
		template.Parent = script.Parent.PartyGuiFrame.PartyListFrame
		
		script.Parent.PartyGuiFrame.PartyListFrame.CanvasSize = UDim2.new(0, 0, 0, script.Parent.PartyGuiFrame.PartyListFrame.UIListLayout.AbsoluteContentSize.Y)
		
		
		template.JoinButton.MouseButton1Click:Connect(function()
			
			game.ReplicatedStorage.PartySystemRE:FireServer("joinParty", partyName)
		end)
	end
end

updatePartyList()
game.ReplicatedStorage.Parties.ChildAdded:Connect(updatePartyList)
game.ReplicatedStorage.Parties.ChildRemoved:Connect(updatePartyList)