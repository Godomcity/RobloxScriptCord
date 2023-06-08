
local const = require(game.ReplicatedStorage.Constants)
local checkpoints = {}

local player = game.Players.LocalPlayer

local point = workspace.DIstance:GetChildren()

local scriptName = "Script"

local totalDistance = 0;

local pointIndex = 1;

local cartocheckPoint = 0 

local carToEnd = 1;

local CHECKPOINT_COUNT = 23
local guiname = nil
local isPlaying = false
local SpeedGameScore = 0
local MAX_TIME = 0
local VehicleGUI = nil
local DISTANCE = 401
local DISTANCE_BAR_MAXSCALE = -0.257
local DISTANCE_BAR_WIDTH = 0.02
local Nilcar = nil
local BoosterPower = 7

local Gui = player.PlayerGui:FindFirstChild("NiroCar")
local exitgame = player.PlayerGui:FindFirstChild("ExitGame")

local pointManager = require(game.ReplicatedStorage.PointManager)

----------------------------------------------------------------------
local PlayerStateFolder = game.ReplicatedStorage:WaitForChild("PlayerState")
local playerStates = require(PlayerStateFolder.PlayerStates)
local SetPlayerState = PlayerStateFolder.Event:WaitForChild("SetPlayerState")
local ExitSpeedGameEvent = PlayerStateFolder.Event.ExitSpeedGameUI

--------------------------------------


--local SpeedGameScore = 0
local CoinCount = 0
--local car = workspace.test0000.NiroEV.Body.Body00.Position

local function InitCheckPoint()	
	table.sort(point, function(a,b) return a.Name < b.Name end )
	for i = 1, #point do
		if(point[i].Name == scriptName) then
			continue
		end
		checkpoints[i] = point[i]

		point[i].Touched:Connect(function() 
			pointIndex = i
		end)

	end
end

local function InitDistanceInfo()

	for i = 1, #checkpoints  do
		if(i == CHECKPOINT_COUNT) then
			break;
		end
		totalDistance += (checkpoints[i+1].Position - checkpoints[i].Position).Magnitude
	end

	print(totalDistance.."------------------------------ToTalDistance")
end

local function SpeedMeter(Speed, Velocity)
	if Speed >0  then
		Speed = -1 *Speed
	end
	
	if(Velocity < 0) then
		Velocity = -1*Velocity
	end
	Gui.BackGround.SpeedBar.Size =  UDim2.new(DISTANCE_BAR_WIDTH,0,Speed,0)
	if Gui.BackGround.SpeedMeter ~= nil then
		Gui.BackGround.SpeedMeter.SpeedText.Text = math.floor(Velocity)
	end
		
end

local function Battery(drivingDistance, timeDelta)
	local value = ((drivingDistance*DISTANCE_BAR_MAXSCALE)/DISTANCE)

	Gui.BackGround.DistanceBar.Size =  UDim2.new(DISTANCE_BAR_WIDTH,0,value,0)
end

local function TouchedPuddle(puddle:Part, car:Part)	
	if puddle:GetAttribute("puddle") == true and car:GetAttribute("Car") == true then
		print("paddle---------------------------------------")
		guiname:FindFirstChild("Driver").Booster.Value = -1
		wait(1.5)
		guiname:FindFirstChild("Driver").Booster.Value = 1	
	end
end 

local function TouchedBattery(btery:Part, car:Part)
	--if btery:GetAttribute("Battery") == true and car:GetAttribute("Car") == true then
	--	Gui.BackGround.DrivingDistanceImage.Size =  Gui.BackGround.DrivingDistanceImage.Size - UDim2.new(0.01,0,0,0)
	--	btery.CanTouch = false
	--	btery.Transparency = 1
	--	delay(20, function()
	--		btery.CanTouch = true
	--		btery.Transparency = 0
	--	end)
	--end

	if  btery:GetAttribute("Coin") == true and car:GetAttribute("Car") == true then
		pointManager:IncreaseValueClient("Coin", 1)
		btery.Coin1:Play()
		btery.Transparency = 1
		btery.Parent.CoinOut.Transparency = 1
		btery.Parent.CoinMark.Transparency = 1
		btery.Attachment.Flare.Enabled = true
		btery.Attachment.Sparkles.Enabled = true
		btery.Attachment.Wave.Enabled = true
		btery.CanTouch = false

		CoinCount += 1
		
		delay(1.5,function()
			btery.Attachment.Flare.Enabled = false
			btery.Attachment.Sparkles.Enabled = false
			btery.Attachment.Wave.Enabled = false
		end)
		delay(20,function()
			btery.Transparency = 0
			btery.Parent.CoinOut.Transparency = 0
			btery.Parent.CoinMark.Transparency = 0
			btery.CanTouch = true
		end)

	end
end


local function TouchedBooster(BoosterPart:Part, car:Part)
	if BoosterPart:GetAttribute("Booster") == true and car:GetAttribute("Car") == true then
		guiname:FindFirstChild("Driver").Booster.Value = BoosterPower
		delay(1.5,function()
			guiname:FindFirstChild("Driver").Booster.Value = 1
		end)
	end
end

