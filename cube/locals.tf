locals {
  // range(start, end) => returns a list of values from start to end
  x_values = range(var.position.x, var.position.x + var.dimensions.width)
  y_values = range(var.position.y, var.position.y + var.dimensions.height)
  z_values = range(var.position.z, var.position.z + var.dimensions.length)

  // setproduct([a,b,c], [x,y,z]) => returns a list with all possible combinations of a,b,c and x,y,z
  coordinates = setproduct(local.x_values, local.y_values, local.z_values)

  // zipmap(["a","b","c"], [1,2,3]) => returns an object with keys of the first array and values of the second array 
  // e.g. {"a": 1, "b": 2, "c": 3} 
  blocks   = [for coordinate in local.coordinates : zipmap(["x", "y", "z"], coordinate)]
  material = length(regexall("^[a-z]+:[a-z]+$", var.material)) > 0 ? var.material : format("%s:%s", "minecraft", var.material)
}