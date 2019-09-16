pause =  {}

local optionsButtonID

function pause:init()
  local W, H = love.graphics.getWidth(), love.graphics.getHeight()
  local optionsButtonFlags = {
    xPos = W / 2 - 50,
    yPos = H / 2,
    width = 100,
    height = 50,
    text = "Options",

    color = {
      red = 45/255,
      green = 120/255,
      blue = 89/255,
    },

    border = {
      width = 2,
      red = 0,
      green = 0,
      blue = 0,
    },

    onClick = {
      func = function () end,
      args = {},
    },

    onRelease = {
      func = function (to) print("push options")
        return Gamestate.push(to) end,
      args = {options},
    },
  }

  optionsButtonID = button.spawn(optionsButtonFlags)
end

function pause:enter(from)
  self.from = from -- record previous state
  state = controls.pause
  SCREEN_SHAKE = false
  love.graphics.setFont(font20)
  button.setVisibility(optionsButtonID, true)
end

function pause:leave()
  button.setVisibility(optionsButtonID, false)
end

function pause:update(dt)
  button.update()
end

function pause:draw()
    love.graphics.setFont(font20)
    local W, H = love.graphics.getWidth(), love.graphics.getHeight()
    -- draw previous screen
    self.from:draw()
    -- overlay with pause message
    love.graphics.setColor(0,0,0, 0.6)
    love.graphics.rectangle('fill', 0,0, W,H)
    love.graphics.setColor(255,255,255)
    love.graphics.printf('Game paused.', 0, W / 2 - 200, W, 'center')
    love.graphics.printf('Press Escape to go back to the game.', 0, W / 2 - 170, W, 'center')
    love.graphics.setFont(font14)
    button.draw()
end

return pause
