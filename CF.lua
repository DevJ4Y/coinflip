include("autorun/coinflips_config.lua")
local betAmount = CF.MinFlipPrice * 100
local yeetish = CF.FlipDelay + CF.FlipLength + 1 or 11
local multiYote = 1.5
local ohFuckingYeet = 0
local currentTeam
local op;
local function newFlip()
    currentTeam = math.random(2)
    print("New flip -- Team: " .. currentTeam)
    net.Start( "CFCreateGame" )
        net.WriteUInt(betAmount, 32 )
        net.WriteUInt(currentTeam, 2 )
    net.SendToServer()
end
net.Receive( "CFNewGame", function()
    op = net.ReadEntity()
    MY = net.ReadUInt(32)
    PP = net.ReadUInt(2)
    HURTS = net.ReadUInt(32)
    winner = net.ReadUInt(2)
    print("Flip started with " .. op:GetName())
    print("Winning team: " .. winner)
    if winner == currentTeam then
        print("Flip Won")
        ohFuckingYeet = ohFuckingYeet + betAmount
        betAmount = betAmount * multiYote
        multiYote = multiYote + 0.1
    else
        print("Flip Lost")
        ohFuckingYeet = ohFuckingYeet - betAmount
        betAmount = CF.MinFlipPrice * 10
        multiYote = 1.5
    end
    print("Total profit: " .. ohFuckingYeet)
    timer.Simple( math.random(yeetish + 3,yeetish + 10), newFlip)
end)
newFlip()