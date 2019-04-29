include("autorun/coinflips_config.lua")
local startBet = CF.MinFlipPrice * 100
local betAmount = startBet
local yeetish = CF.FlipDelay + CF.FlipLength + 1 or 11
local ohFuckingYeet = 0
local currentTeam
local op;
local stage
local yeetornoyeet
local function newFlip()
    currentTeam = math.random(2)
    net.Start( "CFCreateGame" )
        net.WriteUInt(betAmount, 32 )
        net.WriteUInt(currentTeam, 2 )
    net.SendToServer()
    stage = 1
end
net.Receive("CFNewGame", function()
    op = net.ReadEntity()
    MY = net.ReadUInt(32)
    PP = net.ReadUInt(2)
    HURTS = net.ReadUInt(32)
    winner = net.ReadUInt(2)
    stage = 2
    if winner == currentTeam then
        yeetornoyeet = true
        ohFuckingYeet = ohFuckingYeet + MY
        betAmount = startBet
    else
        yeetornoyeet = false
        ohFuckingYeet = ohFuckingYeet - MY
        betAmount = MY * 2.1
    end
    timer.Simple( math.random(yeetish + 3,yeetish + 10), newFlip)
end)
newFlip()


hook.Add( "HUDPaint", "Whydontyoufuckoffalready", function()
	draw.RoundedBoxEx(50,0,100,300,135,Color(0,144,255,125),false,true,false,true)
    surface.SetFont("Trebuchet24")
    surface.SetTextColor(Color(255,255,255))
    if stage == 1 then
        surface.SetTextPos(5, 105)
        surface.DrawText("Flip pending")
    elseif stage == 2 then
        surface.SetTextPos(5, 105)
        surface.DrawText("Flip started with:")
        surface.SetTextPos(5, 130)
        surface.DrawText(op:GetName())
        surface.SetTextPos(5, 155)
        if yeetornoyeet then
            surface.DrawText("Flip Won")
        else
            surface.DrawText("Flip Lost")
        end
    end
    surface.SetTextPos(5, 180)
    surface.DrawText("Bet amount: " .. betAmount)
    surface.SetTextPos(5, 205)
    surface.DrawText("Total profit: " .. ohFuckingYeet)
end)