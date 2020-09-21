EnemyStates = Object:extend()

function EnemyStates:new(enemy)
    self.patrolling_state = PatrollingState(enemy)
    --[[ self.alert_state = AlertState(enemy)
    self.standing_state = StandingState(enemy) ]]
    self.current_state = self.patrolling_state
end

function EnemyStates:update(dt)
    if self.current_state then self.current_state:update(dt) end
end

function EnemyStates:refresh(enemy)
    self.patrolling_state = nil
    self.patrolling_state = PatrollingState(enemy)
end