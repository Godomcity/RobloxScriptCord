local DISTANCE = 12 -- the distance to the destination to complete the delivery
local bodyParts = script.Parent:GetChildren()
local humanoid = script.Parent:WaitForChild("Humanoid")
local animLoader = require(game.ReplicatedStorage.AnimationLoader)
local allDest = {}
local rnd = Random.new()
local tutorailbool = workspace.Tutorial.Tutorial.Value
tutorailbool = false
local tutodestination = nil
local tutorialPart = workspace.Tutorial:GetChildren()
local target = nil
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local player = players.LocalPlayer
local uiFrame = player.PlayerGui:FindFirstChild("DeliveryInformationFrame", true)
--local txtKR = player.PlayerGui:FindFirstChild("DestinationName_KR", true)
--local txtEN = player.PlayerGui:FindFirstChild("DestinationName_EN", true)
--local destinationText = player.PlayerGui:FindFirstChild("Distance", true)
local destinationImage = player.PlayerGui:FindFirstChild("Destination", true)
local renderStepEventReference = nil
local defaultWalkAnimationId = player.Character:WaitForChild("Animate"):WaitForChild("walk"):WaitForChild("WalkAnim").AnimationId
local defaultRunAnimationId = player.Character.Animate.run.RunAnim.AnimationId
local defaultIdleAnimationId = player.Character.Animate.idle.Animation1.AnimationId
local NavigatorScript = player.Character:WaitForChild("Navigator")
local pointManager = require(game.ReplicatedStorage.PointManager)

local notteleport = game.ReplicatedStorage:WaitForChild("NOTe")

local MAX_Time = 40
local checktuto = true
local CheckMission = true
local AllEnter = workspace.Tutorial:GetChildren()
local Destination = nil

local DeliveryIndex = 0

local mouse = player:GetMouse()
local Gui = player.PlayerGui:WaitForChild("Gui"):WaitForChild("BackGround")
local TutorialTable = {Gui.TutoStartBG, Gui.KIANFTBG, Gui.NFTBG, Gui.PlayGroundBG, Gui.DOGIBG, Gui.DeliveryBG,
	Gui.DeliveryEndBG, Gui.BeachBG, Gui.VollyBG, Gui.VollyEndBG, Gui.SpeedBG, Gui.SpeedstBG, Gui.SpeedEndBG, Gui.SpeedNoClearBG, Gui.PumpBG, Gui.CarBG}
----------------------------------------------------------------------------------------------------------------------

local playerStateFolder = game.ReplicatedStorage:WaitForChild("PlayerState")
local SetPlayerState = playerStateFolder.Event.SetPlayerState
local GetPlayerState = playerStateFolder.Event.GetPlayerState

local PlayerStates = require(game.ReplicatedStorage:WaitForChild("PlayerState").PlayerStates)
local ExitDeleveryGameEvent = playerStateFolder.Event.ExitDeliveryGame
------------------------------------------------------------------------------------------------------------
local UIManager = require(game.ReplicatedStorage:WaitForChild("UImanager"))
--function CheckVisible(BGName)
--	for i, v in pairs(TutorialTable) do
--		print(v.Name)
--		if i and v ~= BGName then
--			print(BGName)
--			v.Visible = false
--		end
--	end
--end


for _, obj in pairs(workspace:GetDescendants()) do -- find all destinations
	if(obj:IsA("Instance") and obj:GetAttribute("Destination") == true) then
		table.insert(allDest, obj)
	end
end

local function RenderStep()
	local head = player.Character.HumanoidRootPart.Position
	local distanceVector:Vector3 = target.Position - head

	--destinationText.Text = "Distance: "..math.floor(distanceVector.Magnitude)
end

local function ResetPlayerAnimation()
	player.Character.Animate.walk.WalkAnim.AnimationId = defaultWalkAnimationId
	player.Character.Animate.run.RunAnim.AnimationId = defaultRunAnimationId
	player.Character.Animate.idle.Animation1.AnimationId = defaultIdleAnimationId
end

