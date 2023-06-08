local shirtId = "http://www.roblox.com/asset/?id=4243503648"
local pantsId = "http://www.roblox.com/asset/?id=7173758939"
local clickdr = script.Parent.ClickDetector

function OnClick(player)
	local foundshirt = player.Character:FindFirstChild("Shirt")
	if not foundshirt then
		local newShirt = Instance.new("Shirt", player.Character)
		newShirt.Name = "Shirt"
	else if foundshirt then
			player.Character.Shirt:remove()
			local newShirt = Instance.new("Shirt", player.Character)
			newShirt.Name = "Shirt"
		end 
	end
	
	local foundPants = player.Character:FindFirstChild("Pants")
	if not foundPants then
		local newPants = Instance.new("Pants", player.Character)
		newPants.Name = "Pants"
	else if foundPants then
			player.Character.Pants:remove()
			local newPants = Instance.new("Pants", player.Character)
			newPants.Name = "Pants"
		end
	end
	player.Character.Shirt.ShirtTemplate = shirtId
	player.Character.Pants.PantsTemplate = pantsId
	
	local hatremove = player.Character:GetChildren()
	for i = 1, #hatremove do
		if hatremove[i].className == "Accessory" or hatremove[i].className == "Hat" then
			hatremove[i]:remove()
		end
	end
	local Hat = Instance.new("Hat", player.Character)
	local Handle = Instance.new("Part", Hat)
	local Mesh = Instance.new("SpecialMesh", Handle)
	local weld = Instance.new("Weld", player.Character.Head)
	Hat.Name = "Tophat"
	Handle.Position = player.Character:FindFirstChild("Head").Position
	Handle.Name = "Handle"
	Handle.Size = Vector3.new(2, 1, 1)
	Handle.formFactor = 0
	Handle.BottomSurface = 0
	Handle.TopSurface = 0
	Handle.Locked = true
	Handle.CanCollide = false
	Mesh.Name = "Mesh"
	Mesh.MeshId = "http://www.roblox.com/asset/?id=1051545 "
	Mesh.TextureId = "http://www.roblox.com/asset/?id=1051546 "
	weld.Name = "HeadWeldHandle"
	Hat.AttachmentPos = Vector3.new(0, 0.3, 0)
	weld.Part0 = player.Character.Head
	weld.Part1 = Handle
	Mesh.Offset = Vector3.new(0, 0.2, 0)
end

clickdr.MouseClick:Connect(OnClick)