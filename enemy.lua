local anim = require "utils/animation"
require "utils/class"

local spritesheet = love.graphics.newImage('assets/enemy.png')

Enemy = class(function(obj, id, x, y)
    obj.id = id
    obj.spritesheet = spritesheet
    obj.animations = {
      up = anim.getQuads(spritesheet, 0, 0, 32, 32, 4),
      down = anim.getQuads(spritesheet, 0, 32, 32, 32, 4),
      left = anim.getQuads(spritesheet, 0, 64, 32, 32, 4),
      right = anim.getQuads(spritesheet, 0, 96, 32, 32, 4)
    }
    obj.x = x
    obj.y = y
    obj.width = 32
    obj.height = 32
    obj.speed = 100
    obj.wantsUp = false
    obj.wantsRight = false
    obj.wantsDown = false
    obj.wantsLeft = false
    obj.isEnemy = true
    obj.visible = true
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
  enemies = {}
  id = 1
  for k, object in pairs(map.objects) do
  	if object.name == "Enemy" then
      enemy = Enemy(id, object.x, object.y)
      table.insert(enemies, enemy)
      world:add(enemy, enemy.x, enemy.y, enemy.width, enemy.height)
      id = id + 1
  	end
  end

  return enemies
end

function Enemy:destroy()
  for i, v in ipairs(enemies) do
    if v.id == self.id then
      table.remove(enemies, i)
    end
  end
  world:remove(self)
end
