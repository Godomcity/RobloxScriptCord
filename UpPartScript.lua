--// Service //--
local TweenService = game:GetService("TweenService")
----



--// Presetup //--

----



--// Types //--

----



--// Constants //--


-- 클라이언트에 해당하는 플레이어.
local player = game.Players.LocalPlayer
if not player.Character then player.CharacterAdded:Wait() end
local LocalCharacter = player.Character

-- 좀비를 생성하는 모델의 위치
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
-- 캐싱용 변수
local Cached_ZombieWater: BasePart
----



--// Functions //--


local function SetDifficulty(plusTime: number, goal: {}, tweenInfo: TweenInfo, tween: Tween)
	
	-- 체크 포인트에 도달했을 경우 다음 체크포인트로 Cached_ZombieWater의 tweenPosition을 변경
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


			--  comment: 난이도는 30초 단위로 조정할 것
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


-- 파트를 생성하고 좀비 함수를 사용한 장소.
--  수정: hit -> RigPart: BasePart
--local function RunTweenZombieWater(hit)
local function RunTweenZombieWater(RigPart: BasePart)

	local zombieWaterPart = workspace:FindFirstChild("UpPart")
	if zombieWaterPart == nil then
		--  수정: Cached_ZombieWater에 클론된 좀비물 캐싱
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
		--  수정: 좀비물 올라오는 속도 느리게 설정
		--local tweenInfo = TweenInfo.new(420)
		local tweenInfo = TweenInfo.new(480, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
		local tween = TweenService:Create(Cached_ZombieWater, tweenInfo, goal)
		tween:Play()

		ZombieAnimation.Enabled = false
		ZombieSpawnScript.Enabled = true
		StartPart.CanTouch = false


		-- 난이도 Enum 정의 (초 단위 시간 정보)
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
			--  수정: player.Name -> LocalCharacter.Name
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


-- 파트를 터치했을때 발생하는 이벤트로 UpPart함수를 작동 시킴.
local startPartConnection: RBXScriptConnection
startPartConnection = StartPart.Touched:Connect(function(hit)

	local character = hit.Parent
	if not character then return end
	local Humanoid = character:FindFirstChildOfClass('Humanoid')
	if not Humanoid then return end
	if character.Name ~= LocalCharacter.Name then return end


	--  추가: 캐릭터 로드될 때 1회성 이벤트로 처리
	startPartConnection:Disconnect()


	wait(1)
	RunTweenZombieWater(hit)
end)

-- 플레이어가 죽으면 좀비 및 올라오는 파트 삭제. // AI모듈 스크립트에 오류가 있긴하지만 일단 작동은 됨.
local humanoidDiedConnection: RBXScriptConnection
humanoidDiedConnection = LocalCharacter.Humanoid.Died:Connect(function()

	--  추가: 캐릭터 로드될 때 1회성 이벤트로 처리
	humanoidDiedConnection:Disconnect()


	--  수정: WaitForChild("UpPart", 1) -> WaitForChild("UpPart")
	-- (좀비물 파트를 1초 뒤에 못찾으면 nil이 오기 때문에 Destroy()가 안되는 버그는 여기서 발생하게 됨)
	--local uppart = game.Workspace:WaitForChild("UpPart", 1)
	--  수정: zombieWaterPart를 workspace에서 다시 찾는 대신 클론할 때 캐싱한 좀비물을 참조하도록 수정
	--local zombieWaterPart = game.Workspace:WaitForChild("UpPart")
	local zombieWaterPart = Cached_ZombieWater
	if zombieWaterPart ~= nil then
		zombieWaterPart:Destroy()
		ZombieAnimation.Enabled = false
		ZombieSpawnScript.Enabled = false
		--print("end~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
	end
end)

--  주석: 주석 처리하여 테스트
game.ReplicatedStorage.DiedEvent.Died.OnClientEvent:Connect(function()
	--  수정: WaitForChild("UpPart", 1) -> WaitForChild("UpPart")
	-- (좀비물 파트를 1초 뒤에 못찾으면 nil이 오기 때문에 Destroy()가 안되는 버그는 여기서 발생하게 됨)
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