local anim = require "utils/animation"
local filters = require "utils/collisionFilters"
require "lib/class"

local spritesheet = love.graphics.newImage('assets/bullet.png')
local bullets = {}
local bulletID = 1

Bullet = class(function(obj, id, x, y, dx, dy, bouncesLeft, isEnemyBullet, shooterID)
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
    obj.shooterID = shooterID
  end)

function Bullet:update(dt)
  -- if #bullets == 0 then return end
  self.x = self.x + (self.dx * dt)
	self.y = self.y + (self.dy * dt)
  self.x, self.y, cols, len = world:move(self, self.x, self.y, filters.bullets)
  self:resolveCollisions(cols, len)
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
  bullets = {}
  bulletID = 1
end

function Bullet:resolveCollisions(cols, len)
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
    if other.isEnemy and not self.isEnemyBullet or other.isPlayer and self.isEnemyBullet or other.isBullet then
      Timer.during(0.2, function()
        SCREEN_SHAKE = true
      end, function()
        SCREEN_SHAKE = false
      end)
      self:destroy()
      other:destroy()
    end
  end
end

function Bullet.shoot(x, y, w, h, targetX, targetY, bulletSpeed, bouncesLeft, maxBulletCount, id)
  id = id or -1
  local isEnemyBullet = id ~= -1 and true or false
  if Bullet.getNumberOfBullets(id) < maxBulletCount then
    local startX = x + w / 2
    local startY = y + h / 2
    local endX = targetX
    local endY = targetY

    local angle = math.atan2((endY - startY), (endX - startX))

    local bulletDx = bulletSpeed * math.cos(angle)
    local bulletDy = bulletSpeed * math.sin(angle)

    bullet = Bullet(bulletID, startX, startY, bulletDx, bulletDy, bouncesLeft, isEnemyBullet)
    table.insert(bullets, bullet)
    world:add(bullet, bullet.x, bullet.y, 8, 8)
    bulletID = bulletID + 1
  end
end

function Bullet.getNumberOfBullets(id)
  id = id or -1
  local count = 0
  if id == -1 then
    for i, v in ipairs(bullets) do
      if not v.isEnemyBullet then
        count = count + 1
      end
    end
  else
    for i, v in ipairs(bullets) do
      if v.shooterID == id then
        count = count + 1
      end
    end
  end
  return count
end

function Bullet.getBullets()
  return bullets
end
