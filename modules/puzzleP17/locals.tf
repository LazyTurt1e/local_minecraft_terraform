locals {
    coordinates = [
      [1,0,-1],
      [0,0,-1],[0,0,0],
               [-1,0,0],[-1,0,1],
      ]

  blocks_coordinates = [for block in local.coordinates :
      [var.position.x + block[0], var.position.y + block[1], var.position.z - block[2]]
    ]

  blocks   = [for coordinate in local.blocks_coordinates : zipmap(["x", "y", "z"], coordinate)]
  material = length(regexall("^[a-z]+:[a-z]+$", var.material)) > 0 ? var.material : format("%s:%s", "minecraft", var.material)
}