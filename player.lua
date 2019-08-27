local anim = require "utils/animation"

local spritesheet = love.graphics.newImage('assets/player.png')
local currentFrame = 1
local elapsedTime = 0

local player = {
  spritesheet = spritesheet,
  x = 0,
  y = 0,
  speed = 100,
  animations = {
    up = anim.getQuads(spritesheet, 0, 0, 32, 32, 4),
    down = anim.getQuads(spritesheet, 0, 32, 32, 32, 4),
    left = anim.getQuads(spritesheet, 0, 64, 32, 32, 4),
    right = anim.getQuads(spritesheet, 0, 96, 32, 32, 4)
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

  currentFrame, elapsedTime = anim.getFrame(dt, currentFrame, elapsedTime, 0.15, 4)

	if not player.wantsUp and not player.wantsDown and
		 not player.wantsLeft and not player.wantsRight then
		currentFrame = 1
	end
end

function player.draw()
  love.graphics.draw(player.spritesheet, player.animation[currentFrame], math.floor(player.x), math.floor(player.y))
end

return player
