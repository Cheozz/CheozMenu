-- CHEOZ MENU (VERSÃO DOS DEUSES - DEFINITIVA MOBILE)

if _G.CheozPermitido ~= "CHEOZ_AUTH_9921" then return end

local a=game:GetService("Players");local b=game:GetService("RunService");local c=game:GetService("UserInputService");local d=game:GetService("TweenService");local e=a.LocalPlayer;local f=workspace.CurrentCamera;local g=Vector2.new;local h=Vector3.new;local k=tick;local m=true;

-- CONFIGURAÇÕES (VALORES PADRÃO)
_G.AimbotEnabled=false;_G.TeamCheck=false;_G.TargetPart="HumanoidRootPart";_G.Smoothness=0.5;
_G.KillDelayEnabled=false;_G.DelayTime=1.0;_G.AimbotFOV=100;_G.ShowFOV=false;
_G.ESP_Skeleton=false;_G.ESP_Box=false;_G.ESP_Tracers=false;_G.ESP_Color=Color3.fromRGB(170,0,255);

local o={}local t=0;
local p={Color3.fromRGB(170,0,255), Color3.fromRGB(0,255,127), Color3.fromRGB(255,50,50), Color3.fromRGB(0,255,255), Color3.fromRGB(15,15,15), Color3.fromRGB(25,25,25), Color3.fromRGB(35,35,35), Color3.fromRGB(45,45,45)}

-- CÍRCULO DE FOV
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5; FOVCircle.NumSides = 60; FOVCircle.Radius = _G.AimbotFOV; FOVCircle.Filled = false; FOVCircle.Visible = false; FOVCircle.Color = _G.ESP_Color

local function C(D)
    if not _G.TeamCheck then return true end
    return e.Team ~= D.Team
end

-- FUNÇÃO DE MOVIMENTO MOBILE (Suporte para Delta, Fluxus, Codex)
local function MoveCamera(TargetPos)
    local LookVector = (TargetPos - f.CFrame.Position).Unit
    local NewCFrame = CFrame.new(f.CFrame.Position, f.CFrame.Position + LookVector)
    f.CFrame = f.CFrame:Lerp(NewCFrame, _G.Smoothness / 2)
end

local function S()
    if _G.KillDelayEnabled and (k()-t) < _G.DelayTime then return nil end
    local T, U = nil, _G.AimbotFOV;
    local V = g(f.ViewportSize.X/2, f.ViewportSize.Y/2)
    for _,Y in pairs(a:GetPlayers()) do
        if Y~=e and Y.Character and Y.Character:FindFirstChild("Humanoid") and Y.Character.Humanoid.Health > 0 and C(Y) then
            local Z = Y.Character:FindFirstChild(_G.TargetPart)
            if Z then
                local pos, visible = f:WorldToViewportPoint(Z.Position)
                if visible then
                    local dist = (g(pos.X, pos.Y) - V).Magnitude
                    if dist < U then U = dist; T = Y end
                end
            end
        end
    end; return T
end

