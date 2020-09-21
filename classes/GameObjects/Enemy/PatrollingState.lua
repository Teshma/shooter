PatrollingState = Object:extend()

function PatrollingState:new(enemy, patrol_points)
    self.points = patrol_points
    self.enemy = enemy
end

function PatrollingState:update(dt)
    
end

