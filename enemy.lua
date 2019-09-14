local anim = require "utils/animation"
local filters = require "utils/collisionFilters"
require "lib/class"

local trailImage = love.graphics.newImage('assets/tracks2.png')
Enemy = class(function(obj, id, type, x, y, w, h, speed)
    obj.id = id
    obj.type = type
    obj.image = love.graphics.newImage("assets/enemy"..type..".png")
    obj.barrelImage = love.graphics.newImage("assets/enemy"..type.."_barrel.png")
    obj.bulletImage = love.graphics.newImage("assets/enemy"..type.."_bullet.png")
    obj.x = x
    obj.y = y
    obj.dx = 0
    obj.dy = 0
    obj.angle = 0
    obj.desiredAngle = 0
    obj.rotationSpeed = math.pi
    obj.width = w
    obj.height = h
    obj.speed = speed
    obj.wantsUp = false
    obj.wantsRight = false
    obj.wantsDown = false
    obj.wantsLeft = false
    obj.isEnemy = true
    obj.trail = nil
  end)

function Enemy:update(dt)
  self:processMovement(dt)
  self:processAttacks(dt)
  self.x, self.y, cols, len = world:move(self, self.x, self.y, filters.enemy)
  self:updateTrail(dt)
end

function Enemy:draw()
  self.trail:draw()
  love.graphics.draw(self.image, math.floor(self.x + self.width / 2), math.floor(self.y + self.height / 2), self.angle, 1, 1, 17, 17)
  local barrelAngle = animation.getAngle(self.x, self.y, self.width, self.height, player.x + player.width/2, player.y + player.width/2) - math.pi/2 + 0.05
  love.graphics.draw(self.barrelImage, math.floor(self.x + self.width/2), math.floor(self.y + self.height/2), barrelAngle, 1, 1, 6, 6)
end

function Enemy.init(id, type, x, y)
  if type == "1" then
    enemy = Enemy(id, 1, x, y, 32, 32, 0)

    enemy.bulletWidth = 8
    enemy.bulletHeight = 10
    enemy.elapsedAttackTime = 0
    enemy.fireRate = function() return love.math.random(2, 3) + love.math.random() end
    enemy.attackTimeThreshold = enemy.fireRate()
    enemy.maxBulletCount = 1
    enemy.bulletSpeed = 100
    enemy.bouncesLeft = 1
  end

  if type == "2" then
    enemy = Enemy(id, 2, x, y, 32, 32, 40)

    enemy.bulletWidth = 8
    enemy.bulletHeight = 10
    enemy.elapsedMovementTime = 0
    enemy.movementTimeThreshold = 0
    enemy.elapsedAttackTime = 0
    enemy.fireRate = function() return love.math.random(1, 2) + love.math.random() end
    enemy.attackTimeThreshold = enemy.fireRate()
    enemy.maxBulletCount = 3
    enemy.bulletSpeed = 140
    enemy.bouncesLeft = 1
  end

  if type == "3" then
    enemy = Enemy(id, 3, x, y, 32, 32, 0)

    enemy.bulletWidth = 6
    enemy.bulletHeight = 10
    enemy.elapsedAttackTime = 0
    enemy.fireRate = function() return 1 + love.math.random() end
    enemy.attackTimeThreshold = enemy.fireRate()
    enemy.maxBulletCount = 15
    enemy.bulletSpeed = 120
    enemy.bouncesLeft = 2
  end

  return enemy
end

function Enemy.initAllEnemies()
  enemies = {}
  id = 1
  for k, object in pairs(map.objects) do
  	if object.name == "Enemy" then
      enemy = Enemy.init(id, object.type, object.x, object.y)
      enemy:initializeTrail()
      table.insert(enemies, enemy)
      world:add(enemy, enemy.x, enemy.y, enemy.width, enemy.height)
      id = id + 1
  	end
  end

  return enemies
end

function Enemy:initializeTrail()
  self.trail = trail
      :new({
        type = "point",
        content = {
          type = "image",
          source = trailImage
        },
        duration = 1 + self.speed * 0.005,
        amount = self.speed * 0.2,
        fade = "fade"
      })
      :setMotion(0, 0)
      :setRotation(self.desiredAngle)
end

function Enemy:updateTrail(dt)
  if (self.dx == 0 and self.dy == 0) and self.trail.active then
    self.trail:disable()
  elseif not self.trail.active then
    self.trail:enable()
  end
  self.trail:setPosition(self.x + self.width / 2 - self.dx * 0.05, self.y + self.height / 2 - self.dy * 0.05):setRotation(self.desiredAngle + math.pi/2)
  self.trail:update(dt)
end

function Enemy:processMovement(dt)
  if self.type == 2 then
    self:randomMovement(dt)
  end

  if self.wantsUp then
    self.dy = -self.speed
  end
  if self.wantsDown then
    self.dy = self.speed
  end
  if self.wantsUp == self.wantsDown then
    self.dy = 0
  end
  if self.wantsLeft then
    self.dx = -self.speed
  end
  if self.wantsRight then
    self.dx = self.speed
  end
  if self.wantsLeft == self.wantsRight then
    self.dx = 0
  end

  self.x = self.x + (self.dx * dt)
	self.y = self.y + (self.dy * dt)

  local aux = self.desiredAngle
  if self.dy == 0 and self.dx == 0 then
    self.desiredAngle = aux
  else
    self.desiredAngle = math.atan2(-self.dy, -self.dx)
  end

  self.angle = animation.smoothRotation(dt, self.angle, self.desiredAngle, self.rotationSpeed)
end

function Enemy:randomMovement(dt)
  self.elapsedMovementTime = self.elapsedMovementTime + dt

  if self.elapsedMovementTime > self.movementTimeThreshold then
    self.elapsedMovementTime = 0
    self.movementTimeThreshold = love.math.random(1, 2) + love.math.random()

    local newMove = love.math.random(1, 4)
    self.wantsUp = newMove == 1 and true or false
    self.wantsRight = newMove == 2 and true or false
    self.wantsDown = newMove == 3 and true or false
    self.wantsLeft = newMove == 4 and true or false
  end
end

function Enemy:processAttacks(dt)
  if self.type >= 1 and self.type <= 3 then
    --self:shootAtPlayer(dt)
  end
end

function Enemy:shootAtPlayer(dt)
  self.elapsedAttackTime = self.elapsedAttackTime + dt

  if self.elapsedAttackTime > self.attackTimeThreshold then
    self.elapsedAttackTime = 0
    self.attackTimeThreshold = self.fireRate()
    self:shoot(player.x + player.width / 2, player.y + player.height / 2)
  end
end

function Enemy:shoot(x, y)
  Bullet.shoot(self.x, self.y, self.width, self.height, x, y, self.bulletSpeed,
               self.bouncesLeft, self.maxBulletCount, self.bulletImage,
               self.bulletWidth, self.bulletHeight, self.id)
end

function Enemy:destroy()
  for i, v in ipairs(enemies) do
    if v.id == self.id then
      table.remove(enemies, i)
    end
  end
  world:remove(self)
  explosions.new(self.x + self.width / 2, self.y + self.height / 2, 1, 1)
end
