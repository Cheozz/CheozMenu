-- [[ TRAVA DE SEGURANÇA CHEOZ ]]
if _G.CheozPermitido ~= "CHEOZ_AUTH_9921" then 
    print("ACESSO BLOQUEADO: Este script so funciona atraves do Main.lua oficial.")
    return 
end

local a=game:GetService("Players");local b=game:GetService("RunService");local c=game:GetService("UserInputService");local d=game:GetService("TweenService");local e=a.LocalPlayer;local f=workspace.CurrentCamera;local g=Vector2.new;local h=Vector3.new;local i=math.clamp;local j=math.huge;local k=tick;local l=mousemoverel or(Input and Input.MouseMove)or function()end;local m=true;_G.AimbotEnabled=false;_G.TeamCheck=false;_G.TargetPart="Head";_G.AimBind=Enum.KeyCode.E;_G.Smoothness=1.0;_G.KillDelayEnabled=false;_G.DelayTime=1.0;_G.ESP_Skeleton=false;_G.ESP_Box=false;_G.ESP_HeadCircle=false;_G.ESP_Tracers=false;_G.ESP_Color=Color3.fromRGB(170,0,255);local n={}local o={}local p={Color3.fromRGB(170,0,255),Color3.fromRGB(0,255,127),Color3.fromRGB(255,50,50),Color3.fromRGB(0,255,255)}local q={Color3.fromRGB(255,255,0),Color3.fromRGB(255,120,0),Color3.fromRGB(255,255,255),Color3.fromRGB(0,100,255)}local r={Color3.fromRGB(60,0,100),Color3.fromRGB(0,20,100),Color3.fromRGB(30,60,30),Color3.fromRGB(40,40,40)}local s=nil;local t=0;local function u(v)local w,x,y,z;v.InputBegan:Connect(function(A)if A.UserInputType==Enum.UserInputType.MouseButton1 then w=true;y=A.Position;z=v.Position;A.Changed:Connect(function()if A.UserInputState==Enum.UserInputState.End then w=false end end)end end);v.InputChanged:Connect(function(A)if A.UserInputType==Enum.UserInputType.MouseMovement then x=A end end);b.RenderStepped:Connect(function()if w and x then local B=x.Position-y;v.Position=UDim2.new(z.X.Scale,z.X.Offset+B.X,z.Y.Scale,z.Y.Offset+B.Y)end end)end;

-- FIX PARA ARSENAL (BYPASS GETTEAM ERROR)
local function C(D)
    if not _G.TeamCheck then return true end
    local myTeam = e.Team or e:GetAttribute("Team")
    local enemyTeam = D.Team or D:GetAttribute("Team")
    if myTeam ~= enemyTeam then return true end
    return false
end
