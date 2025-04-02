This contains documentation for multiple scripts
# [crosshair.gd](https://github.com/Astat7/fps-game/blob/main/code/crosshair.gd)
## Methods
### _ready()
- returns void

Moves the crosshair into the middle of the screen on start and each time viewport size changes
# [ammo_counter.gd](https://github.com/Astat7/fps-game/blob/main/code/ammo_counter.gd)
## Methods
### update(ammo, max_ammo)
- returns void

Updates the ammo counter UI to show the passed values
#### arguments
- ammo - number to display
- max_ammo - number to display
### _ready()
- returns void

Keeps the UI's position on screen in the bottom right corner
# [health_bar.gd](https://github.com/Astat7/fps-game/blob/main/code/health_bar.gd)
## Variables
- SuperLabel - node that controls the position of the health bar
- max_health_bar_size - how large is the health bar at 100% health
## Methods
### update(health, max_health)
- returns void

Updates the health bar UI to show the passed values
#### arguments
- health - number used to determine the size of the health bar
- max_health - number used to determine the size of the health bar
### _ready()
- returns void

Keeps the UI's position on screen in the bottom left corner
