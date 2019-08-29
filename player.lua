local anim = require "utils/animation"
local filters = require "utils/collisionFilters"
require "bullet"

local spritesheet = love.graphics.newImage('assets/player.png')
local currentFrame = 1
local elapsedTime = 0

local player = {
  spritesheet = spritesheet,
  animations = anim.getDirectionalQuads(spritesheet, 0, 0, 32, 32, 4),
  x = 0,
  y = 0,
  width = 32,
  height = 32,
  speed = 100,
  bulletSpeed = 250,
  maxBulletCount = 2,
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

function player.update(dt)
  currentFrame, elapsedTime = anim.getFrame(dt, currentFrame, elapsedTime, 0.15, 4)
  player.processMovement(dt)
  player.x, player.y, cols, len = world:move(player, player.x, player.y, filters.player)
end

function player.draw()
  love.graphics.draw(player.spritesheet, player.animation[currentFrame], math.floor(player.x), math.floor(player.y))
end

function player.shoot(x, y)
  if #bullets < player.maxBulletCount then
    local startX = player.x + player.width / 2
    local startY = player.y + player.height / 2
    local mouseX = x
    local mouseY = y

	  local angle = math.atan2((mouseY - startY), (mouseX - startX))

	  local bulletDx = player.bulletSpeed * math.cos(angle)
	  local bulletDy = player.bulletSpeed * math.sin(angle)

    bullet = Bullet(bulletID, startX, startY, bulletDx, bulletDy, 1, false)
	  table.insert(bullets, bullet)
    world:add(bullet, bullet.x, bullet.y, 8, 8)
    bulletID = bulletID + 1
  end
end

function player.processMovement(dt)
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

  if not player.wantsUp and not player.wantsDown and
		 not player.wantsLeft and not player.wantsRight then
		currentFrame = 1
	end
end

return player
