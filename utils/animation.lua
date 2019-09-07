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

function animation.smoothRotation(dt, currentAngle, desiredAngle, rotationSpeed)
  local current = currentAngle -- current rotation in radians
  local target = desiredAngle -- desired angle in radians
  local difference = (target - current + math.pi) % (2 * math.pi) - math.pi

  if difference == 0 then -- nothing to be done here
      return current
  end

  local rate = rotationSpeed -- radians turned per second
  local change = rate * dt -- r/s * delta(change in time)

  if difference < 0 then
      -- make change negative, since difference is as well
      change = change * -1

      -- If (current + change > target), settle for the lesser difference.
      -- This keeps us from "overshooting" the player's rotation
      -- towards a particular target.
      change = math.max(change, difference)
  else
      change = math.min(change, difference)
  end

  return current + change
end

function animation.getAngle(x, y, w, h, targetX, targetY)
  local startX = x + w / 2
  local startY = y + h / 2
  local endX = targetX
  local endY = targetY

  return math.atan2((endY - startY), (endX - startX)), startX, startY
end

return animation
