local anim = require "utils/animation"
local filters = require "utils/collisionFilters"
require "lib/class"

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
  end)

function Enemy:update(dt)
  self:processMovement(dt)
  self:processAttacks(dt)
  self.x, self.y, cols, len = world:move(self, self.x, self.y, filters.enemy)
end

function Enemy:draw()
  love.graphics.draw(self.image, math.floor(self.x + self.width / 2), math.floor(self.y + self.height / 2), self.angle, 1, 1, 17, 17)
  local barrelAngle = animation.getAngle(self.x, self.y, self.width, self.height, player.x + player.width/2, player.y + player.width/2) - math.pi/2 + 0.05
  love.graphics.draw(self.barrelImage, math.floor(self.x + self.width/2), math.floor(self.y + self.height/2), barrelAngle, 1, 1, 6, 6)
end

function Enemy.init(id, type, x, y)
  if type == 1 then
    enemy = Enemy(id, 1, x, y, 32, 32, 40)

    enemy.bulletWidth = 8
    enemy.bulletHeight = 10
    enemy.elapsedMovementTime = 0
    enemy.movementTimeThreshold = 0
    enemy.elapsedAttackTime = 0
    enemy.attackTimeThreshold = love.math.random(1, 3) + love.math.random()
    enemy.maxBulletCount = 2
    enemy.bulletSpeed = 140
    enemy.bouncesLeft = 1
  end

  return enemy
end

function Enemy.initAllEnemies()
  enemies = {}
  id = 1
  for k, object in pairs(map.objects) do
  	if object.name == "Enemy" then
      enemy = Enemy.init(id, 1, object.x, object.y)
      table.insert(enemies, enemy)
      world:add(enemy, enemy.x, enemy.y, enemy.width, enemy.height)
      id = id + 1
  	end
  end

  return enemies
end

function Enemy:processMovement(dt)
  if self.type == 1 then
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
  if self.type == 1 then
    self:shootAtPlayer(dt)
  end
end

function Enemy:shootAtPlayer(dt)
  self.elapsedAttackTime = self.elapsedAttackTime + dt

  if self.elapsedAttackTime > self.attackTimeThreshold then
    self.elapsedAttackTime = 0
    self.attackTimeThreshold = love.math.random(1, 2) + love.math.random()
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
end
