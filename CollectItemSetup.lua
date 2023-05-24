local module = {}

local TweenService = game:GetService("TweenService")

local LocalPlayer = game.Players.LocalPlayer

function module.SetupCollectItem(item, value, name)

	local switchTurnLoop = true

	-- rotating always collectable part
	local TurnLoop = function()

		local TurnTime = 2
		local UpDownTime = 1

		--TweenService:Create(
		--	item,
		--	TweenInfo.new(
		--		UpDownTime,
		--		Enum.EasingStyle.Sine,
		--		Enum.EasingDirection.InOut,
		--		-1,
		--		true,
		--		0),
		--	{Position = item.Position + Vector3.new(0,1,0)}
		--)
		--:Play()

		while switchTurnLoop do
			TweenService:Create(
				item,
				TweenInfo.new(TurnTime/3, Enum.EasingStyle.Linear),
				{Orientation = item.Orientation + Vector3.new(0,120,0)}
			)
			:Play()
			task.wait(TurnTime/3)
		end
	end

	-- On collectable part touched
	local OnTouched = function(hit: Instance)

		if switchTurnLoop == false then return end
		if hit.Parent:FindFirstChild("Humanoid") == nil then return end
		if hit.Parent ~= LocalPlayer.Character then return end
		item.CanTouch = false
		item.CanCollide = false
		if name == "Alchole" then
			value.Value += 1
			LocalPlayer.PlayerGui.ItemGui.AlcohlFrame.AlcohlText.Text = value.Value
		elseif name == "Portion" then
			LocalPlayer.Character.Humanoid.Health += math.random(10, 30)
			item.Sparkles.Enabled = false
		elseif name == "Radiation" then
			value.Value += 1
			LocalPlayer.PlayerGui.ItemGui.RadiationFrame.RadiationText.Text = value.Value
		elseif name == "Wet Tissue" then
			local ForceField = LocalPlayer.Character:FindFirstChild("ForceField")
			if ForceField ~= nil then
				local forcefield = Instance.new("ForceField",LocalPlayer.Character)
				delay(math.random(10,15),function()
					forcefield:Destroy()
				end)
			end
			game.ReplicatedStorage.TowerEvents.WetTissue:FireServer()
		end


		switchTurnLoop = false


		item.Sound:Play()

		local TouchedTurnTime = 0.4
		TweenService:Create(
			item,
			TweenInfo.new(TouchedTurnTime, Enum.EasingStyle.Sine,Enum.EasingDirection.In),
			{Position = item.Position + Vector3.new(0,2,0)}
		)
		:Play()
		for j = 1, 2 do
			for i=1,3 do
				TweenService:Create(
					item,
					TweenInfo.new(TouchedTurnTime/6, Enum.EasingStyle.Linear),
					{Orientation = item.Orientation + Vector3.new(0,120,0)}
				)
				:Play()
				task.wait(TouchedTurnTime/6)
			end
		end

		item.Transparency = 1
		--item:Destroy()

	end

	local coTurnLoop = coroutine.create(TurnLoop)
	coroutine.resume(coTurnLoop)


	item.Touched:Connect(OnTouched)
	LocalPlayer.Character.Humanoid.Died:Connect(function()
		local TouchedTurnTime = 0.1
		TweenService:Create(
			item,
			TweenInfo.new(TouchedTurnTime, Enum.EasingStyle.Sine,Enum.EasingDirection.In),
			{Position = item.Position + Vector3.new(0,-2,0)}
		):Play()
		item.Transparency = 0
		item.CanTouch = true
		item.CanCollide = false
	end)
	
	game.ReplicatedStorage.DiedEvent.Died.OnClientEvent:Connect(function()
		local TouchedTurnTime = 0.1
		TweenService:Create(
			item,
			TweenInfo.new(TouchedTurnTime, Enum.EasingStyle.Sine,Enum.EasingDirection.In),
			{Position = item.Position + Vector3.new(0,-2,0)}
		):Play()
		item.Transparency = 0
		item.CanTouch = true
		item.CanCollide = false
	end)
end

return module