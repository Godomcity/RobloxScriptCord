local pointManager = require(game.ReplicatedStorage.PointManager)
local DeliveryPointManager = pointManager.Get("Delivery")


local function ClearDelivery(player:Player)
	if(player.Character.Deliveryman.CurrentPackage.Value ~= nil) then
		player.Character.Deliveryman.CurrentPackage.Value:Destroy()
		player.Character.Deliveryman.CurrentPackage.Value = nil

	end

end


--DeliveryPointManager:DeleteAll()
local function MissionCompleted(player)
	--if player.Character.Package:GetAttribute("Ranking") == "Beginner" then
	--	--DeliveryPointManager:IncreaseValue(player,1)	
	--	player.Character.Deliveryman.CurrentPackage.Value:Destroy()
	--	player.Character.Deliveryman.CurrentPackage.Value = nil
	--	print("Delivery Completed","Server")
	--elseif player.Character.Package:GetAttribute("Ranking") == "Challenge" then
	--	--DeliveryPointManager:IncreaseValue(player,5)
	--	player.Character.Deliveryman.CurrentPackage.Value:Destroy()
	--	player.Character.Deliveryman.CurrentPackage.Value = nil
	--	print("Delivery Completed","Server")
	--elseif player.Character.Package:GetAttribute("Ranking") == "Champion" then
	--	--DeliveryPointManager:IncreaseValue(player,10)	
	--	player.Character.Deliveryman.CurrentPackage.Value:Destroy()
	--	player.Character.Deliveryman.CurrentPackage.Value = nil
	--	print("Delivery Completed","Server")
	--end
	
	local coin = 0
	
	
	if player.Character:FindFirstChild("Package") ~= nil then
		if player.Character.Package:GetAttribute("Ranking") == "Beginner" then	
			coin = 1	
		elseif  player.Character.Package:GetAttribute("Ranking") == "Challenge" then	
			coin = 2	
		elseif player.Character.Package:GetAttribute("Ranking") == "Champion" then	
			coin = 3 
		end
	end
	
	if(coin ~= 0) then
		DeliveryPointManager:IncreaseValue(player,coin)
	end	
	
	ClearDelivery(player)

	print("Delivery Completed","Server")
	
end


local function ExitGame(player:Player)
	
	ClearDelivery(player)
	
	--player.Character.Deliveryman.CurrentPackage.Value:Destroy()
	--player.Character.Deliveryman.CurrentPackage.Value = nil
end

game.ReplicatedStorage.Delivery.ServerEvents.MissionCompleted.OnServerEvent:Connect(MissionCompleted)

game.ReplicatedStorage:WaitForChild("ExitDelivery").OnServerEvent:Connect(ExitGame)