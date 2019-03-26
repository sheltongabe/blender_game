package arm;

import arm.Electron;
import arm.base.PlayerControl;

import iron.math.Vec4;
import armory.trait.physics.RigidBody;

/**
 * @class 	PlayerElectron
 * @brief	Extend Electron and allow wasd movement 
 */
class PlayerElectron extends Electron {
	/// Epsilon for Float comparison
	static var EPSILON:Float = .0005;

	/// Player Velocity
	var velocity:Vec4;

	/// Player Acceleration
	var acceleration:Vec4;

	/// Register Startup Functions
	public function new() {
		super();

		// Initialize Velocity and Accleration
		this.velocity = new Vec4(0, 0, 0);
		this.acceleration = new Vec4(0, 0, 0);

		// Register functions
		notifyOnInit(init);
		notifyOnUpdate(update);
		notifyOnRemove(remove);
	}

	/// Prepare PlayerElectron to function
	public override function init() {
		super.init();
	}

	/// Move PlayerElectron based on controls
	public override function update() {
		super.update();

		// Add new acceleration
		var jerk:Float = object.properties["ACCELERATION"];
		if(PlayerControl.isForward())
			acceleration.y += jerk;
		if(PlayerControl.isBackward())
			acceleration.y -= jerk;
		if(PlayerControl.isLeft())
			acceleration.x -= jerk;
		if(PlayerControl.isRight())
			acceleration.x += jerk;

		// Apply Friction if it is not almost equal to zero
		// If it is almost equal set the acceleration and velocity to 0
		var friction:Float = object.properties["FRICTION"];
		this.handleFriction(this.acceleration, this.velocity, friction);

		// Add to velocity
		var maxSpeed:Float = object.properties["MAX_SPEED"];
		velocity.x += acceleration.x;
		velocity.y += acceleration.y;
		velocity.clamp(-maxSpeed, maxSpeed);

		// If the clamp is in place reset acceleration
		if(floatEqual(velocity.x, maxSpeed))
			acceleration.x = 0;
		if(floatEqual(velocity.y, maxSpeed))
			acceleration.y = 0;

		// Move the position and the children
		object.transform.loc.add(velocity);
		for(child in object.children) {
			child.transform.loc.add(velocity);
			// Sync Matrices
			var body:RigidBody = child.getTrait(RigidBody);
			child.transform.buildMatrix();
			if(body != null)
				body.syncTransform();
		}
	}
	
	/// Remove PlayerElectron
	public override function remove() {
		super.remove();
	}

	/// Handle the friction
	public function handleFriction(accel:Vec4, vel:Vec4, friction:Float) {
		// Handle friction on each component
		accel.x -= (accel.x >= 0) ? friction : -friction;
		accel.y -= (accel.y >= 0) ? friction : -friction;
		accel.z -= (accel.z >= 0) ? friction : -friction;

		// If we are close enough to 0 that another application
		// will take us past set acceleration and velocity to 0.
		if(Math.abs(accel.x) <= friction) {
			accel.x = 0;
			vel.x = 0;
		}
		if(Math.abs(accel.y) <= friction) {
			accel.y = 0;
			vel.y = 0;
		}
		if(Math.abs(accel.z) <= friction) {
			accel.z = 0;
			vel.z = 0;
		}
	}

	/// Return a copy of the velocity
	public function getVelocity():Vec4 {
		return this.velocity.clone();
	}

	/// Compare two floats for equality
	public static function floatEqual(a:Float, b:Float):Bool {
		var pos:Bool = Math.abs(a - b) < EPSILON;
		var neg:Bool = Math.abs(a + b) < EPSILON;
		return pos || neg;
	}
}
