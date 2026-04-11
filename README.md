
# Learn with sensors

> This package **teaches you the basics of Godot by illustrating it using sensors.**


By mocking or simulating Internet of Things (IoT) sensors in Godot, you can learn about: Meshes, Materials, Translation, Animation, Rotation, Collision, Raycasting, Math, and more.    

It feels like the perfect learning and training ground to me.   
So let’s see where we can go with that!   

Add to Git project:

```bash
git submodule add https://github.com/EloiStree/2026_04_11_gdp_learn_with_sensors.git addons/2026_04_11_gdp_learn_with_sensors
```

See:

* Micro Bit Package: [https://github.com/EloiStree/2026_03_20_gdp_hello_micro_bit](https://github.com/EloiStree/2026_03_20_gdp_hello_micro_bit)
  * To simulate a Micro Bit mod in your game
* Pins package: [https://github.com/EloiStree/2026_04_11_gdp_pins](https://github.com/EloiStree/2026_04_11_gdp_pins)
  * To create an abstract interface
* Hello Sensors Doc: [https://github.com/EloiStree/2026_03_23_doc_micro_bit_sensor](https://github.com/EloiStree/2026_03_23_doc_micro_bit_sensor)
  * Information on the sensors used in IoT


**Easy:**
- Add script to change color of MeshInstance duplicated material
  - Add a scene square to debug state
- Green for output signal
- Black for other addons voltage out
- Red for other addons voltage in
- Add Node to node AB script
- Button View
  - Animation
  - Script Node On Off
  - Add a classic 4-pin button
  - Add arcade button (2-pin)
  - Add Cherry button (2-pin)
  - Hard: add RGB Cherry button
- Add a click on/off area debug script from mouse
  - Make it work with Android Input
- On/Off LED
  - With Hide/Show Node
  - With Change Color of material
- Add a Piston Motor
  - Add graybox small cylinder
  - Add graybox big cylinder with hook
- Add Node Local rotation based on percent left/right
  - Add SG90
  - Add SG90 Head Adapter
- Add Motor Rotation Script
  - Add graybox of small classic motor
  - Add graybox of amazon yellow motor
  - Add graybox of mini drone motor
  - Add graybox of cylindric gearbox adaptor
- Add Step Motor Rotation Script
  - Add graybox of the 28BYJ-48
  - Add big square step motor
  - Hard bonus: add a binary 4-pin adaptor
- Add a moving node based on line
  - A version in percent
  - A version in rotation value with max/min
- Dim LED one color
  - With percent to material color
  - Add boolean setter
- RGB LED
  - With 3 float values to material color
  - With 3 bytes values to material color
  - Add boolean R/G/B setters
  - Add Keyestudio RGB
  - Add LED strip RGB
- RGB Traffic Light
  - 3 on/off inputs
- Add a LED strip composed of RGB LEDs script
  - Add a set from Array[byte] (easy mode)
- Add graybox of 3W LED
- Add a rotation potentiometer sensor input from node
  - Add Keyestudio graybox
  - Add music store version
- Add switch on/off based on local rotation state
  - Add graybox of big on/off switch
- Add some collision detection on/off
  - From Layer
  - From Group Tag
  - From Script Tag
  - From Layer, Group and Script tag
- Add 3D capacitive on/off relay
  - Add graybox of touching Keyestudio
- Add collision example
  - Add graybox of blue touch classic
- Add collision example
  - Add graybox of red touch classic
- Add collision example
  - Add collision example for button near the graybox
- Add a sphere pressure collision
  - Add a low pressure button moving with pressure
  - Add graybox of the flat surface
  - Add graybox of the 4-box one
  - Add the Keyestudio one
- Add a Micro Switch V-15-1C25
  - Use collision enter/exit for that
- Add resistor (percent) script
  - Add Graybox of
- Light resistor
- Water in ground resistor
- Water level resistor
- Add Laser Module
  - Version with simple point
  - Version with a cylinder
  - Version with a rigged cylinder and distance
  - Bonus: version with dusty shader from tech artist
- Add a view of a joystick 2D
  - Classic joystick
- Add a view of a drone 2D
  - With "auto return stick" user option for later
- Add a screw potentiometer
  - Graybox of a blue square rotation plane

**Medium (without script tag):**
- Add a compass with a singleton to know where is north
- Add a vibration detector
- Add a tilt detector
- Add a fake accelerometer
  - Basic Face up
  - Left/Right
  - Back/Front
  - Basic face front
  - Wheel left to right
- Add Movement detector
  - Raycast
  - Spherecast
  - Shapecast
  - PIR IR simulation
- Add relays
  - Add several relay sound records
  - Single Relay
	- Classic
	- Solide
  - Group of 4
	- Classic
	- Solide
  - Group of 8
	- Classic
	- Solide

**Medium (using script tag):**  
_Create areas with scripts on them that give information_
- Ability to read:
  - Soil Humidity
  - Steam
  - Room temperature (-5 to 50)
  - Heat source temperature (no laser)
  - Presence of a magnet (hall effect)
  - Flame sensor
  - Sound Sensor
  - Photo Interrupter Module
- Thin Pressure
  - Require how far the collider enters and direction source

**Uncategorized yet:**
- Passive Buzzer
- Active Buzzer
- S12SD VVR Keyestudio
- Alcohol Sensor
- Gas Sensor
- Reed Switch Module
- Thin Film Pressure sensor
- Infrared obstacle sensor
- Line Tracking sensor
- Shield V2
- Flat Disk
- Display Module
  - For Texture and share workshop:
	- Keyestudio one
	- Classic square one on Amazon
	- Watch one

**Won't do:**  
_But graybox could be there_
- Lithium battery
- Solar panel kit
- AA/AAA Holder and battery
- Cabling xD
- Optocoupler reading

**Challenge:**
- Pinch a joystick to interact with it and use current pincher position to give Vector2D to its model
- Use collision physics to move the joystick state

**Bonus:**
- Add drum pad music square

**Chronophage:**
- Add graybox of all sorts of buyable buttons in electronics stores.

---

**In my Keyestudio box I bought in the past:**
- Sensor Shield V2
- White LED module
- Red LED module
- 3W LED module
- RGB LED module
- Analog temperature sensor
- Photocell sensor
- Analog sound sensor
- Analog rotation sensor
- Passive buzzer
- Active buzzer module
- Digital push button
- Digital tilt sensor
- Photo interrupter module
- Capacitive touch sensor
- Traffic light module
- Hall magnetic sensor
- Line tracking sensor
- Infrared obstacle sensor
- PIR motion sensor
- Flame sensor
- Crash sensor
- Analog gas sensor
- Analog alcohol sensor
- Reed switch module
- Water sensor
- Soil humidity sensor
- Temperature sensor
- Vibration sensor
- Thin film pressure sensor
- Display module
- Light sensor
- Ultrasonic module
- Joystick module
- Micro servo
- Ultraviolet sensor
- Steam sensor
- Single relay module
- Cables
- 6AA battery holder

**Not in the pack (to not forget):**
- Voltage from sector for micro:bit
- Voltage, Amp source school box
- LED strip of 100+
- Infrared Light emitter (out of game frame rate)
  - Infrared light receptor (out of game frame rate)
- 8 optocouplers
- Step motor drive board
- Measure 150 cm
- Measure 150 mm
- Bubble bar
- Bubble level 4-6 degrees
