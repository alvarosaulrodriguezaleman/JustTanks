pause =  {}

local optionsButton
local menuButton

function pause:init()
  local W, H = love.graphics.getWidth(), love.graphics.getHeight()
  optionsButton = gui:button('Options', {W/2-60, H/2, 120, 50})
  optionsButton.click = function(this)
    pause.hideGui()
    return Gamestate.push(options)
  end
  optionsButton.style.default = {45/255, 120/255, 89/255, 1}
  optionsButton.style.hilite = {60/255, 135/255, 104/255, 1}

  menuButton = gui:button('Back to menu', {W/2-60, H/2 + 60, 120, 50})
  menuButton.click = function(this)
    pause.hideGui()
    Gamestate.pop()
    return Gamestate.switch(menu)
  end
  menuButton.style.default = {45/255, 120/255, 89/255, 1}
  menuButton.style.hilite = {60/255, 135/255, 104/255, 1}
end

function pause:enter(from)
  self.from = from -- record previous state
  state = controls.pause
  SCREEN_SHAKE = false
  pause.showGui()
end

function pause:resume(from)
  state = controls.pause
  pause.showGui()
end

function pause:leave()
  pause.hideGui()
end

function pause.hideGui()
  optionsButton:hide()
  menuButton:hide()
end

function pause.showGui()
  optionsButton:show()
  menuButton:show()
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
    gui:draw()
    love.graphics.printf('Game paused.', 0, W / 2 - 200, W, 'center')
    love.graphics.printf('Press Escape to go back to the game.', 0, W / 2 - 170, W, 'center')
    love.graphics.setFont(font14)
end

return pause
