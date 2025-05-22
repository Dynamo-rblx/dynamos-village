-- @ScriptType: Script
local tps = game:GetService("TeleportService")
local placeId = 123456789 -- Place id here (Replace 123456789 to your Main Game Id)


game.ReplicatedStorage.PartySystemRE.OnServerEvent:Connect(function(player, instruction, value1, value2)
	
	
	if instruction == "kickPlayer" then
		
		if game.ReplicatedStorage.Parties:FindFirstChild(value1) and value2.Parent == game.ReplicatedStorage.Parties[value1].Players then
			if game.ReplicatedStorage.Parties[value1].Players["Party Leader"].Value == player.Name or value2.Value == player.Name then
				
				if game.ReplicatedStorage.Parties[value1].Players["Party Leader"].Value == value2.Value then
					
					for i, playerInParty in pairs(game.ReplicatedStorage.Parties[value1].Players:GetChildren()) do
						
						game.ReplicatedStorage.PartySystemRE:FireClient(game.Players[playerInParty.Value], false, value1)
					end
					
					game.ReplicatedStorage.Parties[value1]:Destroy()
					
				else
					
					game.ReplicatedStorage.PartySystemRE:FireClient(game.Players[value2.Value], false, value1)
					
					value2:Destroy()
				end
			end
		end
		
		
	elseif instruction == "createParty" then
		
		local partyName = value1 or player.Name .. "'s Party"		
		partyName = game:GetService("TextService"):FilterStringAsync(partyName, player.UserId)
		partyName = partyName:GetNonChatStringForBroadcastAsync()
		
		local newParty = Instance.new("Folder")
		newParty.Name = partyName
		
		local players = Instance.new("Folder", newParty)
		players.Name = "Players"
		
		local partyLeader = Instance.new("StringValue", players)
		partyLeader.Name = "Party Leader"
		partyLeader.Value = player.Name
		
		local limit = Instance.new("IntValue", newParty)
		limit.Name = "PlayerLimit"
		limit.Value = tonumber(value2) or 10
		
		newParty.Parent = game.ReplicatedStorage.Parties
		
		game.ReplicatedStorage.PartySystemRE:FireClient(player, true, partyName)
		
		
	elseif instruction == "joinParty" then
		
		if game.ReplicatedStorage.Parties:FindFirstChild(value1) and #game.ReplicatedStorage.Parties[value1].Players:GetChildren() < game.ReplicatedStorage.Parties[value1].PlayerLimit.Value then
			
			local playerValue = Instance.new("StringValue")
			playerValue.Value = player.Name
			playerValue.Parent = game.ReplicatedStorage.Parties[value1].Players
			
			game.ReplicatedStorage.PartySystemRE:FireClient(player, true, value1)
		end
		
		
	elseif instruction == "startParty" then
		
		if game.ReplicatedStorage.Parties:FindFirstChild(value1) and game.ReplicatedStorage.Parties[value1].Players["Party Leader"].Value == player.Name then
			
			local playersToTP = {}
			
			for i, playerInParty in pairs(game.ReplicatedStorage.Parties[value1].Players:GetChildren()) do
				
				table.insert(playersToTP, game.Players[playerInParty.Value])
			end
			
			
			local tpOptions = Instance.new("TeleportOptions")
			tpOptions.ShouldReserveServer = true
			
			tps:TeleportAsync(placeId, playersToTP, tpOptions)
		end
	end
end)


game.Players.PlayerRemoving:Connect(function(player)
	
	for i, d in pairs(game.ReplicatedStorage.Parties:GetDescendants()) do
		
		if d:IsA("StringValue") and d.Value == player.Name then
			
			if d.Name == "Party Leader" then

				for i, playerInParty in pairs(d.Parent:GetChildren()) do

					game.ReplicatedStorage.PartySystemRE:FireClient(game.Players[playerInParty.Value], false, d.Parent.Parent.Name)
				end
				
				d.Parent.Parent:Destroy()

			else

				game.ReplicatedStorage.PartySystemRE:FireClient(player, false, d.Parent.Parent.Name)

				d.Parent.Parent:Destroy()
			end
		end
	end
end)