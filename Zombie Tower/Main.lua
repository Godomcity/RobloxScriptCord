workspace.Zombie.ChildAdded:Connect(function(zom:Model)
	if not zom:IsA('Model') then return end
	
	script.Animation:Clone().Parent = zom
	require(zom:WaitForChild("Animation"))
end)

workspace.GiantZombie.ChildAdded:Connect(function(gz)
	script.Animation:Clone().Parent = gz
	require(gz:WaitForChild("Animation"))
end)