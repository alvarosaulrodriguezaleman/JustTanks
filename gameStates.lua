local gameStates = {}

gameStates.gameLoop = {
  bindings = {
    moveUp = function() player.wantsUp = true end,
    moveDown = function() player.wantsDown = true end,
    moveLeft = function() player.wantsLeft = true end,
		moveRight = function() player.wantsRight = true end,
		releaseUp = function() player.wantsUp = false end,
    releaseDown = function() player.wantsDown = false end,
    releaseLeft = function() player.wantsLeft = false end,
		releaseRight = function() player.wantsRight = false end
  },
  keys = {
    w = "moveUp",
		up = "moveUp",
    s = "moveDown",
		down = "moveDown",
    a = "moveLeft",
		left = "moveLeft",
    d = "moveRight",
		right = "moveRight"
  },
	keysReleased = {
		w = "releaseUp",
		up = "releaseUp",
    s = "releaseDown",
		down = "releaseDown",
    a = "releaseLeft",
		left = "releaseLeft",
    d = "releaseRight",
		right = "releaseRight"
	}
}

return gameStates
