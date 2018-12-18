Player = {}

function Player:new (o,Unit)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.Hp = getHP(Unit) or 0
    self.Mp = getMana(Unit) or 0
    self.dead = UnitIsDeadOrGhost(Unit)
    return o
end

function Player:printArea ()
    print(self.dead)
end

player = Player:new(nil,"player")

print(player.Hp)
player:printArea ()

buff = Player:new()
function buff:new(o,Unit,BuffID)
    o = o or Player:new(o,Unit)
    setmetatable(o,self)
    self.__index = self
    self.acc = UnitBuffID(Unit,BuffID)


