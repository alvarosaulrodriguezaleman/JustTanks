local menu = {}

local classicButtonID
local optionsButtonID

function menu:init()
  font14 = love.graphics.newFont(14)
  font20 = love.graphics.newFont(20)
  font60 = love.graphics.newFont(60)

  local classicButtonFlags = {
  		xPos = love.graphics.getWidth() / 3,
  		yPos = love.graphics.getHeight() / 2 - math.floor(font60:getHeight("Just Tanks") / 3),
  		width = 100,
  		height = 50,
      text = "Classic",

  		color = {
  			red = 45/255,
  			green = 150/255,
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
  			func = function (to, map) return Gamestate.switch(game, 1) end,
  			args = {game, 1},
  		},
  	}

    local optionsButtonFlags = {
    		xPos = love.graphics.getWidth() / 3,
    		yPos = love.graphics.getHeight() / 2 - math.floor(font60:getHeight("Just Tanks") / 3) + 60,
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
    			func = function (to) return Gamestate.push(to) end,
    			args = {options},
    		},
    	}

  classicButtonID = button.spawn(classicButtonFlags)
  optionsButtonID = button.spawn(optionsButtonFlags)
end

function menu:enter()
  button.setVisibility(classicButtonID, true)
  button.setVisibility(optionsButtonID, true)

  state = controls.menu
  player.lives = 3
end

function menu:resume()
  state = controls.menu
end

function menu:leave()
  button.setVisibility(classicButtonID, false)
  button.setVisibility(optionsButtonID, false)
end

function menu:update(dt)
  button.update()
end

function menu:draw()
	love.graphics.setBackgroundColor(57/255, 194/255, 114/255, 0)
  love.graphics.setFont(font60)
  love.graphics.print("Just Tanks", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, 1, 1, 0, math.floor(font60:getHeight("Just Tanks") / 2))
  love.graphics.setFont(font14)
  love.graphics.print("WASD or arrow keys to move, left click to shoot.", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 + 75, 0, 1, 1, 0, math.floor(font60:getHeight("Just Tanks.") / 2))
  button.draw()
end

return menu
