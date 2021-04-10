AlertState = Object:extend()

function AlertState:new(enemy_state_handler, enemy)
    self.enemy = enemy
    self.player = self.enemy.om.room.player
    self.esh = enemy_state_handler
    self.last_known_x = nil
    self.last_known_y = nil
end

function AlertState:update(dt)
    self.enemy.angle = math.atan2(self.player.y - self.enemy.y, self.player.x - self.enemy.x)
    self.enemy.collider:move(self.enemy.v*math.cos(self.enemy.angle)*dt, self.enemy.v*math.sin(self.enemy.angle)*dt)
    --[[ if self.shoot then -- shoot in bursts
        self.enemy.weapon:shoot(self.player.x, self.player.y)
    end ]]

end

function AlertState:enter()
    self.last_known_x = self.enemy.vision.player_x
    self.last_known_x = self.enemy.vision.player_y
	local initial_v = self.enemy.v
    self.enemy.timer:every(1, function() 
        self.enemy.v = 0
        self.enemy.weapon:shoot(self.player.x, self.player.y)
        self.enemy.timer:after(0.2, function() self.enemy.v = initial_v end) 
    end, self.enemy.uuid .. "_enemy_shoot") 
end

