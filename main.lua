local sti = require "lib/sti"
local bump = require "lib/bump"
local player = require "player"
local enemy = require "enemy"
inspect = require "lib/inspect"

local gameStates = {}
gameStates.gameLoop = {
  bindings = {
    moveUp = function() player.wantsUp = true end,
    moveDown = function() player.wantsDown = true end,
    moveLeft = function() player.wantsLeft = true end,
		moveRight = function() player.wantsRight = true end,
		releaseUp = function() player.wantsUp = false end,
    releaseDown = function() player.wantsDown = false end,
    releaseLeft = function() player.wantsLeft = false end,
		releaseRight = function() player.wantsRight = false end
  },
  keys = {
    w = "moveUp",
		up = "moveUp",
    s = "moveDown",
		down = "moveDown",
    a = "moveLeft",
		left = "moveLeft",
    d = "moveRight",
		right = "moveRight"
  },
	keysReleased = {
		w = "releaseUp",
		up = "releaseUp",
    s = "releaseDown",
		down = "releaseDown",
    a = "releaseLeft",
		left = "releaseLeft",
    d = "releaseRight",
		right = "releaseRight"
	}
}
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
  enemy.init()
end

function love.update(dt)
	map:update(dt)
	player.update(dt)
  enemy.update(dt)
end

function love.draw()
	--love.graphics.setColor(1, 1, 1)
	map:draw()
  player.draw()
  enemy.draw()
	--love.graphics.setColor(1, 0, 0)
	--map:bump_draw(world)
end
