# An Uncertain Journey

A game that leverages the Heisenberg Uncertainty Princible as you move through
a dungeon or puzzle like area.

## Mechanics

* As you hold still, a radius that your character can possibly occupy other than the
  spot you seem to be in is 0.
* As you move, the radius that you can occupy will increase as your speed increases.
  radius ~= n(speed)
* Each frame you will occupy a random location in that radius.
* You begin with a pool of health and will take damage each time you are trying to move and
  are in an object.  As well you will not actually move if you are in an object.
* The rendering will not actually show the character changing position rather it will move
  an empty object.
* The dungeon will have tricks, traps, etc.
* The camera on a small probability can rotate by a large amount around the world.