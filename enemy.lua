local anim = require "utils/animation"
local filters = require "utils/collisionFilters"
require "utils/class"

local spritesheet = love.graphics.newImage('assets/enemy.png')

Enemy = class(function(obj, id, type, x, y)
    obj.id = id
    obj.type = type
    obj.spritesheet = spritesheet
    obj.animations = {
      up = anim.getQuads(spritesheet, 0, 0, 32, 32, 4),
      down = anim.getQuads(spritesheet, 0, 32, 32, 32, 4),
      left = anim.getQuads(spritesheet, 0, 64, 32, 32, 4),
      right = anim.getQuads(spritesheet, 0, 96, 32, 32, 4)
    }
    obj.currentFrame = 1
    obj.elapsedFrameTime = 0
    obj.x = x
    obj.y = y
    obj.width = 32
    obj.height = 32
    obj.speed = 40
    obj.wantsUp = false
    obj.wantsRight = false
    obj.wantsDown = false
    obj.wantsLeft = false
    obj.isEnemy = true
    obj.animation = obj.animations.down
  end)

function Enemy:update(dt)
  self:processMovement(dt)

  if self.wantsUp then
    self.y = self.y - self.speed * dt
    self.animation = self.animations.up
  end
  if self.wantsDown then
    self.y = self.y + self.speed * dt
    self.animation = self.animations.down
  end
  if self.wantsLeft then
    self.x = self.x - self.speed * dt
    self.animation = self.animations.left
  end
  if self.wantsRight then
    self.x = self.x + self.speed * dt
    self.animation = self.animations.right
  end

  self.x, self.y, cols, len = world:move(self, self.x, self.y, filters.enemy)

  self.currentFrame, self.elapsedFrameTime = anim.getFrame(dt, self.currentFrame, self.elapsedFrameTime, 0.25, 4)
end

function Enemy:draw()
  love.graphics.draw(self.spritesheet, self.animation[self.currentFrame], math.floor(self.x), math.floor(self.y))
end

function Enemy.init(id, type, x, y)
  if type == 1 then
    enemy = Enemy(id, 1, x, y)
    enemy.elapsedMovementTime = 0
    enemy.movementTimeThreshold = 0
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

function Enemy:destroy()
  for i, v in ipairs(enemies) do
    if v.id == self.id then
      table.remove(enemies, i)
    end
  end
  world:remove(self)
end
