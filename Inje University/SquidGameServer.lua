local gameLength = 100 -- 게임 길이(초)
local playersAlive = {} --참가중인 플레이어
local playersCompleted = {} --클리어한 플레이어

local redLight = false
local isStarted = false


local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local storage = require(ServerStorage:WaitForChild("Storage"))


local scStart = {
	"인제대학교 오징어 게임입니다.",
	'이번 게임은 "무궁화 꽃이 피었습니다" 게임입니다.',
	"제한 시간 내에 선 안으로 들어가면 통과입니다.",
	"잠시 후 게임을 시작합니다…."	
}
local scEnd = {
	"축하합니다."
}

game:GetService("RunService").Heartbeat:Connect(function()--움직이는 사람 탈락시키기
	if not redLight then
		return
	end
	for i, player in pairs(playersAlive) do
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			if player.Character.Humanoid.MoveDirection.Magnitude > 0 then
				player.Character.Humanoid.Health = 0
				script.Parent.Part.Shot:Play()
			end
		end
	end
end)


workspace.squidGame.SquidGame.EndGameBarrier.Touched:Connect(function(hit)--출구에 닿으면 게임에서 제외
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player and table.find(playersAlive, player) then
		workspace.squidGame.SquidGame.Wait.CanCollide = true
		table.remove(playersAlive, table.find(playersAlive, player))
		table.insert(playersCompleted, player)
		game.ReplicatedStorage.SquidGameRE:FireClient(player, "barrier", workspace.squidGame.SquidGame.EndGameBarrier)
		game.ReplicatedStorage.SquidGameRE:FireClient(player, "off", false, Color3.fromRGB(255, 255, 255))
	end
end)

Players.PlayerRemoving:Connect(function(player)
	if table.find(playersAlive, player) then
		table.remove(playersAlive, table.find(playersAlive, player))
	end
	if table.find(playersCompleted, player) then
		table.remove(playersCompleted, table.find(playersCompleted, player))
	end
end)

