MapLoader = Object:extend()

function MapLoader:new(mapPath, objectManager)
    self.mapPath = mapPath
    self.map = sti(self.mapPath)
    self.ObjectManager = objectManager
    return self
end

function MapLoader:spawnMapCollisions()
	if self.map == nil then return end
	for k, object in pairs(self.map.objects) do
		if object.name == "collision_box" then
			self.ObjectManager:addGameObject("Wall", object.x, object.y, 
			{w = object.width, h = object.height, collider = Collider.rectangle(object.x, object.y, object.width, object.height)})
		end
	end
end