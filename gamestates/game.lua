local game = {}

function game:enter(previous, n)
  love.mouse.setCursor(love.mouse.newCursor("assets/cursor.png", 14, 14))
	world = bump.newWorld(32)
	map = sti("maps/map0"..n..".lua", {"bump"})
	map:bump_init(world)
  player.init()
  enemies = Enemy.initAllEnemies()
  Bullet.init()
  state = controls.game
  RESTART = false
  SCREEN_SHAKE = false
  BASE_TX = 120
  BASE_TY = 100
end

function game:update(dt)
  if RESTART then
    Gamestate.switch(menu)
  end
  Timer.update(dt)
	map:update(dt)
	player.update(dt)
  for i, enemy in ipairs(enemies) do
    enemy:update(dt)
  end
  for i, bullet in ipairs(Bullet.getBullets()) do
    bullet:update(dt)
  end
end

function game:draw()
  love.graphics.translate(BASE_TX, BASE_TY)
	--love.graphics.setColor(1, 1, 1)
  if SCREEN_SHAKE then
    local dx = love.math.random(-2, 2)
    local dy = love.math.random(-2, 2)
    love.graphics.translate(dx, dy)
    map:draw(BASE_TX + dx, BASE_TY + dy)
  else
	  map:draw(BASE_TX, BASE_TY)
  end

  player.draw()
  for i, enemy in ipairs(enemies) do
    enemy:draw()
  end
  for i, bullet in ipairs(Bullet.getBullets()) do
    bullet:draw()
  end
	--love.graphics.setColor(1, 0, 0)
	--map:bump_draw(world)
end

function game:mousepressed(x, y, button, istouch)
  if button == 1 then
    player.shoot(x - BASE_TX, y - BASE_TY)
  end
end

return game
