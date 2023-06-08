--// Service //--
local TweenService = game:GetService("TweenService")
----



--// Presetup //--

----



--// Types //--

----



--// Constants //--


-- Ŭ���̾�Ʈ�� �ش��ϴ� �÷��̾�.
local player = game.Players.LocalPlayer
if not player.Character then player.CharacterAdded:Wait() end
local LocalCharacter = player.Character

-- ���� �����ϴ� ���� ��ġ
local ZombieWater = game.ReplicatedStorage.UpPart

local StartPart = workspace.StartPart


local ZombieAnimation = LocalCharacter:WaitForChild("ZombieAnimation_v2")
local ZombieSpawnScript = LocalCharacter:WaitForChild("ZombieSpawnScript_v2")


local fUpPartCheckPoint = workspace.Towers.ZombieTower.UpPartCheckPoint


----



--// Remotes //--

----



--// Modules //--

----



--// Variables //--
-- ĳ�̿� ����
local Cached_ZombieWater: BasePart
----



--// Functions //--


local function SetDifficulty(plusTime: number, goal: {}, tweenInfo: TweenInfo, tween: Tween)
	
	-- üũ ����Ʈ�� �������� ��� ���� üũ����Ʈ�� Cached_ZombieWater�� tweenPosition�� ����
	for _, checkpoint: BasePart in pairs(fUpPartCheckPoint:GetChildren()) do
		local debounce = false
		local checkpointConnection: RBXScriptConnection
		checkpointConnection = checkpoint.Touched:Connect(function(coll)
			if debounce then return end
			local character = coll.Parent
			if not character then return end
			local Humanoid = character:FindFirstChildOfClass('Humanoid')
			if not Humanoid then return end
			if character.Name ~= LocalCharacter.Name then return end


			checkpointConnection:Disconnect()
			debounce = true


			local nameTable = string.split(checkpoint.Name, '-')

			local nextCheckpointNumber: string = string.format("%0.2i", tonumber(nameTable[2]) + 1)
			local nextCheckpointName = 'Checkpoint-' .. nextCheckpointNumber
			local nextCheckpoint: BasePart = fUpPartCheckPoint:FindFirstChild(nextCheckpointName)
			warn('[Server] nextCheckpoint: ' .. nextCheckpointName)

			tween:Pause()


			--  comment: ���̵��� 30�� ������ ������ ��
			local defaultTime = 420
			if nextCheckpoint then
				goal.Position = nextCheckpoint.CFrame.Position
				tweenInfo = TweenInfo.new(defaultTime+plusTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			end

			if nextCheckpointName == 'Checkpoint-02' then
				tweenInfo = TweenInfo.new(defaultTime+plusTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			end
			if nextCheckpointName == 'Checkpoint-03' then
				tweenInfo = TweenInfo.new(600+plusTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			end
			if nextCheckpointName == 'Checkpoint-04' then
				tweenInfo = TweenInfo.new(480+plusTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			end
			if nextCheckpointName == 'Checkpoint-05' then
				tweenInfo = TweenInfo.new(330+plusTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			end
			if nextCheckpointName == 'Checkpoint-06' then
				tweenInfo = TweenInfo.new(450+plusTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			end
			if nextCheckpointName == 'Checkpoint-07' then
				tweenInfo = TweenInfo.new(380+plusTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			end
			if nextCheckpointName == 'Checkpoint-08' then
				tweenInfo = TweenInfo.new(420+plusTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			end
			if nextCheckpointName == 'Checkpoint-09' then
				tweenInfo = TweenInfo.new(450+plusTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			end
			if nextCheckpointName == 'Checkpoint-10' then
				tweenInfo = TweenInfo.new(390+plusTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			end
			if nextCheckpointName == 'Checkpoint-11' then
				tweenInfo = TweenInfo.new(defaultTime+plusTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			end

			if not nextCheckpoint then
				tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
				goal.Position = Vector3.new(-948, 904, -15)
			end


			tween = TweenService:Create(Cached_ZombieWater, tweenInfo, goal)
			tween:Play()


			debounce = false
		end)
	end
end


-- ��Ʈ�� �����ϰ� ���� �Լ��� ����� ���.
--  ����: hit -> RigPart: BasePart
--local function RunTweenZombieWater(hit)
local function RunTweenZombieWater(RigPart: BasePart)

	local zombieWaterPart = workspace:FindFirstChild("UpPart")
	if zombieWaterPart == nil then
		--  ����: Cached_ZombieWater�� Ŭ�е� ���� ĳ��
		Cached_ZombieWater = ZombieWater:Clone()
		Cached_ZombieWater.Parent = workspace
		Cached_ZombieWater.Name = "UpPart"
		Cached_ZombieWater.Position = Vector3.new(-948, -1000, -15)
		Cached_ZombieWater.Size = Vector3.new(100,2000,100)
		Cached_ZombieWater.Anchored = true
		--zombieWaterPart = ZombieWater:Clone()
		--zombieWaterPart.Name = "UpPart"
		--zombieWaterPart.Position = Vector3.new(-948, -1000, -15)
		--zombieWaterPart.Size = Vector3.new(150,2000,150)
		--zombieWaterPart.Anchored = true
		--zombieWaterPart.Parent = game.Workspace

		local goal = {}
		--goal.Position = Vector3.new(-948, -500, -15)
		goal.Position = fUpPartCheckPoint["Checkpoint-01"].CFrame.Position
		--goal.Size = Vector3.new(150, 2000, 150)
		--  ����: ���� �ö���� �ӵ� ������ ����
		--local tweenInfo = TweenInfo.new(420)
		local tweenInfo = TweenInfo.new(480, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
		local tween = TweenService:Create(Cached_ZombieWater, tweenInfo, goal)
		tween:Play()

		ZombieAnimation.Enabled = false
		ZombieSpawnScript.Enabled = true
		StartPart.CanTouch = false


		-- ���̵� Enum ���� (�� ���� �ð� ����)
		local Difficalty = {
			Easy = 240,
			Normal = 180,
			Hard = 0,
			Hell = -10,
		}
		--SetDifficulty(Difficalty.Hard, goal, tweenInfo, tween)
		SetDifficulty(Difficalty.Easy, goal, tweenInfo, tween)



		local zombieWaterTouchedConnection: RBXScriptConnection
		zombieWaterTouchedConnection = Cached_ZombieWater.Touched:Connect(function(hi)
			--  ����: player.Name -> LocalCharacter.Name
			--local hnam = hi.Parent.Name
			--if hnam == player.Name then
			local characterName = hi.Parent.Name
			if characterName == LocalCharacter.Name then
				zombieWaterTouchedConnection:Disconnect()
				LocalCharacter.Humanoid:TakeDamage(100)
			end
		end)
	end
end


----



--// Setup //--
StartPart.CanTouch = true
----



--// Main //--


-- ��Ʈ�� ��ġ������ �߻��ϴ� �̺�Ʈ�� UpPart�Լ��� �۵� ��Ŵ.
local startPartConnection: RBXScriptConnection
startPartConnection = StartPart.Touched:Connect(function(hit)

	local character = hit.Parent
	if not character then return end
	local Humanoid = character:FindFirstChildOfClass('Humanoid')
	if not Humanoid then return end
	if character.Name ~= LocalCharacter.Name then return end


	--  �߰�: ĳ���� �ε�� �� 1ȸ�� �̺�Ʈ�� ó��
	startPartConnection:Disconnect()


	wait(1)
	RunTweenZombieWater(hit)
end)

-- �÷��̾ ������ ���� �� �ö���� ��Ʈ ����. // AI��� ��ũ��Ʈ�� ������ �ֱ������� �ϴ� �۵��� ��.
local humanoidDiedConnection: RBXScriptConnection
humanoidDiedConnection = LocalCharacter.Humanoid.Died:Connect(function()

	--  �߰�: ĳ���� �ε�� �� 1ȸ�� �̺�Ʈ�� ó��
	humanoidDiedConnection:Disconnect()


	--  ����: WaitForChild("UpPart", 1) -> WaitForChild("UpPart")
	-- (���� ��Ʈ�� 1�� �ڿ� ��ã���� nil�� ���� ������ Destroy()�� �ȵǴ� ���״� ���⼭ �߻��ϰ� ��)
	--local uppart = game.Workspace:WaitForChild("UpPart", 1)
	--  ����: zombieWaterPart�� workspace���� �ٽ� ã�� ��� Ŭ���� �� ĳ���� ������ �����ϵ��� ����
	--local zombieWaterPart = game.Workspace:WaitForChild("UpPart")
	local zombieWaterPart = Cached_ZombieWater
	if zombieWaterPart ~= nil then
		zombieWaterPart:Destroy()
		ZombieAnimation.Enabled = false
		ZombieSpawnScript.Enabled = false
		--print("end~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
	end
end)

--  �ּ�: �ּ� ó���Ͽ� �׽�Ʈ
game.ReplicatedStorage.DiedEvent.Died.OnClientEvent:Connect(function()
	--  ����: WaitForChild("UpPart", 1) -> WaitForChild("UpPart")
	-- (���� ��Ʈ�� 1�� �ڿ� ��ã���� nil�� ���� ������ Destroy()�� �ȵǴ� ���״� ���⼭ �߻��ϰ� ��)
	--local uppart = game.Workspace:WaitForChild("UpPart", 1)
	local zombieWaterPart = game.Workspace:WaitForChild("UpPart")
	if zombieWaterPart ~= nil then
		LocalCharacter.Humanoid:TakeDamage(100)
		zombieWaterPart:Destroy()
		ZombieAnimation.Enabled = false
		ZombieSpawnScript.Enabled = false
		--print("end~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
	end
end)


----