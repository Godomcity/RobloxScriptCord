-- 아이템 폴더 변수
local ItemFolder = script:WaitForChild('ItemsFolder').Value
local Alchole = ItemFolder.Alchole:GetChildren()
local InfectedWater = ItemFolder.InfectedWater:GetChildren()
local Portion = ItemFolder.Portion:GetChildren()
local Radiation = ItemFolder.Radiation:GetChildren()
local WetTissue = ItemFolder.WetTissue:GetChildren()

-- 캐릭터
local player = game.Players.LocalPlayer
local character = player.Character

local CollectItem = require(player.Character:WaitForChild("CollectItemSetup", 5))

-- 알코올 IntValue 생성 함수
local function InstanceAlcoholValue()
	local alcoholvalue = Instance.new("IntValue", player.Character)
	alcoholvalue.Name = "alcoholvalue"
	alcoholvalue.Value = 0
end

-- 방사능 IntValue 생성 함수
local function InstanceRadiationValue()
	local Radiationvalue = Instance.new("IntValue", player.Character)
	Radiationvalue.Name = "Radiation"
	Radiationvalue.Value = 0
end

local function InstanceNilValue()
	local Radiationvalue = Instance.new("IntValue", player.Character)
	Radiationvalue.Name = "Nil"
	Radiationvalue.Value = 0
end

InstanceAlcoholValue()
InstanceRadiationValue()
InstanceNilValue()

local aloValue = character:WaitForChild("alcoholvalue", 5)
local RadiationValue = character:WaitForChild("Radiation", 5)
local nilvalue = character:WaitForChild("Nil", 5)

local function Alchilefolder()
	for i, Alch in pairs(Alchole) do
		Alch.Touched:Connect(function(hit)
			local h = hit.Parent.Name
			if player.Name == h then
				if aloValue ~= nil then
					local name = Alch.Name
					CollectItem.SetupCollectItem(Alch, aloValue, name)
					--aloValue.Value += 1
					--Alch.Transparency = 1
					--Alch.CanTouch = false
					--Alch.CanCollide = false
					--player.PlayerGui.ItemGui.AlcohlFrame.AlcohlText.Text = aloValue.Value
				end
			end
		end)
		--player.Character.Humanoid.Died:Connect(function()
		--	Alch.Transparency = 0
		--	Alch.CanTouch = true
		--	Alch.CanCollide = true
		--end)
	end
end

local function InfectedWaterfolder()
	for i, infected in pairs(InfectedWater) do
		infected.Touched:Connect(function(hit)
			local h = hit.Parent.Name
			if player.Name == h then
				if player.Character:FindFirstChild("ForceField") == nil then
					game.SoundService.Sound:Play()
					player.Character.Humanoid:TakeDamage(100)
				else
					return
				end
				
			end
		end)
	end
end

local function RadiationFolder()
	for i, Rad in pairs(Radiation) do
		Rad.Touched:Connect(function(hit)
			local h = hit.Parent.Name
			if player.Name == h then
				if RadiationValue ~= nil then
					local name = Rad.Name
					CollectItem.SetupCollectItem(Rad, RadiationValue, name)
					--RadiationValue.Value += 1
					--Rad.Transparency = 1
					--Rad.CanTouch = false
					--Rad.CanCollide = false
					--player.PlayerGui.ItemGui.RadiationFrame.RadiationText.Text = RadiationValue.Value
				end
			end
		end)
		--player.Character.Humanoid.Died:Connect(function()
		--	Rad.Transparency = 0
		--	Rad.CanTouch = true
		--	Rad.CanCollide = true
		--end)
	end
end

local function Portionfolder()
	for i, port in pairs(Portion) do
		port.Touched:Connect(function(hit)
			local h = hit.Parent.Name
			if player.Name == h then
				local name = port.Name
				CollectItem.SetupCollectItem(port, nilvalue, name)
				--player.Character.Humanoid.Health += math.random(10, 30)
				--port.Sparkles.Enabled = false
				--port.Transparency = 1
				--port.CanTouch = false
				--port.CanCollide = false
			end
		end)
	--	player.Character.Humanoid.Died:Connect(function()
	--		port.Sparkles.Enabled = true
	--		port.Transparency = 0
	--		port.CanTouch = true
	--		port.CanCollide = true
	--	end)
	end
end

local function WetTissuefolder()
	for i, wet in pairs(WetTissue) do
		wet.Touched:Connect(function(hit)
			local h = hit.Parent.Name
			if player.Name == h then
				local name = wet.Name
				--game.ReplicatedStorage.TowerEvents.WetTissue:FireServer(wet)
				CollectItem.SetupCollectItem(wet, nilvalue, name)
			end
		end)
	end
end


RadiationFolder()
Alchilefolder()
InfectedWaterfolder()
Portionfolder()
WetTissuefolder()