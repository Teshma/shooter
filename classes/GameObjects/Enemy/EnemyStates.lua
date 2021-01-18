EnemyStates = Object:extend()

function EnemyStates:new(enemy)
    self.patrolling_state = PatrollingState(self, enemy)
    --self.alert_state = AlertState(self, enemy)
    self.standing_state = StandingState(self, enemy)
    self.current_state = self.patrolling_state
end

function EnemyStates:update(dt)
    if self.current_state then self.current_state:update(dt) end
end

function EnemyStates:refresh(enemy)
    self.patrolling_state = nil
    self.patrolling_state = PatrollingState(enemy)
end

function EnemyStates:setState(state)
    if state == "Patrol" then
        self.current_state = self.patrolling_state
    end
    if state == "Wait" then
        self.current_state = self.standing_state
    end
    self.current_state:enter()
end