local function TouchedEndSpeedGame(hit:Part)	
	if hit.Name ~= "HumanoidRootPart" then
		return
	end

	local player = game.Players:GetPlayerFromCharacter(hit.Parent)

	workspace.test0000.Goal.SurfaceGui.Goal.Visible = true

	for _, car in pairs(workspace.test0000:GetChildren()) do
		if car:GetAttribute("Name") == player.Name then
			car:Destroy()
		end
	end
	wait(1)
	workspace.test0000.Goal.SurfaceGui.Goal.Visible =  false
	MAX_TIME = 0;
	SpeedGameScore = CoinCount * 1000 - MAX_TIME
	game.ReplicatedStorage.SpeedGame.SetScore:FireServer(SpeedGameScore)
	SpeedGameScore = 0
	Gui.BackGround.Visible = false
	
	game.ReplicatedStorage.SpeedGame.ServerEvents.GameEnded:FireServer()

end



local ref = nil

local function CheckDistance(niroev)
	print(niroev)
	local Start = os.clock()
	local Last = os.clock()
	local temp = 0
	--Gui.BackGround.DrivingDistance.DrivingDistanceText.Text = "0"
    SpeedGameScore = 0;
	
	local speed = 0
	CoinCount = 0
	
	exitgame.XBtn.Visible = true
	exitgame.XBtn.Value.Value = "SpeedGame"
	
	print("----------------------------------startDriving")
	while(true) do
		wait()
		
		local detaTime = os.clock()-Last
		MAX_TIME += detaTime
		if MAX_TIME > const.MaxSpeedgamePlayingTime then
			print("Max time")
			TouchedEndSpeedGame(player.Character.HumanoidRootPart)
			player.Character:PivotTo(workspace.test0000.EndSpeedGame.CFrame)
			game.ReplicatedStorage.AlertMessage.ShowMessage_Client:Invoke("Game is over")
		end
		Last = os.clock()
		local mins = math.floor(MAX_TIME / 60)
		local secs = math.floor(MAX_TIME % 60)
		local millsec = math.floor(MAX_TIME % 1 * 100)
		if string.len(mins) < 2 then mins = "0".. mins end
		if string.len(secs) < 2 then secs = "0".. secs end
		if string.len(millsec) < 2 then millsec = "0" .. millsec end
		--cartocheckPoint = (checkpoints[pointIndex].Position - car).Magnitude
		cartocheckPoint = math.floor((checkpoints[pointIndex].Position - niroev.Position).Magnitude)



		for i = pointIndex, #checkpoints  do
			if(i==CHECKPOINT_COUNT) then
				break;
			end

			carToEnd += math.floor( (checkpoints[i+1].Position - checkpoints[i].Position).Magnitude) 

		end


		--warn("Touch connected")
		carToEnd -= cartocheckPoint
		--print(cartocheckPoint.."-----------------------------------------------")
		temp = (carToEnd*DISTANCE)/totalDistance 

		Gui.BackGround.TimeLab.Text = mins .. ":" .. secs .. ":" .. millsec
		speed = ( guiname.Driver.ForwardVelocity.Value * DISTANCE_BAR_MAXSCALE)/250
		SpeedMeter(speed, guiname.Driver.ForwardVelocity.Value)
		--print(guiname.Driver.ForwardVelocity.Value.."============================"..speed)
		if Gui.BackGround.DistanceBar.Size.Y.Scale <= 0 then
			if guiname.Driver.ForwardVelocity.Value > 5 or guiname.Driver.ForwardVelocity.Value < -1 then
				local drivingDistance = DISTANCE - math.floor(temp)
				Battery(drivingDistance,detaTime)
				Gui.BackGround.Distance.DistanceText.Text = drivingDistance
			end
			
			if  Gui.BackGround.DistanceBar.Size.Y.Scale <= DISTANCE_BAR_MAXSCALE then
				--print("============================")
				Gui.BackGround.DistanceBar.Size = UDim2.new(DISTANCE_BAR_WIDTH, 0, DISTANCE_BAR_MAXSCALE, 0)
			end
				
		else if Gui.BackGround.DistanceBar.Size.Y.Scale > 0  then
				--print(Gui.BackGround.DistanceBar.Size.X.Scale.."============================")
				--game.Workspace.test0000.NiroEV.Body.Body00.Anchored = true
				Gui.BackGround.DistanceBar.Size = UDim2.new(0,0,0,0)
			end
			
		end
	
		if carToEnd <= 0 then
			Gui.BackGround.DrivingDistance.DrivingDistanceText.Text = "401"
			isPlaying = false
		end
		
		
		if isPlaying == false then
			break
		end
		--print(carToEnd.."-----------------------------------------")
		--if(carToEnd <= 0) then
		--	Gui.BackGround.DrivingDistance.DrivingDistanceText.Text = "401"
		--	break;
		--end

		carToEnd = 0
	end


end

--local function TimeLab(MAX_TIME)



--end

