local sound = game.ReplicatedStorage:WaitForChild("soundplay")

function soundplay(part)
	local human = part.Parent:FindFirstChild("Humanoid")
	local player = game.Players:GetPlayerFromCharacter(part.Parent)
	if human ~= nil then
		sound:FireClient(player)
	end
end

script.Parent.Touched:Connect(soundplay)