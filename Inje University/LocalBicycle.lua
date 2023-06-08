local bicycle = game.ReplicatedStorage:WaitForChild("Bicycle")

local nobicycle = game.ReplicatedStorage:WaitForChild("NoBicycle")

local btn = script.Parent.Ride

local nobtn = script.Parent.NoRide

btn.MouseButton1Up:Connect(function()
	bicycle:FireServer()
	btn.Visible = false
	nobtn.Visible = true
end)

nobtn.MouseButton1Up:Connect(function()
	nobicycle:FireServer()
	btn.Visible = true
	nobtn.Visible = false
end)