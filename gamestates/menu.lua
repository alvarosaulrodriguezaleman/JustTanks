local menu = {}

function menu:enter()
  local flags = {
  		xPos = 100,
  		yPos  = 300,
  		width = 100,
  		height = 50,
      text = "Classic",

  		color = {
  			red = 0,
  			green = 0,
  			blue = 255,
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
end

function menu:update(dt)
  button.update()
end

function menu:draw()
	love.graphics.setBackgroundColor(153/255, 153/255, 1, 0)
  button.draw()
end

return menu
