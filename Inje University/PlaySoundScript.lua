local sound = game.ReplicatedStorage:WaitForChild("soundplay")
local muisc = game.Workspace.SoundBar.muisc

sound.OnClientEvent:Connect(function()
	muisc:Play()
end)