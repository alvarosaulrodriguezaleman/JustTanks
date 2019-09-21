sti = require "lib/sti"
bump = require "lib/bump"
Timer = require "lib/timer"
Gamestate = require "lib/gamestate"
inspect = require "lib/inspect"
trail = require "lib/trail"
gui = require "lib/Gspot"

require "enemy"
require "bullet"
require "mine"
explosions = require "explosion"
player = require "player"
controls = require "controls"
state = controls.menu

menu = require "gamestates/menu"
game = require "gamestates/game"
pause = require "gamestates/pause"
options = require "gamestates/options"

function love.load()
  Gamestate.registerEvents()
  return Gamestate.switch(menu)
end

function inputHandler(input)
  local action = state.bindings[input]
  if action then return action() end
end

function love.update(dt)
  gui:update(dt)
end

function love.draw()
  gui:draw()
end

function love.textinput(text)
  gui:textinput(text)
end

function love.mousepressed(x, y, button)
  gui:mousepress(x, y, button)
end

function love.mousereleased(x, y, button)
  gui:mouserelease(x, y, button)
end

function love.keypressed(k)
  gui:keypress(key)
  local binding = state.keys[k]
  return inputHandler(binding)
end

function love.keyreleased(k)
  local binding = state.keysReleased[k]
  return inputHandler(binding)
end
