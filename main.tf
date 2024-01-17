# resource "minecraft_block" "stone" {
#   material = "minecraft:stone"

#   position = {
#     x = -47,
#     y = 65,
#     z = 29
#   }
# }

# module "name" {
#   source = "./cube"

#   material = "cobblestone"

#   position = {
#     x = 10,
#     y = 75,
#     z = -100
#   }

#   dimensions = {
#     width  = 1,
#     length = 6,
#     height = 5
#   }
# }

module "floor_for_test" {
  source = "./cube"

  material = "smooth_stone"

  position = {
    x = 220,
    y = 69,
    z = 2020
  }

  dimensions = {
    width  = 10,
    length = 10,
    height = 1
  }
}

