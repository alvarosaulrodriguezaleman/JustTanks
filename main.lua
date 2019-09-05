local sti = require "lib/sti"
local bump = require "lib/bump"
Timer = require "lib/timer"
Gamestate = require "lib/gamestate"
inspect = require "lib/inspect"

local gameStates = require "gameStates"
require "enemy"
require "bullet"
player = require "player"

local game = {}
local state = gameStates.gameLoop

function inputHandler(input)
  local action = state.bindings[input]
  if action then return action() end
end

function love.keypressed(k)
  local binding = state.keys[k]
  return inputHandler(binding)
end

function love.keyreleased(k)
  local binding = state.keysReleased[k]
  return inputHandler(binding)
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    player.shoot(x, y)
  end
end

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(game)
end

function game:enter()
  love.mouse.setCursor(love.mouse.newCursor("assets/cursor.png", 14, 14))
	world = bump.newWorld(32)
	map = sti("maps/map02.lua", {"bump"})
	map:bump_init(world)
  player.init()
  enemies = Enemy.initAllEnemies()
  Bullet.init()
  RESTART = false
end

function game:update(dt)
  if RESTART then
    game:enter()
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
	--love.graphics.setColor(1, 1, 1)
  if SCREEN_SHAKE then
    local dx = love.math.random(-2, 2)
    local dy = love.math.random(-2, 2)
    love.graphics.translate(dx, dy)
    map:draw(dx, dy)
  else
	  map:draw()
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