while true do
	wait(1)
	local base = storage.GetData("LobbyBase")
	print(base)
	local timeLeft = gameLength

	workspace.squidGame.SquidGame.PreGameBarrier.CanCollide = true
	workspace.squidGame.SquidGame.EndGameBarrier.CanCollide = false
	workspace.squidGame.SquidGame.Bear_Head.Head.Orientation = Vector3.new(0, 0, 0)
	
	while 1 do--로비에 플레이어가 생길 때까지 대기
		local count = 0
		local temp = storage.GetPlayersInBox(Players:GetPlayers(), base)
		for k, v in pairs(temp) do
			count = count + 1
		end
		if count >= 1 then
			break
		end
		wait(1)
	end
	print(1)
	--game.ReplicatedStorage.SquidGameRE:FireAllClients("status", "Game Starting...", Color3.fromRGB(255, 255, 255))
	timeLeft = 30
	while timeLeft > 0 do
		timeLeft -= 1
		local mins = math.floor(timeLeft / 60)
		local secs = timeLeft % 60
		if string.len(mins) < 2 then mins = "0".. mins end
		if string.len(secs) < 2 then secs = "0".. secs end
		--game.ReplicatedStorage.SquidGameRE:FireAllClients("timer", mins .. ":" .. secs)
		storage.updateTimer(mins .. ":" .. secs)
		if timeLeft == 20 then
			storage.TurnLight(true)
		end
		wait(1)
	end
	storage.updateTimer("게임중")

	for k, player in pairs(storage.GetPlayersInBox(Players:GetPlayers(), base)) do
		table.insert(playersAlive, player)
	end	

	for k, v in pairs(playersAlive) do
		v.Character:MoveTo(workspace.squidGame.SquidGame.SpawnPart.Position) 
		--v:LoadCharacter()
		v.RespawnLocation = workspace.squidGame.Start
		game.ReplicatedStorage.SquidGameRE:FireClient(v, "gui", true, Color3.fromRGB(255, 255, 255))
		game.ReplicatedStorage.SquidGameRE:FireClient(v, "loading", 1,1)
		v.Character.Humanoid.Died:Connect(function()
			table.remove(playersAlive, table.find(playersAlive, v))
			game.ReplicatedStorage.SquidGameRE:FireClient(v, "gui", false, Color3.fromRGB(255, 255, 255))
		end)
	end
	
	wait(4)
	storage.TurnLight(false)
	for k, v in pairs(scStart) do
		for k1, v1 in pairs(playersAlive) do
			game.ReplicatedStorage.SquidGameRE:FireClient(v1, "text", v, Color3.fromRGB(255, 255, 255))
		end
		wait(5)
	end
	
	timeLeft = 10
	while timeLeft > 0 do
		timeLeft -= 1
		for k, v in pairs(playersAlive) do
			game.ReplicatedStorage.SquidGameRE:FireClient(v, "text", tostring(timeLeft) .. "...", Color3.fromRGB(255, 255, 255))	
		end
		wait(1)
	end

	for k, v in pairs(playersAlive) do
		game.ReplicatedStorage.SquidGameRE:FireClient(v, "text", "", Color3.fromRGB(255, 255, 255))
	end
	

	timeLeft = gameLength
	workspace.squidGame.SquidGame.PreGameBarrier.CanCollide = false

	
	isStarted = true
	
	for k, v in pairs(playersAlive) do
		game.ReplicatedStorage.SquidGameRE:FireClient(v, "timerGui", true, Color3.fromRGB(255, 255, 255))
	end
	
	coroutine.wrap(function()
		while timeLeft > 0 and #playersAlive > 0 do
			timeLeft -= 1
			local mins = math.floor(timeLeft / 60)
			local secs = timeLeft % 60
			if string.len(mins) < 2 then mins = "0" .. mins end
			if string.len(secs) < 2 then secs = "0" .. secs end
			for k, v in pairs(playersAlive) do
				game.ReplicatedStorage.SquidGameRE:FireClient(v, "timer", mins .. ":" .. secs)
			end
			
			wait(1)
		end
	end)()


	while timeLeft > 0 and #playersAlive > 0 do
		for k, v in pairs(playersAlive) do
			game.ReplicatedStorage.SquidGameRE:FireClient(v, "greenLight", true, Color3.fromRGB(0, 255, 0))
		end		
		local randomSpeed = math.random(8, 13)/10
		script.Parent.Part.Sound.PlaybackSpeed = randomSpeed
		script.Parent.Part.Sound:Play()
		script.Parent.Part.Sound.Ended:Wait()
		game:GetService("TweenService"):Create(workspace.squidGame.SquidGame.Bear_Head.Head, TweenInfo.new(0.3), {Orientation = Vector3.new(0, 180, 0)}):Play()
		script.Parent.Part.spin:Play()
		
		if #playersAlive == 0 then
			break
		end

		redLight = true
		for k, v in pairs(playersAlive) do
			game.ReplicatedStorage.SquidGameRE:FireClient(v, "redLight", true, Color3.fromRGB(0, 255, 0))
		end		
		wait(math.random(1, 5))
		game:GetService("TweenService"):Create(workspace.squidGame.SquidGame.Bear_Head.Head, TweenInfo.new(0.3), {Orientation = Vector3.new(0, 0, 0)}):Play()
		script.Parent.Part.spin:Play()
		redLight = false
	end

	for i, player in pairs(playersAlive) do
		player.Character.Humanoid.Health = 0
		script.Parent.Part.Shot:Play()
	end

	for k, v in pairs(scEnd) do
		for k1, v1 in pairs(playersCompleted) do
			game.ReplicatedStorage.SquidGameRE:FireClient(v1, "text", v, Color3.fromRGB(255, 255, 255))
		end
		wait(10)
	end
	for k, v in pairs(playersCompleted) do
		game.ReplicatedStorage.SquidGameRE:FireClient(v, "off", 1, 1)
	end
	playersCompleted={}
	storage.reset()
	isStarted = false
	workspace.squidGame.SquidGame.Wait.CanCollide = false
end