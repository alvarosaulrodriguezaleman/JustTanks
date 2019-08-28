local anim = require "utils/animation"
local filters = require "utils/collisionFilters"
require "utils/class"

local spritesheet = love.graphics.newImage('assets/bullet.png')

Bullet = class(function(obj, id, x, y, dx, dy, bouncesLeft, isEnemyBullet)
    obj.id = id
    obj.spritesheet = spritesheet
    obj.animation = anim.getQuads(spritesheet, 0, 0, 8, 8, 4)
    obj.currentFrame = love.math.random(1, 4)
    obj.elapsedTime = 0
    obj.x = x
    obj.y = y
    obj.dx = dx
    obj.dy = dy
    obj.bouncesLeft = bouncesLeft
    obj.isBullet = true
    obj.isEnemyBullet = isEnemyBullet
  end)

function Bullet:update(dt)
  self.x = self.x + (self.dx * dt)
	self.y = self.y + (self.dy * dt)
  self.x, self.y, cols, len = world:move(self, self.x, self.y, filters.bullets)
  for i = 1, len do
    local other = cols[i].other
    if not (other.properties == nil) and other.properties.isWall then
      if self.bouncesLeft <= 0 then
        self:destroy()
      else
        self.bouncesLeft = self.bouncesLeft - 1
      end
      local nx, ny = cols[i].normal.x, cols[i].normal.y
      if (nx < 0 and self.dx > 0) or (nx > 0 and self.dx < 0) then
        self.dx = -self.dx
      end
      if (ny < 0 and self.dy > 0) or (ny > 0 and self.dy < 0) then
        self.dy = -self.dy
      end
    end
    if other.isEnemy or other.isBullet then
      self:destroy()
      other:destroy()
    end
  end
  self.currentFrame, self.elapsedTime = anim.getFrame(dt, self.currentFrame, self.elapsedTime, 0.05, 4)
end

function Bullet:draw()
  love.graphics.draw(self.spritesheet, self.animation[self.currentFrame], math.floor(self.x), math.floor(self.y))
end

function Bullet:destroy()
  for i, v in ipairs(bullets) do
    if v.id == self.id then
      table.remove(bullets, i)
    end
  end
  world:remove(self)
end

function Bullet.init()
  return {}, 1
end
