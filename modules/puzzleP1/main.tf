resource "minecraft_block" "string" {
    // loop over the blocks and set the index as the id
  for_each = { for i, o in local.blocks : "block-${i}" => o }

  // use the computed material as the material
  material = local.material

  // use the position of each block as its position
  position = {
    x = each.value.x,
    y = each.value.y,
    z = each.value.z
  }
}