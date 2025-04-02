This contains documentation for multiple scripts
# [door.gd](https://github.com/Astat7/fps-game/blob/main/code/door.gd)
## Variables
- moving - if the door is currently opening/closing or not
- opened - if the door is currently opened or closed
- speed - how fast the door opens/closes
- some variables for tween opening/closing aniamtion
## Methods
### set_moving(state=false)
- returns void

Setter for *moving* variable
#### arguments
- state - which value to assign to *moving* variable, defaults to *false*
### open()
- returns void

Opens the door
### close()
- returns void

Closes the door
### button_pressed()
- returns bool - if the door was closed/opened succesfully or not

Opesn/closes the door and returns information abotu success
# [button.gd](https://github.com/Astat7/fps-game/blob/main/code/button.gd)
## Variables
- locked - if the button can be used or not
- used - if the button was pressed successfully atleast once or not
## Methods
### _on_interacted_signal()
- returns void

Handles the button being pressed, open/closes the door and generates next level when used for the first time
# [button_collider.gd](https://github.com/Astat7/fps-game/blob/main/code/button_collider.gd)
## Signals
- interacted_signal
## Methods
### interacted()
- returns void

Emits the *interacted_signal*, used to trigger things with player interaction
