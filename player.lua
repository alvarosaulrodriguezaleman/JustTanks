local spritesheet = love.graphics.newImage('assets/player.png')
local currentFrame = 1
local elapsedTime = 0

local player = {
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
  wantsLeft = false
}
player.animation = player.animations.right

function player.init()
  for k, object in pairs(map.objects) do
  	if object.name == "Player" then
  	  player.x = object.x
      player.y = object.y
      world:add(player, player.x, player.y, 32, 32)
  		break
  	end
  end
end

local playerFilter = function(item, other)
  if not (other.properties == nil) and other.properties.isWall then return 'slide' end
  if not (other.isEnemy == nil) and other.isEnemy then return 'slide' end
end

function player.update(dt)
  if player.wantsUp then
    player.y = player.y - player.speed * dt
    player.animation = player.animations.up
  end
  if player.wantsDown then
    player.y = player.y + player.speed * dt
    player.animation = player.animations.down
  end
  if player.wantsLeft then
    player.x = player.x - player.speed * dt
    player.animation = player.animations.left
  end
  if player.wantsRight then
    player.x = player.x + player.speed * dt
    player.animation = player.animations.right
  end

  player.x, player.y, cols, len = world:move(player, player.x, player.y, playerFilter)
  for i=1,len do

  end

  elapsedTime = elapsedTime + dt

	if(elapsedTime > 0.15) then
		if(currentFrame < 4) then
				currentFrame = currentFrame + 1
		else
				currentFrame = 1
		end
		elapsedTime = 0
	end

	if not player.wantsUp and not player.wantsDown and
		 not player.wantsLeft and not player.wantsRight then
		currentFrame = 1
	end
end

function player.draw()
  love.graphics.draw(player.spritesheet, player.animation[currentFrame], math.floor(player.x), math.floor(player.y))
end

return player
