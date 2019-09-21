local controls = {}

controls.game = {
  bindings = {
    moveUp = function() player.wantsUp = true end,
    moveDown = function() player.wantsDown = true end,
    moveLeft = function() player.wantsLeft = true end,
		moveRight = function() player.wantsRight = true end,
		releaseUp = function() player.wantsUp = false end,
    releaseDown = function() player.wantsDown = false end,
    releaseLeft = function() player.wantsLeft = false end,
		releaseRight = function() player.wantsRight = false end,
    enterPause = function() return Gamestate.push(pause) end,
    placeMine = function() player.placeMine() end
  },
  keys = {
    w = "moveUp",
		up = "moveUp",
    s = "moveDown",
		down = "moveDown",
    a = "moveLeft",
		left = "moveLeft",
    d = "moveRight",
		right = "moveRight",
    escape = "enterPause",
    space = "placeMine",
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

controls.menu = {
  bindings = {
    bufferMoveUp = function() player.wantsUp = true end,
    bufferMoveDown = function() player.wantsDown = true end,
    bufferMoveLeft = function() player.wantsLeft = true end,
		bufferMoveRight = function() player.wantsRight = true end,
		bufferReleaseUp = function() player.wantsUp = false end,
    bufferReleaseDown = function() player.wantsDown = false end,
    bufferReleaseLeft = function() player.wantsLeft = false end,
		bufferReleaseRight = function() player.wantsRight = false end
  },
  keys = {
    w = "bufferMoveUp",
		up = "bufferMoveUp",
    s = "bufferMoveDown",
		down = "bufferMoveDown",
    a = "bufferMoveLeft",
		left = "bufferMoveLeft",
    d = "bufferMoveRight",
		right = "bufferMoveRight",
  },
	keysReleased = {
    w = "bufferReleaseUp",
		up = "bufferReleaseUp",
    s = "bufferReleaseDown",
		down = "bufferReleaseDown",
    a = "bufferReleaseLeft",
		left = "bufferReleaseLeft",
    d = "bufferReleaseRight",
		right = "bufferReleaseRight"
	}
}

controls.pause = {
  bindings = {
    bufferMoveUp = function() player.wantsUp = true end,
    bufferMoveDown = function() player.wantsDown = true end,
    bufferMoveLeft = function() player.wantsLeft = true end,
		bufferMoveRight = function() player.wantsRight = true end,
		bufferReleaseUp = function() player.wantsUp = false end,
    bufferReleaseDown = function() player.wantsDown = false end,
    bufferReleaseLeft = function() player.wantsLeft = false end,
		bufferReleaseRight = function() player.wantsRight = false end,
    backToGame = function () Gamestate.pop() end,
  },
  keys = {
    escape = "backToGame",
    w = "bufferMoveUp",
		up = "bufferMoveUp",
    s = "bufferMoveDown",
		down = "bufferMoveDown",
    a = "bufferMoveLeft",
		left = "bufferMoveLeft",
    d = "bufferMoveRight",
		right = "bufferMoveRight",
  },
	keysReleased = {
    w = "bufferReleaseUp",
		up = "bufferReleaseUp",
    s = "bufferReleaseDown",
		down = "bufferReleaseDown",
    a = "bufferReleaseLeft",
		left = "bufferReleaseLeft",
    d = "bufferReleaseRight",
		right = "bufferReleaseRight"
	}
}

controls.options = {
  bindings = {
    bufferMoveUp = function() player.wantsUp = true end,
    bufferMoveDown = function() player.wantsDown = true end,
    bufferMoveLeft = function() player.wantsLeft = true end,
		bufferMoveRight = function() player.wantsRight = true end,
		bufferReleaseUp = function() player.wantsUp = false end,
    bufferReleaseDown = function() player.wantsDown = false end,
    bufferReleaseLeft = function() player.wantsLeft = false end,
		bufferReleaseRight = function() player.wantsRight = false end,
    backToPreviousScreen = function () Gamestate.pop() end,
  },
  keys = {
    escape = "backToPreviousScreen",
    w = "bufferMoveUp",
		up = "bufferMoveUp",
    s = "bufferMoveDown",
		down = "bufferMoveDown",
    a = "bufferMoveLeft",
		left = "bufferMoveLeft",
    d = "bufferMoveRight",
		right = "bufferMoveRight",
  },
	keysReleased = {
    w = "bufferReleaseUp",
		up = "bufferReleaseUp",
    s = "bufferReleaseDown",
		down = "bufferReleaseDown",
    a = "bufferReleaseLeft",
		left = "bufferReleaseLeft",
    d = "bufferReleaseRight",
		right = "bufferReleaseRight"
	}
}

return controls