local function ac()
    local ad = (gethui and gethui()) or game:GetService("CoreGui")
    if ad:FindFirstChild("CheozMenuMobile") then ad.CheozMenuMobile:Destroy() end;
    local ae = Instance.new("ScreenGui", ad); ae.Name = "CheozMenuMobile"
    
    -- Botão C (Abre/Fecha)
    local btnC = Instance.new("TextButton", ae); btnC.Size=UDim2.new(0,55,0,55); btnC.Position=UDim2.new(0.02,0,0.4,0); btnC.Text="C"; btnC.BackgroundColor3=Color3.fromRGB(15,15,15); btnC.TextColor3=_G.ESP_Color; btnC.Font=Enum.Font.LuckiestGuy; btnC.TextSize=32; Instance.new("UICorner",btnC).CornerRadius=UDim.new(1,0); Instance.new("UIStroke",btnC).Color=_G.ESP_Color

    local af = Instance.new("CanvasGroup", ae); af.Size=UDim2.new(0,500,0,450); af.Position=UDim2.new(0.5,-250,0.5,-225); af.BackgroundColor3=Color3.fromRGB(15,15,15); af.Visible=false; af.GroupTransparency=1; Instance.new("UICorner",af); Instance.new("UIStroke",af).Color=_G.ESP_Color

    -- Seções (Combat e Visuals)
    local function ak(pos)
        local an = Instance.new("ScrollingFrame", af); an.Size=UDim2.new(0.45,0,0.75,0); an.Position=UDim2.new(pos,0,0.12,0); an.BackgroundTransparency=1; an.CanvasSize=UDim2.new(0,0,1.2,0);
        local ui = Instance.new("UIListLayout", an); ui.Padding=UDim.new(0,8); ui.HorizontalAlignment="Center"; return an
    end
    local aq = ak(0.03); local as = ak(0.52)

    local function createBtn(parent, text, var)
        local b = Instance.new("TextButton", parent); b.Size=UDim2.new(0.9,0,0,35); b.Text=text; b.BackgroundColor3=Color3.fromRGB(35,35,35); b.TextColor3=Color3.new(1,1,1); Instance.new("UICorner",b)
        b.MouseButton1Click:Connect(function() _G[var]=not _G[var]; b.BackgroundColor3=_G[var] and _G.ESP_Color or Color3.fromRGB(35,35,35) end)
    end

    local function createStepper(parent, text, var, inc, min, max)
        local f = Instance.new("Frame", parent); f.Size=UDim2.new(0.9,0,0,40); f.BackgroundTransparency=1
        local l = Instance.new("TextLabel", f); l.Size=UDim2.new(1,0,0,15); l.Text=text..": "..tostring(_G[var]); l.TextColor3=Color3.new(1,1,1); l.BackgroundTransparency=1
        local m = Instance.new("TextButton", f); m.Size=UDim2.new(0,30,0,20); m.Position=UDim2.new(0,0,0.5,0); m.Text="-"; m.BackgroundColor3=Color3.fromRGB(40,40,40); Instance.new("UICorner", m)
        local p = Instance.new("TextButton", f); p.Size=UDim2.new(0,30,0,20); p.Position=UDim2.new(1,-30,0.5,0); p.Text="+"; p.BackgroundColor3=Color3.fromRGB(40,40,40); Instance.new("UICorner", p)
        m.MouseButton1Click:Connect(function() _G[var]=math.max(min, _G[var]-inc); l.Text=text..": "..string.format("%.1f", _G[var]) end)
        p.MouseButton1Click:Connect(function() _G[var]=math.min(max, _G[var]+inc); l.Text=text..": "..string.format("%.1f", _G[var]) end)
    end

    createBtn(aq, "ATIVAR AIMBOT", "AimbotEnabled")
    createBtn(aq, "TEAM CHECK", "TeamCheck")
    createBtn(aq, "KILL DELAY", "KillDelayEnabled")
    createBtn(aq, "SHOW FOV", "ShowFOV")
    createStepper(aq, "DELAY", "DelayTime", 0.1, 0, 5)
    createStepper(aq, "SMOOTH", "Smoothness", 0.1, 0.1, 1)
    createStepper(aq, "FOV SIZE", "AimbotFOV", 10, 10, 500)

    createBtn(as, "ESP BOXES", "ESP_Box")
    createBtn(as, "ESP SKELETON", "ESP_Skeleton")
    createBtn(as, "ESP TRACERS", "ESP_Tracers")

    btnC.MouseButton1Click:Connect(function()
        af.Visible = not af.Visible
        d:Create(af, TweenInfo.new(0.3), {GroupTransparency = af.Visible and 0 or 1}):Play()
    end)
end

b.RenderStepped:Connect(function()
    if not m then return end
    FOVCircle.Visible = _G.ShowFOV; FOVCircle.Radius = _G.AimbotFOV; FOVCircle.Position = g(f.ViewportSize.X/2, f.ViewportSize.Y/2); FOVCircle.Color = _G.ESP_Color
    
    if _G.AimbotEnabled then
        local target = S()
        if target and target.Character then
            local part = target.Character:FindFirstChild(_G.TargetPart)
            if part then MoveCamera(part.Position) end
        else
            t = k()
        end
    end
end)
pcall(ac)
