package arm;

import iron.system.Input;
import iron.math.Vec4;
import armory.trait.physics.PhysicsWorld;
import armory.trait.physics.RigidBody;

/**
 * @file 	PlayerMovement.hx
 * @brief	A trait that controls an object with the wasd keys using physics.
 * @details
 * 1. The object you attatch this to needs to be an active rigid body.
 * 2. Any forward or backward motions will be force vectors that will be applied on the local y-axis (look).
 * 3. rotations (a or d) will be rotations around the z-axis.
 * 4. The Speed of rotation and value that scales the acceleration are the first two properties.
 */

class PlayerMovement extends iron.Trait {

#if(!arm_physics)
	public function new() { 
		super(); 
	}
#else
	/// The rotation speed, read from properties
	var rotation_speed = 0.0;

	/// Scalar for the forward acceleration
	var ACCELERATION_SCALAR = 8.0;

	/// Should the player accelerate forward
	var forward:Bool = false;

	/// Should the player accelerate backward
	var backward:Bool = false;

	/// Should the player rotate counterclockwise
	var rotateCounterClockwise:Bool = false;

	/// Should the player rotate clockwise
	var rotateClockwise:Bool = false;

	/// Player body
	var body:RigidBody;

	/// Player Direction
	var direction:Vec4 = new Vec4();

	public function new() {
		super();
		notifyOnInit(init);
	}

	/// Run when the script first begins
	public function init() {
		body = object.getTrait(RigidBody);
		notifyOnUpdate(update);
		notifyOnRemove(removed);
		PhysicsWorld.active.notifyOnPreUpdate(preUpdate);
	}

	/// Physics pre update
	public function preUpdate() {
		// If we are not ready to go
		if(Input.occupied || !body.ready)
			return;
		
		// Update rotation speed
		rotation_speed = object.properties["rotation_speed"];
		
		// update booleans for if the player should move
		var keyboard = Input.getKeyboard();
		forward = keyboard.down('w');
		backward = keyboard.down('s');
		rotateCounterClockwise = keyboard.down('a');
		rotateClockwise = keyboard.down('d');
	}
	
	/// Run each frame moving the attatched player based on pressed keys
	public function update() {
		if(!body.ready)
			return;

		// Reset the direction and update it based on buttons
		direction.set(0, 0, 0);
		if(forward)
			direction.add(object.transform.look());

		if(backward)
			direction.add(object.transform.look().mult(-1));

		if(rotateCounterClockwise)
			object.transform.rotate(Vec4.zAxis(), rotation_speed);

		if(rotateClockwise)
			object.transform.rotate(Vec4.zAxis(), -rotation_speed);

		// Apply the transformations
		if(forward || backward) {
			direction.mult(ACCELERATION_SCALAR);
			body.activate();
			body.applyForce(direction);
		}

		if(rotateCounterClockwise || rotateClockwise) {
			body.syncTransform();
		}

		// Keep Vertical
		body.setAngularFactor(0, 0, 0);
	}

	/// When the Object is removed
	public function removed() {
		PhysicsWorld.active.removePreUpdate(preUpdate);
	}
#end
}
