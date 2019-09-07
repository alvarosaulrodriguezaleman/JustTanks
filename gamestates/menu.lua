local menu = {}

function menu:enter()
  font14 = love.graphics.newFont(14)
  font20 = love.graphics.newFont(20)
  font60 = love.graphics.newFont(60)

  local flags = {
  		xPos = love.graphics.getWidth() / 3,
  		yPos = love.graphics.getHeight() / 2 - math.floor(font60:getHeight("Just Tanks.") / 3),
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
  			func = Gamestate.switch,
  			args = {game, 1},
  		},
  	}

  id = button.spawn(flags)

  player.lives = 3
end

function menu:update(dt)
  button.update()
end

function menu:draw()
	love.graphics.setBackgroundColor(57/255, 194/255, 114/255, 0)
  love.graphics.setFont(font60)
  love.graphics.print("Just Tanks.", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, 1, 1, 0, math.floor(font60:getHeight("Just Tanks.") / 2))
  love.graphics.setFont(font14)
  button.draw()
end

return menu
