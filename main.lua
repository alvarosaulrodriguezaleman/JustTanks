local sti = require "lib/sti"
local bump = require "lib/bump"
inspect = require "lib/inspect"

local enemy = require "enemy"
local gameStates = require "gameStates"
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

function love.load()
	world = bump.newWorld(32)
	map = sti("maps/map02.lua", {"bump"})
	map:bump_init(world)
  player.init()
  enemies = Enemy.initAllEnemies()
end

function love.update(dt)
	map:update(dt)
	player.update(dt)
  for i = 1, enemies.enemyCount do
    enemies[i]:update(dt)
  end
end

function love.draw()
	--love.graphics.setColor(1, 1, 1)
	map:draw()
  player.draw()
  for i = 1, enemies.enemyCount do
    enemies[i]:draw()
  end
	--love.graphics.setColor(1, 0, 0)
	--map:bump_draw(world)
end
