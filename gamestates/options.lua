options =  {}

local toggleFullscreenButton
local isFullscreenActive = false

local reshub
local res1920x1080
local res1600x900
local res1366x768
local res1280x720
local res1024x768

local listener

local optionsTextPos
local setResolutionTextPos
local goBackTextPos

function options:init()
  toggleFullscreenButton = gui:button('Enable fullscreen', {0,0,0,0})
  toggleFullscreenButton.click = function(this)
    if not isFullscreenActive then
      isFullscreenActive = love.window.setFullscreen(true, "exclusive")
    else
      isFullscreenActive = love.window.setFullscreen(false)
      isFullscreenActive = not isFullscreenActive
    end
    if isFullscreenActive then
      toggleFullscreenButton.label = "Disable fullscreen"
    else
      toggleFullscreenButton.label = "Enable fullscreen"
    end
  end
  toggleFullscreenButton.style.default = {45/255, 120/255, 89/255, 1}
  toggleFullscreenButton.style.hilite = {60/255, 135/255, 104/255, 1}

  options.initResolutionButtons()
  options.refreshGuiPositions()
end

function options.initResolutionButtons()
  reshub = gui:hidden()
  res1920x1080 = gui:option('1920x1080', {0,0,0,0}, reshub, {1920, 1080})
  res1920x1080.style.default = {45/255, 120/255, 89/255, 1}
  res1920x1080.style.hilite = {60/255, 135/255, 104/255, 1}
  res1920x1080.style.focus = {60/255, 135/255, 104/255, 1}

  res1600x900 = gui:option('1600x900', {0,0,0,0}, reshub, {1600, 900})
  res1600x900.style.default = {45/255, 120/255, 89/255, 1}
  res1600x900.style.hilite = {60/255, 135/255, 104/255, 1}
  res1600x900.style.focus = {60/255, 135/255, 104/255, 1}

  res1366x768 = gui:option('1366x768', {0,0,0,0}, reshub, {1366, 768})
  res1366x768.style.default = {45/255, 120/255, 89/255, 1}
  res1366x768.style.hilite = {60/255, 135/255, 104/255, 1}
  res1366x768.style.focus = {60/255, 135/255, 104/255, 1}

  res1280x720 = gui:option('1280x720', {0,0,0,0}, reshub, {1280, 720})
  res1280x720.style.default = {45/255, 120/255, 89/255, 1}
  res1280x720.style.hilite = {60/255, 135/255, 104/255, 1}
  res1280x720.style.focus = {60/255, 135/255, 104/255, 1}

  res1024x768 = gui:option('1024x768', {0,0,0,0}, reshub, {1024, 768})
  res1024x768.style.default = {45/255, 120/255, 89/255, 1}
  res1024x768.style.hilite = {60/255, 135/255, 104/255, 1}
  res1024x768.style.focus = {60/255, 135/255, 104/255, 1}
end

function options:resume(from)
  state = controls.options
  options.showGui()
end

function options:leave()
  options.hideGui()
end

function options:enter(from)
  self.from = from -- record previous state
  state = controls.options
  love.graphics.setFont(font20)
  options.showGui()
end

function options:update(dt)
  if reshub.value ~= listener then
    love.window.setMode(reshub.value[1], reshub.value[2], {fullscreen = isFullscreenActive, fullscreentype = "exclusive"})
    options.setBaseTransformation(reshub.value[1])
    options.refreshGuiPositions()
  end
  listener = reshub.value
end

function options.setBaseTransformation(resolution)
  local W, H = love.graphics.getWidth(), love.graphics.getHeight()
  if resolution == 1920 or resolution == 1600 then
    BASE_SX = 1.1
    BASE_SY = 1.1
    BASE_TX = (W/BASE_SX-(32*32))/2
    BASE_TY = (H/BASE_SY-(21*32))/3
  elseif resolution == 1366 then
    BASE_SX = 1
    BASE_SY = 1
    BASE_TX = (W/BASE_SX-(32*32))/2
    BASE_TY = 0
  elseif resolution == 1280 then
    BASE_SX = 0.95
    BASE_SY = 0.95
    BASE_TX = (W/BASE_SX-(32*32))/2
    BASE_TY = 0
  elseif resolution == 1024 then
    BASE_SX = 1
    BASE_SY = 1
    BASE_TX = 0
    BASE_TY = 0
  end
end

function options.hideGui()
  toggleFullscreenButton:hide()
  reshub:hide()
  res1024x768:hide()
  res1280x720:hide()
  res1366x768:hide()
  res1600x900:hide()
  res1920x1080:hide()
end

function options.showGui()
  toggleFullscreenButton:show()
  reshub:show()
  res1024x768:show()
  res1280x720:show()
  res1366x768:show()
  res1600x900:show()
  res1920x1080:show()
  options.refreshGuiPositions()
end

function options.refreshGuiPositions()
  local W, H = love.graphics.getWidth(), love.graphics.getHeight()
  res1920x1080.pos = {W/2+100, H/2 - 140, 100, 30}
  res1600x900.pos = {W/2+100, H/2 - 100, 100, 30}
  res1366x768.pos = {W/2+100, H/2 - 60, 100, 30}
  res1280x720.pos = {W/2+100, H/2 - 20, 100, 30}
  res1024x768.pos = {W/2+100, H/2 + 20, 100, 30}
  toggleFullscreenButton.pos = {W/2-225, H/2-180, 150, 50}
  optionsTextPos = {0, H/2 - 250}
  goBackTextPos = {0, H/2 - 220}
  setResolutionTextPos = {150, H/2 - 175}
end

function options:draw()
    local W, H = love.graphics.getWidth(), love.graphics.getHeight()

    love.graphics.setColor(0,0,0, 0.2)
    love.graphics.rectangle('fill', 0,0, W,H)
    love.graphics.setColor(255,255,255)
    love.graphics.printf('Options.', optionsTextPos[1], optionsTextPos[2], W, 'center')
    love.graphics.printf('Press Escape to go back to the previous screen.', goBackTextPos[1], goBackTextPos[2], W, 'center')
    love.graphics.printf('Set resolution', setResolutionTextPos[1], setResolutionTextPos[2], W, 'center')
    gui:draw()
end

return options
