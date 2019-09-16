local game = {}
local level
local number_of_levels = 2
local victory_achieved = false

function game:enter(previous, n)
  if n > number_of_levels then
    return Gamestate.switch(menu)
  end
  love.graphics.setFont(font20)
  love.mouse.setCursor(love.mouse.newCursor("assets/cursor.png", 14, 14))
	world = bump.newWorld(32)
	map = sti("maps/map0"..n..".lua", {"bump"})
	map:bump_init(world)
  player.init()
  enemies = Enemy.initAllEnemies()
  Bullet.init()
  explosions.clear()
  state = controls.game
  RESTART = false
  SCREEN_SHAKE = false
  BASE_TX = 0
  BASE_TY = 0
  BASE_SX = 1
  BASE_SY = 1

  level = n
end

function game:resume()
  state = controls.game
end

function game:update(dt)
  if RESTART then
    return Gamestate.switch(game, level)
  end
  game.checkVictory()
  Timer.update(dt)
	map:update(dt)
	player.update(dt)
  for i, enemy in ipairs(enemies) do
    enemy:update(dt)
  end
  for i, bullet in ipairs(Bullet.getBullets()) do
    bullet:update(dt)
  end
  explosions.update(dt)
end

function game:draw()
  love.graphics.setBackgroundColor(57/255, 194/255, 114/255, 0)
  love.graphics.translate(BASE_TX, BASE_TY)
  love.graphics.scale(BASE_SX, BASE_SY)
	--love.graphics.setColor(1, 1, 1)
  if SCREEN_SHAKE then
    local dx = love.math.random(-2, 2)
    local dy = love.math.random(-2, 2)
    love.graphics.translate(dx, dy)
    map:draw(BASE_TX + dx, BASE_TY + dy, BASE_SX, BASE_SY)
  else
	  map:draw(BASE_TX, BASE_TY, BASE_SX, BASE_SY)
  end

  player.draw()
  for i, enemy in ipairs(enemies) do
    enemy:draw()
  end
  for i, bullet in ipairs(Bullet.getBullets()) do
    bullet:draw()
  end
  explosions.draw()

  game.drawStatusText()
	--love.graphics.setColor(1, 0, 0)
	--map:bump_draw(world)
end

function game:mousepressed(x, y, button, istouch)
  if button == 1 then
    player.shoot((x - BASE_TX) / BASE_SX, (y - BASE_TY) / BASE_SY)
  end
end

function game.drawStatusText()
  love.graphics.setFont(font20)
  love.graphics.print("Level: " .. level, 400, 700)
  local aux = "Lives: " .. player.lives
  love.graphics.print(aux, love.graphics.getWidth() - 400, 700, 0, 1, 1, math.floor(font20:getWidth(aux)))
  --love.graphics.print("Bullets available: " .. player.maxBulletCount - Bullet.getNumberOfBullets(), 50, 720)
end

function game.checkVictory()
  if #enemies == 0 and not victory_achieved then
    victory_achieved = true
    Timer.during(1, function()
    end, function()
      victory_achieved = false
      return Gamestate.switch(game, level + 1)
    end)
  end
end

return game
