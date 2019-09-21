return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 21,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 8,
  nextobjectid = 11,
  properties = {},
  tilesets = {
    {
      name = "countryside",
      firstgid = 1,
      filename = "../../tiled/countryside.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "../assets/countryside.png",
      imagewidth = 128,
      imageheight = 128,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 16,
      tiles = {
        {
          id = 1,
          properties = {
            ["collidable"] = true,
            ["isWall"] = true
          }
        },
        {
          id = 2,
          properties = {
            ["collidable"] = true,
            ["isWall"] = true
          }
        },
        {
          id = 5,
          properties = {
            ["collidable"] = true,
            ["destroyable"] = true,
            ["isWall"] = true
          }
        },
        {
          id = 6,
          properties = {
            ["collidable"] = true,
            ["isWall"] = true
          }
        },
        {
          id = 9,
          properties = {
            ["collidable"] = true,
            ["destroyable"] = true,
            ["isWall"] = true
          }
        },
        {
          id = 10,
          properties = {
            ["collidable"] = true,
            ["isWall"] = true
          }
        },
        {
          id = 13,
          properties = {
            ["collidable"] = true
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 7,
      name = "Tiles",
      x = 0,
      y = 0,
      width = 32,
      height = 21,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
        2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 1, 5, 1, 1, 1, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 2,
        2, 1, 1, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 1, 1, 1, 5, 5, 5, 1, 1, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 1, 1, 6, 1, 1, 5, 5, 5, 1, 1, 1, 1, 1, 5, 5, 5, 1, 5, 5, 5, 1, 6, 1, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 1, 1, 6, 5, 5, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 5, 1, 5, 5, 1, 6, 1, 1, 1, 1, 1, 2,
        2, 1, 5, 5, 5, 5, 6, 5, 5, 5, 5, 5, 2, 2, 2, 2, 2, 2, 2, 2, 5, 5, 5, 5, 5, 6, 5, 5, 5, 5, 5, 2,
        2, 1, 1, 1, 1, 1, 6, 1, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 6, 1, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 1, 1, 6, 1, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 1, 6, 5, 1, 1, 1, 1, 2,
        2, 1, 1, 5, 5, 1, 1, 1, 1, 1, 5, 5, 1, 5, 5, 5, 5, 5, 1, 1, 1, 5, 5, 5, 5, 1, 5, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 5, 1, 1, 1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 5, 5, 5, 5, 5, 5, 5, 5, 1, 1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 1, 1, 1, 5, 5, 5, 1, 1, 1, 5, 5, 5, 5, 1, 1, 5, 5, 5, 1, 1, 1, 1, 5, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 5, 5, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1, 1, 1, 1, 1, 2,
        2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
      }
    },
    {
      type = "objectgroup",
      id = 3,
      name = "Sprites",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 3,
          name = "Player",
          type = "",
          shape = "rectangle",
          x = 500,
          y = 510,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "Enemy",
          type = "1",
          shape = "rectangle",
          x = 500,
          y = 140,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
