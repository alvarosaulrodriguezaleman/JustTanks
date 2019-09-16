options =  {}

function options:enter(from)
    self.from = from -- record previous state
    state = controls.options
    love.graphics.setFont(font20)
end

function options:draw()
    local W, H = love.graphics.getWidth(), love.graphics.getHeight()

    love.graphics.setColor(0,0,0, 0.4)
    love.graphics.rectangle('fill', 0,0, W,H)
    love.graphics.setColor(255,255,255)
    love.graphics.printf('Options', 0, H/2, W, 'center')
    love.graphics.printf('Press Escape to return to the previous screen.', 0, H/2+30, W, 'center')
end

return options