local function UnLockDeliveryRank(coin, Lock)
	local coin = pointManager:GetValueClient("Coin")
	if coin >= coin then
		Lock.CanCollide = false
		Lock.Transparency = 1
		Lock.SurfaceGui:Destroy()
		Lock.CanTouch = false
		player.PlayerGui.Temp.BuyRanking.Visible = false
		Lock.ClickDetector:Destroy()
		pointManager:IncreaseValueClient("Coin",-coin)
	else
		player.PlayerGui.Temp.NotCoin.Visible = true
		UIManager:CheckVisible(player.PlayerGui.Temp.NotCoin)
		player.PlayerGui.Temp.BuyRanking.Visible = false
		delay(3,function()
			player.PlayerGui.Temp.NotCoin.Visible = false
		end)
	end
end

local function EndMission()
	local coin = 0
	local effect = game.ReplicatedStorage.Congrats:WaitForChild("Congrats"):Clone()
	
	effect.Parent = player.Character.HumanoidRootPart
	
	local weld = Instance.new("Weld", player.Character)
	weld.Part0 = effect
	weld.Part1 = player.Character.HumanoidRootPart
	player.PlayerGui.DeliveryInformation.DeliveryInformationFrame.PopUp.Visible = true
	delay(3,function()
		effect:Destroy()
		weld:Destroy()
		player.PlayerGui.DeliveryInformation.DeliveryInformationFrame.PopUp.Visible = false	
	end)	
	NavigatorScript.Enable.Value = false
	uiFrame.Visible = true
	game.SoundService.Victory:Play()
	game.ReplicatedStorage.Delivery.ServerEvents.MissionCompleted:FireServer()
	
	target = nil
	if renderStepEventReference ~= nil then
		renderStepEventReference:Disconnect()
	end
	ResetPlayerAnimation()
	
	--player.Character.Animate.walk.WalkAnim.AnimationId = defaultWalkAnimationId
	--player.Character.Animate.run.RunAnim.AnimationId = defaultRunAnimationId
	--player.Character.Animate.idle.Animation1.AnimationId = defaultIdleAnimationId
	if player.Character.Package:GetAttribute("Ranking") == "Beginner" then
		coin = 1
		--pointManager:IncreaseValueClient("Coin",1)
		--player.Character.Deliveryman.CurrentPackage.Value:Destroy()
		--player.Character.Deliveryman.CurrentPackage.Value = nil
	elseif player.Character.Package:GetAttribute("Ranking") == "Challenge" and MAX_Time >= 15 then
		coin =5
		--pointManager:IncreaseValueClient("Coin",5)
		--player.Character.Deliveryman.CurrentPackage.Value:Destroy()
		--player.Character.Deliveryman.CurrentPackage.Value = nil
	else if player.Character.Package:GetAttribute("Ranking") == "Challenge" and MAX_Time <= 14 then
			coin = 2
			--pointManager:IncreaseValueClient("Coin",2)
			--player.Character.Deliveryman.CurrentPackage.Value:Destroy()
			--player.Character.Deliveryman.CurrentPackage.Value = nil
		elseif player.Character.Package:GetAttribute("Ranking") == "Champion"and MAX_Time >= 20  then
			coin = 10
			--pointManager:IncreaseValueClient("Coin",10)
			--player.Character.Deliveryman.CurrentPackage.Value:Destroy()
			--player.Character.Deliveryman.CurrentPackage.Value = nil
		elseif player.Character.Package:GetAttribute("Ranking") == "Champion"and MAX_Time <= 19  then
			coin = 6
			--pointManager:IncreaseValueClient("Coin",6)
			--player.Character.Deliveryman.CurrentPackage.Value:Destroy()
			--player.Character.Deliveryman.CurrentPackage.Value = nil
		end
	end

	pointManager:IncreaseValueClient("Coin",coin)
	player.Character.Deliveryman.CurrentPackage.Value:Destroy()
	player.Character.Deliveryman.CurrentPackage.Value = nil

	DeliveryIndex += 1
	--game.ReplicatedStorage.Quest.RemoteEvent.SetState:FireServer(2, DeliveryIndex)
	
	if DeliveryIndex == 2 then
		checktuto = false
	end
	destinationImage.Image = "rbxassetid://9233357963"
	player.PlayerGui.ExitGame.XBtn.Visible = false
	CheckMission = false
	MAX_Time = 40
	player.PlayerGui.DeliveryInformation.DeliveryInformationFrame.Time.Visible = false

	
	SetPlayerState:Fire(PlayerStates.NORMAL)
	
	if checktuto == false then
		player.PlayerGui.Gui.BackGround.DeliveryEndBG.Visible = true
		player.PlayerGui.Gui.BackGround.DeliveryEndBG:SetAttribute("bool", true)
		game.ReplicatedStorage:WaitForChild("CheckGui"):FireServer()
		for i = 1, #AllEnter do
			if AllEnter[i]:GetAttribute("Number") == 7 then
				local Target = AllEnter[i]
				
				if(Destination ~= nil) then
					Destination:Disconnect()
					Destination = nil
					NavigatorScript.Destination.Value = nil
				end
				
				NavigatorScript.Destination.Value = Target.Position
				NavigatorScript.Enable.Value = true
				destinationImage.Image = Target:GetAttribute("Thumbnail")
				print("----------------------------------"..humanoid.Name..":"..humanoid.Parent.Name)
				Destination = Target.Touched:Connect(function()
					if humanoid ~= nil then
					
						player.PlayerGui.Gui.BackGround.VollyBG:SetAttribute("bool", true)
						game.ReplicatedStorage:WaitForChild("CheckGui"):FireServer()
						player.PlayerGui.Gui.BackGround.VollyBG.Visible = true
						UIManager:CheckVisible(player.PlayerGui.Gui.BackGround.VollyBG)
						--CheckVisible(player.PlayerGui.Gui.BackGround.VollyBG)
						Destination:Disconnect()
						player.Character.Navigator.Enable.Value = false
						checktuto = true
					end 
				end)
				
			end
		end
	end
