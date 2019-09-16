local anim = require "utils/animation"
local filters = require "utils/collisionFilters"

local player = {
  image = love.graphics.newImage('assets/player.png'),
  barrelImage = love.graphics.newImage('assets/player_barrel.png'),
  bulletImage = love.graphics.newImage('assets/player_bullet.png'),
  trailImage = love.graphics.newImage('assets/tracks2.png'),
  lives = 3,
  x = 0,
  y = 0,
  dx = 0,
  dy = 0,
  desiredAngle = 0,
  rotationSpeed = math.pi * 2,
  barrelAngle = 0,
  angle = 0,
  width = 32,
  height = 32,
  speed = 80,
  bulletSpeed = 140,
  bulletWidth = 6,
  bulletHeight = 10,
  maxBulletCount = 5,
  bouncesLeft = 1,
  wantsUp = false,
  wantsRight = false,
  wantsDown = false,
  wantsLeft = false,
  isPlayer = true
}

player.trail = trail
    :new({
      type = "point",
      content = {
        type = "image",
        source = player.trailImage
      },
      duration = 1 + player.speed * 0.005,
      amount = player.speed * 0.2,
      fade = "fade"
    })
    :setMotion(0, 0)
    :setRotation(player.desiredAngle)

function player.init()
  for k, object in pairs(map.objects) do
  	if object.name == "Player" then
  	  player.x = object.x
      player.y = object.y
      player.visible = true
      player.trail:clear()
      world:add(player, player.x, player.y, player.width, player.height)
  		break
  	end
  end
end

function player.update(dt)
  if player.visible then
    player.processMovement(dt)
    player.x, player.y, cols, len = world:move(player, player.x, player.y, filters.player)
    player.barrelAngle = animation.getAngle(player.x - 3, player.y - 3, player.width, player.height, (love.mouse.getX() - BASE_TX) / BASE_SX, (love.mouse.getY() - BASE_TY) / BASE_SY) - math.pi/2
  end
  player.updateTrail(dt)
end

function player.draw()
  player.trail:draw()
  if player.visible then
    love.graphics.draw(player.image, math.floor(player.x + player.width/2), math.floor(player.y + player.height/2), player.angle, 1, 1, 17, 17)

    love.graphics.draw(player.barrelImage, math.floor(player.x + player.width/2), math.floor(player.y + player.height/2), player.barrelAngle, 1, 1, 6, 6)
    --love.graphics.points(math.floor(player.x + player.width / 2), math.floor(player.y + player.height / 2))
  end
end

function player.shoot(x, y)
  Bullet.shoot(player.x, player.y, player.width, player.height, x, y,
               player.bulletSpeed, player.bouncesLeft, player.maxBulletCount,
               player.bulletImage, player.bulletWidth, player.bulletHeight)
end

function player.processDirection()
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
end

function player.processMovement(dt)
  player.processDirection()

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

function player.updateTrail(dt)
  if ((player.dx == 0 and player.dy == 0) and player.trail.active) or not player.visible then
    player.trail:disable()
  elseif not player.trail.active then
    player.trail:enable()
  end
  player.trail:setPosition(player.x + player.width / 2 - player.dx * 0.05, player.y + player.height / 2 - player.dy * 0.05):setRotation(player.desiredAngle + math.pi/2)
  player.trail:update(dt)
end

function player.destroy()
  if player.visible then
    player.visible = false
    explosions.new(player.x + player.width / 2, player.y + player.height / 2, 1, 1)
    Timer.during(1, function()
    end, function()
      if player.lives > 1 then
        RESTART = true
        player.lives = player.lives - 1
      else
        return Gamestate.switch(menu)
      end
    end)
  end
end

return player
