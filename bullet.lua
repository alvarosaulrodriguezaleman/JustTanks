local anim = require "utils/animation"
local filters = require "utils/collisionFilters"
require "lib/class"

local bullets = {}
local bulletID = 1
local smokeImage = love.graphics.newImage("assets/smoke.png")

Bullet = class(function(obj, id, x, y, dx, dy, w, h, image, bouncesLeft, isEnemyBullet, shooterID)
    obj.id = id
    obj.image = image
    obj.elapsedTime = 0
    obj.x = x
    obj.y = y
    obj.dx = dx
    obj.dy = dy
    obj.width = w
    obj.height = h
    obj.bouncesLeft = bouncesLeft
    obj.isBullet = true
    obj.isEnemyBullet = isEnemyBullet
    obj.shooterID = shooterID
    obj.trail = nil
  end)

function Bullet:update(dt)
  if #bullets == 0 then return end
  self.x = self.x + (self.dx * dt)
	self.y = self.y + (self.dy * dt)
  self.x, self.y, cols, len = world:move(self, self.x, self.y, filters.bullets)
  self:resolveCollisions(cols, len)
  self.trail:setPosition(self.x + self.width / 2, self.y + self.height / 2):setMotion(-self.dx * 0.2, -self.dy * 0.2)
  self.trail:update(dt)
end

function Bullet:draw()
  self.trail:draw()
  love.graphics.draw(self.image, math.floor(self.x + self.width / 2), math.floor(self.y + self.height / 2), math.atan2(self.dy, self.dx) + math.pi / 2, 1, 1, self.width / 2, self.height / 2)
end

function Bullet:destroy()
  for i, v in ipairs(bullets) do
    if v.id == self.id then
      table.remove(bullets, i)
    end
  end
  pcall(function() world:remove(self) end)
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
    if other.isEnemy and not self.isEnemyBullet or other.isPlayer and self.isEnemyBullet or other.isBullet or other.isMine then
      SCREEN_SHAKE = true
      Timer.during(0.2, function()
      end, function()
        SCREEN_SHAKE = false
      end)
      if other.isBullet then
        explosions.new(self.x, self.y, 2, 0.2)
      end
      self:destroy()
      other:destroy()
    end
  end
end

function Bullet.shoot(x, y, w, h, targetX, targetY, bulletSpeed, bouncesLeft, maxBulletCount, image, bulletWidth, bulletHeight, id)
  id = id or -1
  local isEnemyBullet = id ~= -1 and true or false
  if Bullet.getNumberOfBullets(id) < maxBulletCount then
    x = x - bulletWidth / 2
    y = y - bulletHeight / 2
    local angle, startX, startY = animation.getAngle(x, y, w, h, targetX, targetY)

    local bulletDx = bulletSpeed * math.cos(angle)
    local bulletDy = bulletSpeed * math.sin(angle)

    bullet = Bullet(bulletID, startX, startY, bulletDx, bulletDy, bulletWidth, bulletHeight, image, bouncesLeft, isEnemyBullet, id)
    bullet:initializeTrail()
    table.insert(bullets, bullet)
    world:add(bullet, bullet.x, bullet.y, bullet.width, bullet.height)
    bulletID = bulletID + 1
  end
end

function Bullet:initializeTrail()
  self.trail = trail
      :new({
        type = "point",
        content = {
          type = "image",
          source = smokeImage
        },
        duration = 0.5,
        amount = 4,
        fade = "fade"
      })
      :setMotion(-self.dx, -self.dy)
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