end



local function ShowTimer(show)
	player.PlayerGui.DeliveryInformation.DeliveryInformationFrame.Time.Visible = show
	player.PlayerGui.DeliveryInformation.DeliveryInformationFrame.Timer.Visible = show
end

-- when a package is gotten and delivery mission starts
local function StartMission()
	SetPlayerState:Fire(PlayerStates.DELIVERY)
	
	CheckMission = true

	player.PlayerGui.ExitGame.XBtn.Visible = true
	if tutorailbool == false then
		local Package = player.Character:FindFirstChild("Package")
		
		for i = 1, #tutorialPart do
			if Package ~= nil and 
				(Package:GetAttribute("Ranking") == "Challenge" or player.Character.Package:GetAttribute("Ranking") == "Champion") then
				break
			end
			if tutorialPart[i]:GetAttribute("Number") == 6 then
				target = tutorialPart[i]

				tutodestination = target.Touched:Connect(function()
					player.PlayerGui.Gui.BackGround.CarBG.Visible = true
					UIManager:CheckVisible(player.PlayerGui.Gui.BackGround.CarBG)
					--CheckVisible(player.PlayerGui.Gui.BackGround.CarBG)
					player.PlayerGui.Gui.BackGround.CarBG:SetAttribute("bool", true)
					game.ReplicatedStorage:WaitForChild("CheckGui"):FireServer()
					tutorailbool = true
					tutodestination:Disconnect()
					target=nil
					NavigatorScript.Enable.Value = false
					if renderStepEventReference ~= nil then
						renderStepEventReference:Disconnect()
					end
					StartMission()
				end)

				break
			end
		end
	else
		target = allDest[rnd:NextInteger(1, #allDest)]
	end
	target = allDest[rnd:NextInteger(1, #allDest)]
	--workspace["[ changing room 2 ]"]["탈의실B"].Model.Tele.Touched:Connect(function()
	--	local pack = player.Character:FindFirstChild("Package")
	--	if pack ~= nil then
	--		game.ReplicatedStorage.Delivery.ServerEvents.MissionCompleted:FireServer()
	--		target = nil
	--		NavigatorScript.Enable.Value = false
	--		player.Character.Animate.walk.WalkAnim.AnimationId = defaultWalkAnimationId
	--		player.Character.Animate.run.RunAnim.AnimationId = defaultRunAnimationId
	--		player.Character.Animate.idle.Animation1.AnimationId = defaultIdleAnimationId
	--		destinationImage.Image = "rbxassetid://9233357963"
	--		checktuto = true
	--		if renderStepEventReference ~= nil then
	--			renderStepEventReference:Disconnect()
	--		end
	--	end
	--end)

	--workspace.Tutorial["에너지존teleport"].Touched:Connect(function()
	--	local pack = player.Character:FindFirstChild("Package")
	--	if pack ~= nil then
	--		game.ReplicatedStorage.Delivery.ServerEvents.MissionCompleted:FireServer()
	--		target = nil
	--		NavigatorScript.Enable.Value = false
	--		player.Character.Animate.walk.WalkAnim.AnimationId = defaultWalkAnimationId
	--		player.Character.Animate.run.RunAnim.AnimationId = defaultRunAnimationId
	--		player.Character.Animate.idle.Animation1.AnimationId = defaultIdleAnimationId
	--		destinationImage.Image = "rbxassetid://9233357963"
	--		checktuto = true
	--		if renderStepEventReference ~= nil then
	--			renderStepEventReference:Disconnect()
	--		end
	--	end
	--end)

	if player.Character.Package ~= nil then
		if player.Character.Package:GetAttribute("Ranking") == "Beginner" then
			ShowTimer(false)
			MAX_Time = 999999999999
		else
			ShowTimer(true)
		end
	end
	
	while MAX_Time >= 0 do
		if MAX_Time == 0 then
			game.ReplicatedStorage:WaitForChild("ExitDelivery"):FireServer()
			target = nil
			player.PlayerGui.ExitGame.XBtn.Visible = false
			NavigatorScript.Enable.Value = false
			
			ResetPlayerAnimation()
			
			--player.Character.Animate.walk.WalkAnim.AnimationId = defaultWalkAnimationId
			--player.Character.Animate.run.RunAnim.AnimationId = defaultRunAnimationId
			--player.Character.Animate.idle.Animation1.AnimationId = defaultIdleAnimationId
			destinationImage.Image = "rbxassetid://9233357963"
			checktuto = true
			if renderStepEventReference ~= nil then
				renderStepEventReference:Disconnect()
			end

			CheckMission = false
			MAX_Time = 40
			player.PlayerGui.DeliveryInformation.DeliveryInformationFrame.Time.Visible = false
			break
		else
			if CheckMission == true then
				wait(1)
				MAX_Time -= 1
				local mins = math.floor(MAX_Time / 60)
				local secs = MAX_Time % 60
				if string.len(mins) < 2 then mins = "0".. mins end
				if string.len(secs) < 2 then secs = "0".. secs end
				player.PlayerGui.DeliveryInformation.DeliveryInformationFrame.Time.Text = mins .. ":" .. secs
				player.PlayerGui.ExitGame.XBtn.Value.Value = "Delivery"
				uiFrame.Visible = true
				--txtEN.Text = target:GetAttribute("EnglishName") or "..."
				--txtKR.Text = target:GetAttribute("KoreanName") or "..."
				if target == nil then
					destinationImage.Image = "rbxassetid://9233357963"
					--NavigatorScript.Destination.Value = Vector3.new(0,0,0)
					--NavigatorScript.Enable.Value = false
				else
					destinationImage.Image = target:GetAttribute("Thumbnail")
					NavigatorScript.Destination.Value = target.Position
					NavigatorScript.Enable.Value = true
				end

				if renderStepEventReference and renderStepEventReference.Connected==false then
					renderStepEventReference = runService.RenderStepped:Connect(RenderStep)	
				end

				player.Character.Animate.walk.WalkAnim.AnimationId =animLoader:GetAnimationId(game.ReplicatedStorage.Animations.PizzaDeliveryWalk, "rbxassetid://9719072848") 
				player.Character.Animate.run.RunAnim.AnimationId = animLoader:GetAnimationId(game.ReplicatedStorage.Animations.PizzaDeliveryWalk, "rbxassetid://9719072848")
				player.Character.Animate.idle.Animation1.AnimationId = animLoader:GetAnimationId(game.ReplicatedStorage.Animations.PizzaDeliveryIdle, "rbxassetid://9719202784")
			else
				ResetPlayerAnimation()
				
				--player.Character.Animate.walk.WalkAnim.AnimationId = defaultWalkAnimationId
				--player.Character.Animate.run.RunAnim.AnimationId = defaultRunAnimationId
				--player.Character.Animate.idle.Animation1.AnimationId = defaultIdleAnimationId
				break
			end
		end
	end
end

--touch function of all the character body members
local function bodyTouched(bodyPart, otherPart)
	if target then 
		if(otherPart == target) then
			EndMission()
		end 
		return
	end
end

local function MissionStartedByServer()
	StartMission()
end

game.ReplicatedStorage.Delivery.ClientEvents.MissionStarted.OnClientEvent:Connect(MissionStartedByServer)

--connect body parts touched event
for _,obj in pairs(bodyParts) do
	if(obj:IsA("Part")) then
		obj.Touched:Connect(
			function(op)
				bodyTouched(obj, op)
			end)
	end
end

----------------------------------------------------------------------------------------------------------------------------------
player.PlayerGui.Gui.BackGround.DeliveryEndBG.BG.XBtn.MouseButton1Click:Connect(function()
	player.PlayerGui.Gui.BackGround.DeliveryEndBG.Visible = false
	player.PlayerGui.Gui.BackGround.DeliveryEndBG:SetAttribute("bool", false)
	game.ReplicatedStorage:WaitForChild("CheckGuifalse"):FireServer()
end)

player.PlayerGui.Gui.BackGround.VollyBG.BG.XBtn.MouseButton1Click:Connect(function()
	player.PlayerGui.Gui.BackGround.VollyBG.Visible = false
	player.PlayerGui.Gui.BackGround.VollyBG:SetAttribute("bool", false)
	game.ReplicatedStorage:WaitForChild("CheckGuifalse"):FireServer()
end)

player.PlayerGui.Gui.BackGround.CarBG.BG.XBtn.MouseButton1Click:Connect(function()
	player.PlayerGui.Gui.BackGround.CarBG.Visible = false
	player.PlayerGui.Gui.BackGround.CarBG:SetAttribute("bool", false)
	game.ReplicatedStorage:WaitForChild("CheckGuifalse"):FireServer()
end)

--------------------------------------------------------------------------------------------------------------------------------
local function ExitDeliveryGame()
	if player.PlayerGui.ExitGame.XBtn.Value.Value == "Delivery" then
		player.PlayerGui.ExitGame.ExitImage.Visible = false
		player.PlayerGui.ExitGame.XBtn.Visible = false
		local pack = player.Character:FindFirstChild("Package")
		if pack ~= nil then
			game.ReplicatedStorage:WaitForChild("ExitDelivery"):FireServer()
			target = nil
			NavigatorScript.Enable.Value = false
			ResetPlayerAnimation()
			destinationImage.Image = "rbxassetid://9233357963"
			checktuto = true
			if renderStepEventReference ~= nil then
				renderStepEventReference:Disconnect()
			end

			CheckMission = false
			MAX_Time = 40
			
			ShowTimer(false)
			--player.PlayerGui.DeliveryInformation.DeliveryInformationFrame.Time.Visible = false
			SetPlayerState:Fire(PlayerStates.NORMAL)
		end
	end
	
end

ExitDeleveryGameEvent.Event:Connect(function()
	ExitDeliveryGame()
	
end)
--------------------------------------------------------------------------------------------------------
--player.PlayerGui.ExitGame.XBtn.MouseButton1Click:Connect(function()
--	player.PlayerGui.ExitGame.ExitImage.Visible = true
--end)

--player.PlayerGui.ExitGame.ExitImage.YesButton.MouseButton1Click:Connect(function()
--	ExitDeliveryGame()
--	--if player.PlayerGui.ExitGame.XBtn.Value.Value == "Delivery" then
--	--	player.PlayerGui.ExitGame.ExitImage.Visible = false
--	--	player.PlayerGui.ExitGame.XBtn.Visible = false
--	--	local pack = player.Character:FindFirstChild("Package")
--	--	if pack ~= nil then
--	--		game.ReplicatedStorage:WaitForChild("ExitDelivery"):FireServer()
--	--		target = nil
--	--		NavigatorScript.Enable.Value = false
--	--		ResetPlayerAnimation()
--	--		--player.Character.Animate.walk.WalkAnim.AnimationId = defaultWalkAnimationId
--	--		--player.Character.Animate.run.RunAnim.AnimationId = defaultRunAnimationId
--	--		--player.Character.Animate.idle.Animation1.AnimationId = defaultIdleAnimationId
--	--		destinationImage.Image = "rbxassetid://9233357963"
--	--		checktuto = true
--	--		if renderStepEventReference ~= nil then
--	--			renderStepEventReference:Disconnect()
--	--		end

--	--		CheckMission = false
--	--		MAX_Time = 40
--	--		player.PlayerGui.DeliveryInformation.DeliveryInformationFrame.Time.Visible = false

--	--	end
--	--end
--end)

--player.PlayerGui.ExitGame.ExitImage.NoButton.MouseButton1Click:Connect(function()
--	player.PlayerGui.ExitGame.ExitImage.Visible = false
--end)
--------------------------------------------------------------------------------------------------
local function clickDeliveryObj(message)
	player.PlayerGui.Temp.BuyRanking.Visible = true
	UIManager:CheckVisible(player.PlayerGui.Temp.BuyRanking)
	player.PlayerGui.Temp.BuyRanking.BuyRankingTex.Text = message
end

game.Workspace.DeliveryObjects.Challenge.ClickDetector.MouseClick:Connect(function()
	clickDeliveryObj(game.Workspace.DeliveryObjects.Challenge.String.Value)
	--player.PlayerGui.Temp.BuyRanking.Visible = true
	--UIManager:CheckVisible(player.PlayerGui.Temp.BuyRanking)
	--player.PlayerGui.Temp.BuyRanking.BuyRankingTex.Text = game.Workspace.DeliveryObjects.Challenge.String.Value
end)

game.Workspace.DeliveryObjects.Champion.ClickDetector.MouseClick:Connect(function()
	clickDeliveryObj(game.Workspace.DeliveryObjects.Champion.String.Value)
	--player.PlayerGui.Temp.BuyRanking.Visible = true
	--UIManager:CheckVisible(player.PlayerGui.Temp.BuyRanking)
	--player.PlayerGui.Temp.BuyRanking.BuyRankingTex.Text = game.Workspace.DeliveryObjects.Champion.String.Value
end)

player.PlayerGui.Temp.BuyRanking.YESBtn.YESBtnTex.MouseButton1Click:Connect(function()
	
	if player.PlayerGui.Temp.BuyRanking.BuyRankingTex.Text == game.Workspace.DeliveryObjects.Challenge.String.Value then
		UnLockDeliveryRank(50,game.Workspace.DeliveryObjects.Challenge)
		--local coin = pointManager:GetValueClient("Coin")
		--if coin >= 50 then
		--	game.Workspace.DeliveryObjects.Challenge.CanCollide = false
		--	game.Workspace.DeliveryObjects.Challenge.Transparency = 1
		--	game.Workspace.DeliveryObjects.Challenge.SurfaceGui:Destroy()
		--	game.Workspace.DeliveryObjects.Challenge.CanTouch = false
		--	player.PlayerGui.Temp.BuyRanking.Visible = false
		--	game.Workspace.DeliveryObjects.Challenge.ClickDetector:Destroy()
		--	pointManager:IncreaseValueClient("Coin",-50)
		--else
		--	player.PlayerGui.Temp.NotCoin.Visible = true
		--	UIManager:CheckVisible(player.PlayerGui.Temp.NotCoin)
		--	player.PlayerGui.Temp.BuyRanking.Visible = false
		--	delay(3,function()
		--		player.PlayerGui.Temp.NotCoin.Visible = false
		--	end)
		--end
		player.PlayerGui.Temp.BuyRanking.Visible = false
	elseif player.PlayerGui.Temp.BuyRanking.BuyRankingTex.Text == game.Workspace.DeliveryObjects.Champion.String.Value then
		UnLockDeliveryRank(100,game.Workspace.DeliveryObjects.Champion)
		--local coin = pointManager:GetValueClient("Coin")
		--if coin >= 100 then
		--	game.Workspace.DeliveryObjects.Champion.CanCollide = false
		--	game.Workspace.DeliveryObjects.Champion.Transparency = 1
		--	game.Workspace.DeliveryObjects.Champion.SurfaceGui:Destroy()
		--	game.Workspace.DeliveryObjects.Champion.CanTouch = false
		--	pointManager:IncreaseValueClient("Coin",-100)
		--	game.Workspace.DeliveryObjects.Champion.ClickDetector:Destroy()
		--	player.PlayerGui.Temp.BuyRanking.Visible = false
		--else
		--	player.PlayerGui.Temp.NotCoin.Visible = true
		--	UIManager:CheckVisible(player.PlayerGui.Temp.NotCoin)
		--	player.PlayerGui.Temp.BuyRanking.Visible = false
		--	delay(3,function()
		--		player.PlayerGui.Temp.NotCoin.Visible = false
		--	end)
		--end


	end
end)

player.PlayerGui.Temp.BuyRanking.NoBtn.NOBtnTex.MouseButton1Click:Connect(function()
	player.PlayerGui.Temp.BuyRanking.Visible = false
end)