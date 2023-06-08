local bicycleevent = game.ReplicatedStorage:WaitForChild("Bicycle")

local nobiycle = game.ReplicatedStorage:WaitForChild("NoBicycle") 

local Bicycle = game.ServerStorage:WaitForChild("Bicycle")

bicycleevent.OnServerEvent:Connect(function(character)
	local gearName = Bicycle.Name
	local name = character.Name
	
	local obj = workspace:FindFirstChild(name)
	local human = obj:WaitForChild("Humanoid")
	
	local target = human:FindFirstChild(gearName)
	if target ~= nil then
		return
	end
	
	local bicycle = Bicycle:Clone()
	bicycle.Parent = human
	human.Parent.Animate.walk.WalkAnim.AnimationId = "rbxassetid://8783706489"
	human.Parent.Animate.idle.Animation1.AnimationId = "rbxassetid://8783706489"
	human.Parent.Animate.idle.Animation2.AnimationId = "rbxassetid://8783706489"
	human.Parent.Animate.run.RunAnim.AnimationId = "rbxassetid://8783706489"
	human.Parent.Animate.jump.JumpAnim.AnimationId = "rbxassetid://8783706489"
	human.Parent.Animate.fall.FallAnim.AnimationId = "rbxassetid://8783706489"
	local weld = Instance.new("Weld")
	weld.Parent = human.Parent.LowerTorso
	weld.Part0 = human.Bicycle.Seat
	weld.Part1 = human.Parent.LowerTorso
	
	human.WalkSpeed = 50
	human.Parent.HumanoidRootPart.Position = human.Parent.HumanoidRootPart.Position + Vector3.new(0,0.85,0)
end)

nobiycle.OnServerEvent:Connect(function(character)
	local gearName = Bicycle.Name
	local name = character.Name

	local obj = workspace:FindFirstChild(name)
	local humanoid = obj:WaitForChild("Humanoid")

	humanoid.Bicycle:Destroy()
	humanoid.Parent.Animate.walk.WalkAnim.AnimationId = "rbxassetid://913402848"
	humanoid.Parent.Animate.idle.Animation1.AnimationId = "rbxassetid://507766388"
	humanoid.Parent.Animate.idle.Animation2.AnimationId = "rbxassetid://507766666"
	humanoid.Parent.Animate.run.RunAnim.AnimationId = "rbxassetid://913376220"
	humanoid.Parent.Animate.jump.JumpAnim.AnimationId = "rbxassetid://507765000"
	humanoid.Parent.Animate.fall.FallAnim.AnimationId = "rbxassetid://507767968"

	humanoid.WalkSpeed = 16
end)