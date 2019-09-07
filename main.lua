sti = require "lib/sti"
bump = require "lib/bump"
Timer = require "lib/timer"
Gamestate = require "lib/gamestate"
inspect = require "lib/inspect"
button = require "lib/dabuton"

require "enemy"
require "bullet"
player = require "player"
controls = require "controls"
state = controls.game

menu = require "gamestates/menu"
game = require "gamestates/game"

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
  Gamestate.registerEvents()
  return Gamestate.switch(menu)
end
