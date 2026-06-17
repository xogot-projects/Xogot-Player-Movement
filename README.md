# Better Player Movement in Xogot (Xogot 3D Tutorial)

This project contains the example scenes and scripts used in the
**Xogot 3D Modular Series - Better Player Movement** tutorial by **Erin Uptegrove**.

It demonstrates how to improve a basic 3D player controller in **Xogot** - the iPad and iPhone port
of the Godot Engine - by adding player rotation, organizing exported movement settings, and creating
more customizable jump physics.

The project shows how small script changes can make player movement feel more responsive, expressive,
and tunable while previewing the game directly in Xogot.

---

## Features

* Improve the default **CharacterBody3D** player movement script
* Add left and right player rotation
* Use custom input actions such as `turn_left` and `turn_right`
* Organize exported variables with **export groups**
* Rename and separate movement values such as `move_speed` and `turn_speed`
* Add a dedicated **Jump Physics** export group
* Control maximum jump height with a `max_jump_height` variable
* Calculate jump velocity from gravity and desired jump height
* Add adjustable air speed for longer or shorter jumps
* Use fall weight to create floatier or heavier falling behavior
* Support partial jumps when the jump input is released early
* Use partial momentum to control how much upward velocity is preserved
* Add jump steering to control how much the player can change direction in the air
* Separate ground movement from air movement
* Smoothly decelerate the player when no movement input is active
* Use Remote view to tune movement and jump values while the game is running

---

## Notes

This project focuses on **improving the feel of a simple 3D player controller** in Xogot. It builds on
introductory player movement concepts and is intended as a practical example of how to make a basic
controller more customizable.

It is not intended to be a complete advanced character controller, animation system, combat controller,
or camera-relative movement framework.

Key ideas demonstrated include:

* Exported variables make player movement easier to tune from the Inspector
* Export groups help keep related gameplay settings organized
* Rotation can be added with a small amount of input and transform logic
* Jump height can be controlled directly instead of relying on a fixed jump velocity
* Fall weight has a major effect on whether a jump feels floaty or heavy
* Early jump release can create shorter, more responsive jumps
* Air speed and jump steering can dramatically change how much control the player has in midair
* Remote view makes it easy to experiment with gameplay values while previewing the project

---

## Video Tutorial

Watch the full walkthrough on the [Xogot YouTube Channel](https://youtube.com/@xogot):
[Better Player Movement in Xogot - Game Development in Godot on iPad](https://youtu.be/gFdxXKOI7vU)

---

## How to Use

1. Download or clone this repository:

   ```bash
   git clone https://github.com/xogot-projects/Xogot-Player-Movement.git
   ```

2. Open the project in [Xogot](https://apps.apple.com/us/app/xogot-make-games-anywhere/id6469385251) on iPad or iPhone.

3. Explore the example player scene and movement scripts.

4. Preview the project and test the player movement, rotation, and jumping behavior.

5. Select the player in Remote view and experiment with movement values such as move speed, turn speed, jump height, air speed, fall weight, partial momentum, and jump steering.

6. Review the player script to see how the exported variables control ground movement, air movement, gravity, and jump behavior.

7. Try different values to create different player movement styles, from floaty platforming jumps to heavier, more grounded movement.

## Learn More

[Xogot](https://xogot.com)
[Documentation](https://docs.xogot.com/documentation/xogot/)
[Tutorials](https://docs.xogot.com/tutorials/xogot-tutorials/)

Built with Xogot on iPad
