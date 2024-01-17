terraform {
  required_providers {
    minecraft = {
      source  = "HashiCraft/minecraft"
      version = "0.1.1"
    }
  }
}

// Configure the provider with the RCON details of the Minecraft server
// RCON_PASSWORD is the password of the server that has to be on and set the RCON password
// RCON can be found on docker server files/srv/minecraft/server.properties
provider "minecraft" {
  address  = "localhost:25575"
  password = "password"
}