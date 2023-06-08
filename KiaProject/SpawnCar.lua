local BackGround = script.Parent

local CarSpawnBtn = BackGround.Parent.CarSpawnBtn

local WhiteCarSpawnBtn = script.Parent.ImageBackGround.WhiteCar.ImageLabel.TextButton

local BlackCarSpawnBtn = script.Parent.ImageBackGround.Black.ImageLabel.TextButton

local GrayCarSpawnBtn = script.Parent.ImageBackGround.Gray.ImageLabel.TextButton

local BlueCarSpawnBtn = script.Parent.ImageBackGround.Blue.ImageLabel.TextButton

local RedCarSpawnBtn = script.Parent.ImageBackGround.Red.ImageLabel.TextButton

local GreenCarSpawnBtn = script.Parent.ImageBackGround.Green.ImageLabel.TextButton

local InGrayCarSpawnBtn = script.Parent.ImageBackGround.InterstellarGray.ImageLabel.TextButton

local RemoteEventFolder = game.ReplicatedStorage:WaitForChild("SpawnHouseCar")

local XBtn = script.Parent.ImageBackGround.XBtn

local Uimanager = require(game.ReplicatedStorage.UImanager)

CarSpawnBtn.MouseButton1Up:Connect(function()
	BackGround.Visible = true
	Uimanager:CheckVisible(BackGround)
end)

WhiteCarSpawnBtn.MouseButton1Up:Connect(function(plrname)
	local player = game.Players.LocalPlayer.Name
	plrname = player
	RemoteEventFolder.WhiteCar:FireServer(plrname)
	BackGround.Visible = false
end)

BlackCarSpawnBtn.MouseButton1Up:Connect(function(plrname)
	local player = game.Players.LocalPlayer.Name
	plrname = player
	RemoteEventFolder.BlackCar:FireServer(plrname)
	BackGround.Visible = false
end)

GrayCarSpawnBtn.MouseButton1Up:Connect(function(plrname)
	local player = game.Players.LocalPlayer.Name
	plrname = player
	RemoteEventFolder.GrayCar:FireServer(plrname)
	BackGround.Visible = false
end)

BlueCarSpawnBtn.MouseButton1Up:Connect(function(plrname)
	local player = game.Players.LocalPlayer.Name
	plrname = player
	RemoteEventFolder.BlueCar:FireServer(plrname)
	BackGround.Visible = false
end)

RedCarSpawnBtn.MouseButton1Up:Connect(function(plrname)
	local player = game.Players.LocalPlayer.Name
	plrname = player
	RemoteEventFolder.RedCar:FireServer(plrname)
	BackGround.Visible = false
end)

GreenCarSpawnBtn.MouseButton1Up:Connect(function(plrname)
	local player = game.Players.LocalPlayer.Name
	plrname = player
	RemoteEventFolder.GreenCar:FireServer(plrname)
	BackGround.Visible = false
end)

InGrayCarSpawnBtn.MouseButton1Up:Connect(function(plrname)
	local player = game.Players.LocalPlayer.Name
	plrname = player
	RemoteEventFolder.InGrayCar:FireServer(plrname)
	BackGround.Visible = false
end)

XBtn.MouseButton1Up:Connect(function()
	BackGround.Visible = false
end)