game.ReplicatedStorage:WaitForChild("NiroOnEnterCar").OnClientEvent:Connect(function(CAR:Model)
	local carbody:Part = CAR:FindFirstChild("Body"):FindFirstChild("Body00")
	
	
	Nilcar = CAR
	MAX_TIME=0
	SpeedMeter(0,0)
	SetPlayerState:Fire(playerStates.SPEEDGAME)
	isPlaying = true
	while true do
		if CAR.Parent == workspace.test0000.SpawnCarPart then
			CAR.Parent = workspace.test0000
		end
		--CAR:SetPrimaryPartCFrame(workspace.test0000.CarSpawnPart.CFrame)
		carbody.Anchored = true
		--workspace.test0000.Time.SurfaceGui.TextLabel.Text = 3
		workspace.test0000.Time.SurfaceGui.Count03.Visible = true
		game.SoundService.CountDown.Count:Play()
		wait(1)
		workspace.test0000.Time.SurfaceGui.Count03.Visible = false
		workspace.test0000.Time.SurfaceGui.Count02.Visible = true
		--workspace.test0000.Time.SurfaceGui.TextLabel.Text = 2
		game.SoundService.CountDown.Count:Play()
		wait(1)
		workspace.test0000.Time.SurfaceGui.Count02.Visible = false
		workspace.test0000.Time.SurfaceGui.Count01.Visible = true
		---workspace.test0000.Time.SurfaceGui.TextLabel.Text = 1
		game.SoundService.CountDown.Count:Play()
		wait(1)
		workspace.test0000.Time.SurfaceGui.Count01.Visible = false
		workspace.test0000.Time.SurfaceGui.Start.Visible = true
		game.SoundService.CountDown.Count:Play()
		wait(1)
		game.SoundService.CountDown.Start:Play()
		workspace.test0000.Time.SurfaceGui.Start.Visible = false
		--workspace.test0000.Time.SurfaceGui.TextLabel.Text = "Start"
		CAR.Body.Body00.Anchored = false
		break
	end
	
	carbody.Touched:Connect(function(Puddle)
		TouchedPuddle(Puddle, carbody)
	end)
	
	
	carbody.Touched:Connect(function(boo)
		TouchedBooster(boo, carbody)
	end)
	
	carbody.Touched:Connect(function(bat)
		TouchedBattery(bat, carbody)
	end)
	--if ref == nil then
	--	warn("Connected")
	--	ref = car.Touched:Connect(function(bat)			
	--		TouchedBattery(bat, car)
	--	end)
	--end

	local CarGuiName = game.Players.LocalPlayer.PlayerGui:FindFirstChild("_ClientControls")
	guiname = CarGuiName
	VehicleGUI = nil
	VehicleGUI=require(guiname.LocalVehicleGui)
	MAX_TIME=0
	SpeedMeter(0,0)
	Gui.BackGround.Visible = true
	CheckDistance(carbody)

end)

local function ExitSpeedGameUI()
	if game.Players.LocalPlayer.PlayerGui.ExitGame.XBtn.Value.Value == "SpeedGame" then
		Nilcar:SetPrimaryPartCFrame(workspace.test0000.EndSpeedGame.CFrame)
		wait(0.5)
		game.Players.LocalPlayer.PlayerGui.ExitGame.ExitImage.Visible = false
		game.Players.LocalPlayer.PlayerGui.ExitGame.XBtn.Visible = false
		Gui.BackGround.Visible = false
		isPlaying = false
		SetPlayerState:Fire(playerStates.NORMAL)
	end
	
end

ExitSpeedGameEvent.Event:Connect(function()
	ExitSpeedGameUI()
end)

game.ReplicatedStorage:WaitForChild("NiroOnExitCar").OnClientEvent:Connect(function()
	Gui.BackGround.Visible = false
end)

workspace.test0000.endpoint.Touched:Connect(function()
	player.Character:SetPrimaryPartCFrame(workspace.CampingArea.SpawnLocation.CFrame)
	Gui.BackGround.Visible = false
end)


--game.Players.LocalPlayer.PlayerGui.ExitGame.XBtn.MouseButton1Click:Connect(function()
--	game.Players.LocalPlayer.PlayerGui.ExitGame.ExitImage.Visible = true	
--end)

--game.Players.LocalPlayer.PlayerGui.ExitGame.ExitImage.YesButton.MouseButton1Click:Connect(function()
--	if game.Players.LocalPlayer.PlayerGui.ExitGame.XBtn.Value.Value == "SpeedGame" then
--		Nilcar:SetPrimaryPartCFrame(workspace.test0000.EndSpeedGame.CFrame)
--		game.Players.LocalPlayer.PlayerGui.ExitGame.ExitImage.Visible = false
--		game.Players.LocalPlayer.PlayerGui.ExitGame.XBtn.Visible = false
--		Gui.BackGround.Visible = false
--	end
--end)

--game.Players.LocalPlayer.PlayerGui.ExitGame.ExitImage.NoButton.MouseButton1Click:Connect(function()
--	game.Players.LocalPlayer.PlayerGui.ExitGame.ExitImage.Visible = false
--end)

workspace.test0000.EndSpeedGame.Touched:Connect(function(hit)
	TouchedEndSpeedGame(hit)
end)
	

InitCheckPoint()
InitDistanceInfo()





