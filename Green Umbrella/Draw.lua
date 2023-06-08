--서비스
local Player = game:GetService("Players").LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

--맵변수
local camera = workspace.Camera
local Mouse = Player:GetMouse();
local drawSave = Player.Character.DrawSave

--지역변수
local pos = nil
local Down = false;
local Size = 0.1;
local color = BrickColor.new("Really black")
local DrawParent = nil
local Parents = {}

--이벤트
local Event_DrawErase = ReplicatedStorage:WaitForChild("DrawErase")
local Event_DrawColor = ReplicatedStorage:WaitForChild("DrawColor")

function WeldParts(Part1, Part2)
	local Weld = Instance.new("Weld")
	Weld.Part0 = Part2
	Weld.Part1 = Part1
	Weld.C0 = Part2.CFrame:toObjectSpace(Part1.CFrame)
	Weld.Parent = Part2
end

function MakeParent()
	DrawParent = Instance.new("Part", drawSave)
	DrawParent.Name = "drawparent"
	DrawParent.Anchored = true;
	DrawParent.CanCollide = false;
	DrawParent.Locked = true;
	DrawParent.Transparency = 1;
	table.insert(Parents,DrawParent)
end

function Draw(mouse)
	Down = true;
	coroutine.resume(coroutine.create(function()
		mouse.Button1Up:wait();
		Down = false;
	end))
	local Part = Instance.new("Part", DrawParent);
	Part.Name = "DrawPart";
	Part.Size = Vector3.new(1, 0.5, 0.5);
	Part.Anchored = true;
	Part.TopSurface = 0;
	Part.BottomSurface = 0;
	Part.CanCollide = false;
	Part.BrickColor = BrickColor.new("Really black");
	Part.Locked = true;
	local Mesh = Instance.new("BlockMesh", Part);
	local Target = Mouse.Target;
	local Hit = Mouse.Hit.p;

	while Down do
		local Magnitude = (Hit - Mouse.Hit.p).magnitude;
		Mesh.Scale = Vector3.new(Size, 0.4, (Magnitude+(Size/3))*2)
		Part.CFrame = CFrame.new(Hit, Mouse.Hit.p) * CFrame.new(0, 0, -Magnitude/2 - Size/5)
		if Magnitude > Size/2+0.1 then
			Draw(mouse)
			if Target ~= nil then
				if not Target.Anchored then
					Part.Anchored = false;
					WeldParts(Part, Target);
				end
			end
			break;
		end
		wait();
	end
end

UserInputService.InputBegan:connect(function(input, gameProcessedEvent)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		pos = Mouse.Hit.p
		MakeParent()
		Draw(Mouse)
	elseif input.UserInputType == Enum.UserInputType.Touch then
		pos = Mouse.Hit.p
		MakeParent()
		Draw(Mouse)
	end	
end)
UserInputService.InputEnded:connect(function(input, gameProcessedEvent)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		Down = false
	elseif input.UserInputType == Enum.UserInputType.Touch then
		Down = false
	end
end)

Event_DrawErase.Event:connect(function(str)
	for i = 1, #DrawParent do
		if DrawParent[i].Name == str then
			table.remove(DrawParent, i)
		end
	end
end)

Event_DrawColor.Event:connect(function(col)
	local c = BrickColor.new(col.R, col.G, col.B)
	color = c
end)