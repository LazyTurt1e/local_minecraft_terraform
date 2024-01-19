# Minecraft-Terraform
Here, I am going to attempt to run a Terraform Minecraft server locally.


# Requierments:


## Terraform cli
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli


## Visual Studio
https://code.visualstudio.com/ (recommended extension: HashiCorp Terraform)


## Docker Engine
https://docs.docker.com/engine/install/


## Minecraft server on Docker
https://minecraft.fandom.com/wiki/Tutorials/Setting_up_a_server


1. Check if Java is installed (4.1, 5.1, 6.1).


2. Start the Minecraft Docker server (11).


3. RCON can be found and changed in the files srv/minecraft/server.properties.


### Hint
When you make a server, besides setting a password and allowing RCON, you need to open ports 25565 and 25575 with this command:
```
docker container create --publish 25565:25565/tcp --publish 25575:25575/tcp --name "server" --env RAM=2G sirplexus/minecraft-server-standalone
```


## To make it easier for Docker usage: Docker Desktop
https://docs.docker.com/get-docker/


## Check the Minecraft Terraform HashiCraft provider:
https://registry.terraform.io/providers/HashiCraft/minecraft/latest/docs


1. In Visual Studio, make main.tf and provider.tf


2.in provider.tf set minecraft provider


3. in main.tf modules or resources


Optional: The module cube can be found here: https://github.com/HashiCraft/terraform-provider-minecraft/tree/main/examples/full


Optional: pre-sets can be found here: https://github.com/DevOpsPlayground/terraform_minecraft_playground


# Hint:
For custom modules, there are 4 .tf files needed:


## Variables.tf - example:
```
variable "position" {
type = object({
x = number
y = number
z = number
})
}


variable "dimensions" {
type = object({
width = number
length = number
height = number
})
}


variable "material" {
type = string
}
```


## Main.tf:
```
resource "minecraft_block" "cube" {


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
```


## Locals.tf - example:
```
locals {
// range(start, end) => returns a list of values from start to end
x_values = range(var.position.x, var.position.x + var.dimensions.width)
y_values = range(var.position.y, var.position.y + var.dimensions.height)
z_values = range(var.position.z, var.position.z + var.dimensions.length)


// setproduct([a,b,c], [x,y,z]) => returns a list with all possible combinations of a,b,c and x,y,z
coordinates = setproduct(local.x_values, local.y_values, local.z_values)


// zipmap(["a","b","c"], [1,2,3]) => returns an object with keys of the first array and values of the second array
// e.g. {"a": 1, "b": 2, "c": 3}
blocks = [for coordinate in local.coordinates : zipmap(["x", "y", "z"], coordinate)]
material = length(regexall("^[a-z]+:[a-z]+$", var.material)) > 0 ? var.material : format("%s:%s", "minecraft", var.material)
}
```


## Provide.tf:
```
terraform {
required_providers {
minecraft = {
source = "HashiCraft/minecraft"
version = "0.1.1"
}
}
}
```


## Advice
Most important are variables and locals.


Variables are used to store information to be referenced and manipulated in a computer program.


Locals are used to set the rules of how a provider builds in Minecraft.


## How it will look when you are using this module in your main.tf:
```
module "name" {
source = "./cube"


material = "cobblestone"


position = {
x = 10,
y = 75,
z = -100
}


dimensions = {
width = 2,
length = 2,
height = 2
}
}
```


## Advice
If you need to have a block with two words, use an underscore when you write a material example: material = "smooth_stone".


If you need the correct naming and/or add-ons that can be applied to a specific block, you can look them up on wiki websites like this one: https://minecraft.fandom.com/wiki/Note_Block