local anim = require "utils/animation"
require "utils/class"

local spritesheet = love.graphics.newImage('assets/enemy.png')

Enemy = class(function(obj)
    obj.spritesheet = spritesheet
    obj.x = 0
    obj.y = 0
    obj.speed = 100
    obj.animations = {
      up = anim.getQuads(spritesheet, 0, 0, 32, 32, 4),
      down = anim.getQuads(spritesheet, 0, 32, 32, 32, 4),
      left = anim.getQuads(spritesheet, 0, 64, 32, 32, 4),
      right = anim.getQuads(spritesheet, 0, 96, 32, 32, 4)
    }
    obj.wantsUp = false
    obj.wantsRight = false
    obj.wantsDown = false
    obj.wantsLeft = false
    obj.isEnemy = true
    obj.visible = false
    obj.animation = obj.animations.down
  end)

function Enemy:update(dt)
end

function Enemy:draw()
  if self.visible then
    love.graphics.draw(self.spritesheet, self.animation[1], math.floor(self.x), math.floor(self.y))
  end
end

function Enemy.initAllEnemies()
  local i = 1
  enemies = {enemyCount = 0}
  for k, object in pairs(map.objects) do
  	if object.name == "Enemy" then
      enemies[i] = Enemy()
  	  enemies[i].x = object.x
      enemies[i].y = object.y
      enemies[i].visible = true
      world:add(enemies[i], enemies[i].x, enemies[i].y, 32, 32)
      i = i + 1
      enemies.enemyCount = enemies.enemyCount + 1
  	end
  end

  return enemies
end
