# Documentation for script [player_control.gd](https://github.com/Astat7/fps-game/blob/main/code/player_control.gd)
## Variables
- gun_range – how far can the player shoot
- interact_ragne – from how far can the player interact with stuff, such as pressing buttons
- max_ammo – how much ammo can the player's gun's magazine hold
- ammo – how much ammo is left inside the gun
- max_health – maximum ammount of player's health
- health – current player's health
- move_speed – how fast the player moves horizontally
- jump_speed – used to affect how high the player can jump
- free_mouse – used to control if the mouse if used for controlling the player character or the game
- bullet_speed – used in bullet animation only, how long it takes a bullet to travel one meter
- reload_time – how long it takes the player to reload the gun
- reloading – used to tract if the player is currently reloading the gun
- dead – used to track if the player has died
## Methods
### rotate_camera
- returns void

Allows the player to rotate the camera vertically and horizontally by moving the mouse
#### arguments
- event – holds input from the player
