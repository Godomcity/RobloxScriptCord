local replicatedStorage = game.ReplicatedStorage

local RemoteEventFolder = game.ReplicatedStorage.SpawnHouseCar

local White = game.ReplicatedStorage.SpawnHouseCar.White.NiroEV

local Black = game.ReplicatedStorage.SpawnHouseCar.Black.NiroEV

local Blue = game.ReplicatedStorage.SpawnHouseCar.Blue.NiroEV

local Gray = game.ReplicatedStorage.SpawnHouseCar.Gray.NiroEV

local Green = game.ReplicatedStorage.SpawnHouseCar.Green.NiroEV

local Red = game.ReplicatedStorage.SpawnHouseCar.Red.NiroEV

local InterstellarGray = game.ReplicatedStorage.SpawnHouseCar.InterstellarGray.NiroEV

RemoteEventFolder.WhiteCar.OnServerEvent:Connect(function(player:Player, plrname)
	local gearname = "NiroEV"

	local playerfolder = Instance.new("Folder")
	local FindPlayerNameFolder = workspace:FindFirstChild(player.Name.."Car")
	
	if FindPlayerNameFolder == nil then
		playerfolder.Parent = workspace
		playerfolder.Name = player.Name.."Car"
	end
	
	local target = workspace:FindFirstChild(player.Name.."Car"):FindFirstChild(gearname)
	if target ~= nil then
		target:Destroy()
	else if target == nil then
			local Car:Model = White:Clone()
			for i, foldername in pairs(workspace:GetChildren()) do
				if foldername.Name == player.Name.."Car" then
					Car.Parent = foldername
				end
			end
			Car:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame + Vector3.new(10,0,0))
			Car:SetAttribute("PlayerName", plrname)
		end
	end
end)

RemoteEventFolder.BlackCar.OnServerEvent:Connect(function(player:Player, plrname)
	local gearname = "NiroEV"

	local playerfolder = Instance.new("Folder")
	local FindPlayerNameFolder = workspace:FindFirstChild(player.Name.."Car")

	if FindPlayerNameFolder == nil then
		playerfolder.Parent = workspace
		playerfolder.Name = player.Name.."Car"
	end

	local target = workspace:FindFirstChild(player.Name.."Car"):FindFirstChild(gearname)
	if target ~= nil then
		target:Destroy()
	else if target == nil then
			local Car:Model = Black:Clone()
			for i, foldername in pairs(workspace:GetChildren()) do
				if foldername.Name == player.Name.."Car" then
					Car.Parent = foldername
				end
			end
			Car:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame + Vector3.new(10,0,0))
			Car:SetAttribute("PlayerName", plrname)
		end
	end
end)

RemoteEventFolder.BlueCar.OnServerEvent:Connect(function(player:Player, plrname)
	local gearname = "NiroEV"

	local playerfolder = Instance.new("Folder")
	local FindPlayerNameFolder = workspace:FindFirstChild(player.Name.."Car")

	if FindPlayerNameFolder == nil then
		playerfolder.Parent = workspace
		playerfolder.Name = player.Name.."Car"
	end

	local target = workspace:FindFirstChild(player.Name.."Car"):FindFirstChild(gearname)
	if target ~= nil then
		target:Destroy()
	else if target == nil then
			local Car:Model = Blue:Clone()
			for i, foldername in pairs(workspace:GetChildren()) do
				if foldername.Name == player.Name.."Car" then
					Car.Parent = foldername
				end
			end
			Car:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame + Vector3.new(10,0,0))
			Car:SetAttribute("PlayerName", plrname)
		end
	end
end)

RemoteEventFolder.GrayCar.OnServerEvent:Connect(function(player:Player, plrname)
	local gearname = "NiroEV"

	local playerfolder = Instance.new("Folder")
	local FindPlayerNameFolder = workspace:FindFirstChild(player.Name.."Car")

	if FindPlayerNameFolder == nil then
		playerfolder.Parent = workspace
		playerfolder.Name = player.Name.."Car"
	end

	local target = workspace:FindFirstChild(player.Name.."Car"):FindFirstChild(gearname)
	if target ~= nil then
		target:Destroy()
	else if target == nil then
			local Car:Model = Gray:Clone()
			for i, foldername in pairs(workspace:GetChildren()) do
				if foldername.Name == player.Name.."Car" then
					Car.Parent = foldername
				end
			end
			Car:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame + Vector3.new(10,0,0))
			Car:SetAttribute("PlayerName", plrname)
		end
	end
end)

RemoteEventFolder.GreenCar.OnServerEvent:Connect(function(player:Player, plrname)
	local gearname = "NiroEV"

	local playerfolder = Instance.new("Folder")
	local FindPlayerNameFolder = workspace:FindFirstChild(player.Name.."Car")

	if FindPlayerNameFolder == nil then
		playerfolder.Parent = workspace
		playerfolder.Name = player.Name.."Car"
	end

	local target = workspace:FindFirstChild(player.Name.."Car"):FindFirstChild(gearname)
	if target ~= nil then
		target:Destroy()
	else if target == nil then
			local Car:Model = Green:Clone()
			for i, foldername in pairs(workspace:GetChildren()) do
				if foldername.Name == player.Name.."Car" then
					Car.Parent = foldername
				end
			end
			Car:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame + Vector3.new(10,0,0))
			Car:SetAttribute("PlayerName", plrname)
		end
	end
end)

RemoteEventFolder.RedCar.OnServerEvent:Connect(function(player:Player, plrname)
	local gearname = "NiroEV"

	local playerfolder = Instance.new("Folder")
	local FindPlayerNameFolder = workspace:FindFirstChild(player.Name.."Car")

	if FindPlayerNameFolder == nil then
		playerfolder.Parent = workspace
		playerfolder.Name = player.Name.."Car"
	end

	local target = workspace:FindFirstChild(player.Name.."Car"):FindFirstChild(gearname)
	if target ~= nil then
		target:Destroy()
	else if target == nil then
			local Car:Model = Red:Clone()
			for i, foldername in pairs(workspace:GetChildren()) do
				if foldername.Name == player.Name.."Car" then
					Car.Parent = foldername
				end
			end
			Car:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame + Vector3.new(10,0,0))
			Car:SetAttribute("PlayerName", plrname)
		end
	end
end)

RemoteEventFolder.InGrayCar.OnServerEvent:Connect(function(player:Player, plrname)
	local gearname = "NiroEV"

	local playerfolder = Instance.new("Folder")
	local FindPlayerNameFolder = workspace:FindFirstChild(player.Name.."Car")

	if FindPlayerNameFolder == nil then
		playerfolder.Parent = workspace
		playerfolder.Name = player.Name.."Car"
	end

	local target = workspace:FindFirstChild(player.Name.."Car"):FindFirstChild(gearname)
	if target ~= nil then
		target:Destroy()
	else if target == nil then
			local Car:Model = InterstellarGray:Clone()
			for i, foldername in pairs(workspace:GetChildren()) do
				if foldername.Name == player.Name.."Car" then
					Car.Parent = foldername
				end
			end
			Car:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame + Vector3.new(10,0,0))
			Car:SetAttribute("PlayerName", plrname)
		end
	end
end)

