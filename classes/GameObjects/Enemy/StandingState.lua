StandingState = Object:extend()

function StandingState:new(enemy_state_handler, enemy)
    self.enemy = enemy
    self.esh = enemy_state_handler
    self.timer = Timer()
end

function StandingState:update(dt)
    if self.timer then self.timer:update(dt) end 
    
end

function StandingState:enter()
    self.timer:after(self.enemy.stand_time, function() self.esh:setState("Patrol") end)
end