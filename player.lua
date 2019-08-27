local anim = require "utils/animation"
require "bullet"

local spritesheet = love.graphics.newImage('assets/player.png')
local currentFrame = 1
local elapsedTime = 0

local player = {
  spritesheet = spritesheet,
  animations = {
    up = anim.getQuads(spritesheet, 0, 0, 32, 32, 4),
    down = anim.getQuads(spritesheet, 0, 32, 32, 32, 4),
    left = anim.getQuads(spritesheet, 0, 64, 32, 32, 4),
    right = anim.getQuads(spritesheet, 0, 96, 32, 32, 4)
  },
  x = 0,
  y = 0,
  width = 32,
  height = 32,
  speed = 100,
  bulletSpeed = 250,
  wantsUp = false,
  wantsRight = false,
  wantsDown = false,
  wantsLeft = false,
  isPlayer = true
}
player.animation = player.animations.right

function player.init()
  for k, object in pairs(map.objects) do
  	if object.name == "Player" then
  	  player.x = object.x
      player.y = object.y
      world:add(player, player.x, player.y, player.width, player.height)
  		break
  	end
  end
end

local playerFilter = function(item, other)
  if not (other.properties == nil) and other.properties.isWall then return 'slide' end
  if other.isEnemy then return 'slide' end
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

  currentFrame, elapsedTime = anim.getFrame(dt, currentFrame, elapsedTime, 0.15, 4)

	if not player.wantsUp and not player.wantsDown and
		 not player.wantsLeft and not player.wantsRight then
		currentFrame = 1
	end
end

function player.draw()
  love.graphics.draw(player.spritesheet, player.animation[currentFrame], math.floor(player.x), math.floor(player.y))
end

function player.shoot(x, y)
  local startX = player.x + player.width / 2
	local startY = player.y + player.height / 2
	local mouseX = x
	local mouseY = y

	local angle = math.atan2((mouseY - startY), (mouseX - startX))

	local bulletDx = player.bulletSpeed * math.cos(angle)
	local bulletDy = player.bulletSpeed * math.sin(angle)

  bullet = Bullet(bulletID, startX, startY, bulletDx, bulletDy, 1)
	table.insert(bullets, bullet)
  world:add(bullet, bullet.x, bullet.y, 8, 8)
  bulletID = bulletID + 1
end

return player
