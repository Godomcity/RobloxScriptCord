local Player = game:GetService("Players").LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Event_DrawErase = ReplicatedStorage:WaitForChild("DrawErase")
local UserInputService = game:GetService("UserInputService")
local Mouse = Player:GetMouse();
local pos = nil
local Down = false;

function Erase()
	while Down do
		--local target = Mouse.Hit
		--if target.Position == drawpartpos then
		--	Event_DrawErase:Fire(target.Parent.Name)
		--	target:Destroy()
		--end
		local save = nil;
		local children = Player.Character:GetChildren()
		
		for i = 1, #children do
			if "DrawSave" == children[i].Name then
				save = children[i]
				local savechild = save:GetChildren()
				local drawparent = nil
				for i = 1, #savechild do
					if "drawparent" == savechild[i].Name then
						drawparent = savechild[i]
						local drawchild = drawparent:GetChildren()
						local drawpartpostion = nil
						local mousePosition = Mouse.Hit.Position;
						local distance = 0;
						local temp = nil
						for i = 1, #drawchild do
							if "DrawPart" == drawchild[i].Name then
								drawpartpostion = drawchild[i].CFrame:PointToWorldSpace()
							end

							temp = drawpartpostion - mousePosition
							temp = (math.pow(temp.x, 2) + math.pow(temp.y,2) + math.pow(temp.z,2))
							temp = math.sqrt(temp);

							--print(temp)
							if temp < 1 then
								--drawparent:Destroy()
								drawchild[i]:Destroy()							end
						end
						
					end
				end
				
			end
		end
---------------------------------------------------	
		
-------------------------------------------	
		
--------------------------------------------		
		
		wait()
	end
end

UserInputService.InputBegan:connect(function(input, gameProcessedEvent)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		Down = true
		Erase()
	elseif input.UserInputType == Enum.UserInputType.Touch then
		Down = true
		Erase()
	end	
end)

UserInputService.InputEnded:connect(function(input, gameProcessedEvent)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		Down = false
	elseif input.UserInputType == Enum.UserInputType.Touch then
		Down = false
	end
end)