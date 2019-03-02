package arm;
import armory.trait.physics.RigidBody;
import kha.audio2.ogg.vorbis.data.Page;
import iron.system.Input;
import iron.object.Object;
import iron.math.Vec4;
import armory.trait.physics.PhysicsWorld;
import armory.trait.physics.RigidBody;


class PlayerMovement extends iron.Trait {

#if(!arm_physics)
	public function new() { 
		super(); 
	}
#else
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

	/// The rotation speed
	var ROTATION_SPEED = .080;

	/// Scalar for the forward acceleration
	var ACCELERATION_SCALAR = 8;

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
			object.transform.rotate(Vec4.zAxis(), ROTATION_SPEED);

		if(rotateClockwise)
			object.transform.rotate(Vec4.zAxis(), -ROTATION_SPEED);

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
