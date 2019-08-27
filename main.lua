local sti = require "lib/sti"
local bump = require "lib/bump"
inspect = require "lib/inspect"

local gameStates = require "gameStates"
require "enemy"
require "bullet"
player = require "player"

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
  love.mouse.setCursor(love.mouse.newCursor("assets/cursor.png", 14, 14))
	world = bump.newWorld(32)
	map = sti("maps/map02.lua", {"bump"})
	map:bump_init(world)
  player.init()
  enemies = Enemy.initAllEnemies()
  bullets, bulletID = Bullet.init()
end

function love.update(dt)
	map:update(dt)
	player.update(dt)
  for i, enemy in ipairs(enemies) do
    enemy:update(dt)
  end
  for i, bullet in ipairs(bullets) do
    bullet:update(dt)
  end
end

function love.draw()
	--love.graphics.setColor(1, 1, 1)
	map:draw()
  player.draw()
  for i, enemy in ipairs(enemies) do
    enemy:draw()
  end
  for i, bullet in ipairs(bullets) do
    bullet:draw()
  end
	--love.graphics.setColor(1, 0, 0)
	--map:bump_draw(world)
end
