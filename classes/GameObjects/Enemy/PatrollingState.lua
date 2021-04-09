PatrollingState = Object:extend()

function PatrollingState:new(enemy_state_handler, enemy)
    self.enemy = enemy
    self.esh = enemy_state_handler
    self.points = self.enemy.patrol_points
    self.counter = 2
    self.angle_set = false
    if self.points then self.next_point = self.points[1] print(self.next_point[1]) end
    self.timer = Timer()
    self.range = 3
    self.enemy.moving = true
end

function PatrollingState:update(dt)
    if not self.points then return end
    if self.next_point and self.enemy.moving then self:moveToNextPoint(self.next_point, dt) end
    if distance(self.enemy.x, self.enemy.y, self.next_point[1], self.next_point[2]) < self.range then
        self.moving = false
        self:setNextPoint()
        self.angle_set = false
    end
end

function PatrollingState:enter()
    self.enemy.moving = true
end


function PatrollingState:moveToNextPoint(next_point, dt)
    local x,y = self.next_point[1], self.next_point[2]
    
    if self.angle_set then
        self.enemy.collider:move(self.enemy.v*math.cos(self.enemy.angle)*dt, self.enemy.v*math.sin(self.enemy.angle)*dt) -- increase x and y value towards x and y point along the angle
    else
        self:setAngle(x, y, dt)
    end
end

function PatrollingState:setAngle(x, y, dt)
    local angle = math.atan2(y - self.enemy.y, x - self.enemy.x)
    self.enemy.angle = self.enemy.angle + (angle - self.enemy.angle)*2*dt
    if math.floor(1000*self.enemy.angle) == math.floor(1000*angle) then print(true) self.angle_set = true end
end

function PatrollingState:setNextPoint()
    local max_counter = #self.points
    if self.counter > max_counter then self.counter = 1 end
    self.next_point = self.points[self.counter]
    self.counter = self.counter + 1
    self.esh:setState("Wait")
end