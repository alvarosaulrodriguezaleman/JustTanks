local menu = {}

local W, H = love.graphics.getWidth(), love.graphics.getHeight()
local classicButton
local optionsButton
local quitButton

local titleTextPos
local controlsTextPos

function menu:init()
  BASE_TX = 0
  BASE_TY = 0
  BASE_SX = 1
  BASE_SY = 1

  font14 = love.graphics.newFont(14)
  font20 = love.graphics.newFont(20)
  font60 = love.graphics.newFont(60)

  classicButton = gui:button('Play', {0,0,0,0})
  classicButton.click = function(this) return Gamestate.switch(game, 1) end
  classicButton.style.default = {45/255, 150/255, 89/255, 1}
  classicButton.style.hilite = {60/255, 165/255, 104/255, 1}

  optionsButton = gui:button('Options', {0,0,0,0})
  optionsButton.click = function(this)
    menu.hideGui()
    return Gamestate.push(options)
  end
  optionsButton.style.default = {45/255, 120/255, 89/255, 1}
  optionsButton.style.hilite = {60/255, 135/255, 104/255, 1}

  quitButton = gui:button('Quit', {0,0,0,0})
  quitButton.click = function(this)
    love.event.quit()
  end
  quitButton.style.default = {45/255, 120/255, 89/255, 1}
  quitButton.style.hilite = {60/255, 135/255, 104/255, 1}

  menu.refreshGuiPositions()
end

function menu:enter()
  menu.showGui()
  state = controls.menu
  player.lives = 3
end

function menu:resume()
  menu.showGui()
  state = controls.menu
end

function menu:leave()
  menu.hideGui()
end

function menu.hideGui()
  classicButton:hide()
  optionsButton:hide()
  quitButton:hide()
end

function menu.showGui()
  classicButton:show()
  optionsButton:show()
  quitButton:show()
  menu.refreshGuiPositions()
end

function menu.refreshGuiPositions()
  local W, H = love.graphics.getWidth(), love.graphics.getHeight()
  classicButton.pos = {W/2-175, H/2-math.floor(font60:getHeight("Just Tanks") / 3), 100, 50}
  optionsButton.pos = {W/2-175, H/2-math.floor(font60:getHeight("Just Tanks") / 3) + 60, 100, 50}
  quitButton.pos = {W/2-175, H/2-math.floor(font60:getHeight("Just Tanks") / 3) + 120, 100, 50}

  titleTextPos = {W / 2, H / 2}
  controlsTextPos = {W / 2, H / 2 + 75}

end

function menu:draw()
	love.graphics.setBackgroundColor(57/255, 194/255, 114/255, 0)
  love.graphics.setFont(font60)
  love.graphics.print("Just Tanks", titleTextPos[1], titleTextPos[2], 0, 1, 1, 0, math.floor(font60:getHeight("Just Tanks") / 2))
  love.graphics.setFont(font14)
  love.graphics.print("WASD or arrow keys to move", controlsTextPos[1], controlsTextPos[2], 0, 1, 1, 0, math.floor(font60:getHeight("Just Tanks.") / 2))
  love.graphics.print("left click to shoot", controlsTextPos[1], controlsTextPos[2] + 20, 0, 1, 1, 0, math.floor(font60:getHeight("Just Tanks.") / 2))
  love.graphics.print("space to place mines", controlsTextPos[1],controlsTextPos[2] + 40, 0, 1, 1, 0, math.floor(font60:getHeight("Just Tanks.") / 2))
end

return menu
