variable "position" {
  type = object({
    x = number
    y = number
    z = number
  })
}

variable "material" {
  type = string
}