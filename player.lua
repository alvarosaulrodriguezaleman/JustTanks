local anim = require "utils/animation"
local filters = require "utils/collisionFilters"

local player = {
  image = love.graphics.newImage('assets/player.png'),
  barrelImage = love.graphics.newImage('assets/player_barrel.png'),
  bulletImage = love.graphics.newImage('assets/player_bullet.png'),
  x = 0,
  y = 0,
  dx = 0,
  dy = 0,
  desiredAngle = 0,
  rotationSpeed = math.pi * 3,
  angle = 0,
  width = 32,
  height = 32,
  speed = 100,
  bulletSpeed = 200,
  bulletWidth = 6,
  bulletHeight = 10,
  maxBulletCount = 2,
  bouncesLeft = 1,
  wantsUp = false,
  wantsRight = false,
  wantsDown = false,
  wantsLeft = false,
  isPlayer = true
}

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
  player.processMovement(dt)
  player.x, player.y, cols, len = world:move(player, player.x, player.y, filters.player)
end

function player.draw()
  love.graphics.draw(player.image, math.floor(player.x + player.width/2), math.floor(player.y + player.height/2), player.angle, 1, 1, 17, 17)
  local barrelAngle = animation.getAngle(player.x, player.y, player.width, player.height, love.mouse.getX() - BASE_TX, love.mouse.getY() - BASE_TY) - math.pi/2 + 0.05
  love.graphics.draw(player.barrelImage, math.floor(player.x + player.width/2), math.floor(player.y + player.height/2), barrelAngle, 1, 1, 6, 6)
end

function player.shoot(x, y)
  Bullet.shoot(player.x, player.y, player.width, player.height, x, y,
               player.bulletSpeed, player.bouncesLeft, player.maxBulletCount,
               player.bulletImage, player.bulletWidth, player.bulletHeight)
end

function player.processMovement(dt)
  if player.wantsUp then
    player.dy = -player.speed
  end
  if player.wantsDown then
    player.dy = player.speed
  end
  if player.wantsUp == player.wantsDown then
    player.dy = 0
  end
  if player.wantsLeft then
    player.dx = -player.speed
  end
  if player.wantsRight then
    player.dx = player.speed
  end
  if player.wantsLeft == player.wantsRight then
    player.dx = 0
  end

  player.x = player.x + (player.dx * dt)
	player.y = player.y + (player.dy * dt)

  local aux = player.desiredAngle
  if player.dy == 0 and player.dx == 0 then
    player.desiredAngle = aux
  else
    player.desiredAngle = math.atan2(-player.dy, -player.dx)
  end

  player.angle = animation.smoothRotation(dt, player.angle, player.desiredAngle, player.rotationSpeed)
end

function player.destroy()
  RESTART = true
end

return player
