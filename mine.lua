local anim = require "utils/animation"
local filters = require "utils/collisionFilters"
require "lib/class"

local mines = {}
local mineID = 1
local spritesheet = love.graphics.newImage("assets/mine.png")

Mine = class(function(obj, id, x, y)
    obj.id = id
    obj.x = x
    obj.y = y
    obj.quads = animation.getQuads(spritesheet, 0, 0, 16, 16, 2)
    obj.elapsed_time = 0
    obj.active_image = 1
    obj.threshold = 1
    obj.isMine = true
  end)

function Mine.new(x, y)
  mine = Mine(mineID, x, y)
  mineID = mineID + 1
  table.insert(mines, mine)
  world:add(mine, mine.x, mine.y, 16, 16)
end

function Mine:update(dt)
  self.active_image, self.elapsed_time = anim.getFrame(dt, self.active_image, self.elapsed_time, self.threshold, 2, "yes")
end

function Mine:draw()
  love.graphics.draw(spritesheet, self.quads[self.active_image], self.x, self.y, 0)
end

function Mine.clear()
  mines = {}
  mineID = 1
end

function Mine.initAllMines()
  Mine.clear()
  for k, object in pairs(map.objects) do
  	if object.name == "Mine" then
      Mine.new(object.x, object.y)
  	end
  end
end

function Mine:resolveExplosionCollisions()
  local items, len = world:queryRect(self.x - 16, self.y - 16, 48, 48)
  for i, item in ipairs(items) do
    if item.isMine and item.id ~= self.id then
      Timer.during(0.1, function()
      end, function()
        item:destroy()
      end)
    elseif item.isPlayer or item.isEnemy or item.isBullet then
      item:destroy()
    elseif not item.isMine then
      local x, y = map:convertPixelToTile(item.x, item.y)
      if map:getTileProperties(1, x+1, y+1).destroyable then
        world:remove(item)
        map:swapTile(map:getInstanceByPixel(item.x, item.y), map.tiles[1])
      end
    end
  end
end

function Mine:destroy()
  explosions.new(self.x + 8, self.y + 8, 2, 0.7)
  self:resolveExplosionCollisions()
  for i, v in ipairs(mines) do
    if v.id == self.id then
      table.remove(mines, i)
    end
  end
  pcall(function() world:remove(self) end)
end

function Mine.getMines()
  return mines
end
