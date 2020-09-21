EnemyStates = Object:extend()

function EnemyStates:new(enemy, points)
    self.patrolling_state = PatrollingState(enemy, points)
    --[[ self.alert_state = AlertState(enemy)
    self.standing_state = StandingState(enemy) ]]
    self.current_state = self.standing_state
end

function EnemyStates:update(dt)
    if self.current_state then self.current_state:update(dt) end
end