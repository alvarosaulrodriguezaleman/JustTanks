animation = {}

function animation.getQuads(spritesheet, x, y, w, h, n)
  local quads = {}
  for i = 1, n do
    quads[i] = love.graphics.newQuad(x+w*(i-1),y,w,h,spritesheet:getDimensions())
  end
  return quads
end

function animation.getDirectionalQuads(spritesheet, x, y, w, h, n)
  local quads = {}
  quads.up = animation.getQuads(spritesheet, x, y, w, h, n)
  quads.down = animation.getQuads(spritesheet, x, y+h, w, h, n)
  quads.left = animation.getQuads(spritesheet, x, y+2*h, w, h, n)
  quads.right = animation.getQuads(spritesheet, x, y+3*h, w, h, n)
  return quads
end

function animation.getFrame(dt, currentFrame, elapsedTime, threshold, frameCount)
  elapsedTime = elapsedTime + dt

  if(elapsedTime > threshold) then
    if(currentFrame < frameCount) then
        currentFrame = currentFrame + 1
    else
        currentFrame = 1
    end
    elapsedTime = 0
  end

  return currentFrame, elapsedTime
end

return animation
