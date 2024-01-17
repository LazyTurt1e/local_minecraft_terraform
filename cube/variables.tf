variable "position" {
  type = object({
    x = number
    y = number
    z = number
  })
}

variable "dimensions" {
  type = object({
    width  = number
    length = number
    height = number
  })
}

variable "material" {
  type = string
}