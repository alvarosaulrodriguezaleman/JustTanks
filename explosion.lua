local anim = require "utils/animation"

local explosions = {}
local explosion_images = {
  {
    love.graphics.newImage("assets/explosion1.png"),
    love.graphics.newImage("assets/explosion2.png"),
    love.graphics.newImage("assets/explosion3.png"),
    love.graphics.newImage("assets/explosion4.png"),
    love.graphics.newImage("assets/explosion5.png"),
  },
  {
    love.graphics.newImage("assets/explosionSmoke1.png"),
    love.graphics.newImage("assets/explosionSmoke2.png"),
    love.graphics.newImage("assets/explosionSmoke3.png"),
    love.graphics.newImage("assets/explosionSmoke4.png"),
    love.graphics.newImage("assets/explosionSmoke5.png"),
  }
}

function explosions.new(x, y, type, scale)
  table.insert(explosions, {
    x = x,
    y = y,
    type = type,
    scale = scale,
    active_image = 1,
    elapsed_time = 0,
    threshold = 0.1,
  })
end

function explosions.clear()
  explosions = {}
end

function explosions.update(dt)
  for i, e in ipairs(explosions) do
    if e.active_image ~= -1 then
      e.active_image, e.elapsed_time = anim.getFrame(dt, e.active_image, e.elapsed_time, e.threshold, #explosion_images[e.type], "no")
    end
    if e.active_image == -1 then
      table.remove(explosions, i)
    end
  end
end

function explosions.draw()
  for i, e in ipairs(explosions) do
    if e.active_image ~= -1 then
      pcall(function() love.graphics.draw(explosion_images[e.type][e.active_image], e.x, e.y, 0, e.scale, e.scale, explosion_images[e.type][e.active_image]:getWidth() / 2, explosion_images[e.type][e.active_image]:getHeight() / 2) end)
    end
  end
end

return explosions
