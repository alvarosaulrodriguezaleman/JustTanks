local spritesheet = love.graphics.newImage('assets/enemy.png')
local currentFrame = 1
local elapsedTime = 0

local enemy = {
  spritesheet = spritesheet,
  x = 0,
  y = 0,
  speed = 100,
  animations = {
    up = {
      love.graphics.newQuad(0,0,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(32,0,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(64,0,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(96,0,32,32,spritesheet:getDimensions())
    },
    down = {
      love.graphics.newQuad(0,32,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(32,32,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(64,32,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(96,32,32,32,spritesheet:getDimensions())
    },
    left = {
      love.graphics.newQuad(0,64,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(32,64,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(64,64,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(96,64,32,32,spritesheet:getDimensions())
    },
    right = {
      love.graphics.newQuad(0,96,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(32,96,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(64,96,32,32,spritesheet:getDimensions()),
      love.graphics.newQuad(96,96,32,32,spritesheet:getDimensions())
    },
  },
  wantsUp = false,
  wantsRight = false,
  wantsDown = false,
  wantsLeft = false,
  isEnemy = true,
  visible = false
}
enemy.animation = enemy.animations.down

function enemy.init()
  for k, object in pairs(map.objects) do
  	if object.name == "Enemy" then
  	  enemy.x = object.x
      enemy.y = object.y
      enemy.visible = true
      world:add(enemy, enemy.x, enemy.y, 32, 32)
  		break
  	end
  end
end

function enemy.update(dt)
end

function enemy.draw()
  if enemy.visible then
    love.graphics.draw(enemy.spritesheet, enemy.animation[currentFrame], math.floor(enemy.x), math.floor(enemy.y))
  end
end

return enemy
