package arm;

import iron.math.Vec4;
import arm.Electron;

/**
 * @class 	OrbitElectron
 * @brief	Handle the orbital movement of an electron around a central axis
 */
class OrbitElectron extends Electron {
	/// The angle that the electron is currently at from 0, in radians
	var phi:Float;

	/// The max angle before it resets to 0
	var MAX_RADIANS:Float = 2 * Math.PI;

	public function new() {
		super();

		// Register Functions
		notifyOnInit(init);
		notifyOnUpdate(update);
		notifyOnRemove(remove);

		this.phi = 0.0;
	}

	/// Initialize the OrbitElectron
	public override function init() {
		super.init();

		var cartesian:Vec4 = this.getCartesian();
		this.move(cartesian.x, cartesian.y, cartesian.z);
	}

	/// Move the electron around the central axis with polar coordinates
	public override function update() {
		super.update();

		// Grab angular velocity and update phi
		var angularVelocity:Float = object.properties["ANGULAR_VELOCITY"];
		this.phi += angularVelocity;
		if(this.phi >= this.MAX_RADIANS)
			this.phi = 0.0;

		// Move the electron
		var cartesian:Vec4 = this.getCartesian();
		this.move(cartesian.x, cartesian.y, cartesian.z);
	}

	/// Remove the OrbitElectron
	public override function remove() {
		super.remove();
	}

	/// Convert the polar cooardinates to cartesian and return
	public function getCartesian():Vec4 {	
		var radius:Float = object.properties["ORBIT_RADIUS"];
		var x:Float = radius * Math.cos(this.phi) - (radius / 2);
		var y:Float = radius * Math.sin(this.phi);
		var z:Float = object.transform.loc.z;

		return new Vec4(x, y, z);
	}
}
