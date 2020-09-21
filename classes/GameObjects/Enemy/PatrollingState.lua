PatrollingState = Object:extend()

function PatrollingState:new(enemy)
    self.enemy = enemy
    self.points = self.enemy.patrol_points
    self.counter = 2
    if self.points then self.next_point = self.points[1] print(self.next_point[1]) end
    self.range = 3
    self.moving = true
end

function PatrollingState:update(dt)
    if not self.points then return end
    if self.next_point and self.moving then self:moveToNextPoint(self.next_point, dt) end
    --print(math.floor(self.enemy.x), self.next_point[1], math.floor(self.enemy.y), self.next_point[2])
    if distance(self.enemy.x, self.enemy.y, self.next_point[1], self.next_point[2]) < self.range then
        self.moving = false
        self:setNextPoint()
    end
end

function PatrollingState:moveToNextPoint(next_point, dt)
    local x,y = self.next_point[1], self.next_point[2]
    self.enemy.angle = math.atan2(y - self.enemy.y, x - self.enemy.x) -- calculate angle to x and y point
    self.enemy.collider:move(self.enemy.v*math.cos(self.enemy.angle)*dt, self.enemy.v*math.sin(self.enemy.angle)*dt) -- increase x and y value towards x and y point along the angle
end

function PatrollingState:setNextPoint()
    local max_counter = #self.points
    if self.counter > max_counter then self.counter = 1 end
    self.next_point = self.points[self.counter]
    self.counter = self.counter + 1
    self.moving = true
end