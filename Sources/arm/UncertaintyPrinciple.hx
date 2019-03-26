package arm;

import arm.PlayerElectron;

import iron.math.Vec4;

/**
 * @class	UncertaintyPrinciple
 * @brief	Adjust the radius of the attatched sphere based on the velocity of the parent
 */
class UncertaintyPrinciple extends iron.Trait {
	public function new() {
		super();

		notifyOnInit(init);
		notifyOnUpdate(update);
		notifyOnRemove(destroy);
	}

	/// Connect to the parent upon initialization
	public function init() {
		
	}

	/// Update the scale based on the parent velocity
	public function update() {
		// Grab properties and calculate the ratio factor (rho)
		var minRadius:Float = object.properties["MIN_RADIUS"];
		var maxRadius:Float = object.properties["MAX_RADIUS"];
		var maxSpeed:Float = object.parent.properties["MAX_SPEED"];
		var rho:Float = (maxRadius - minRadius) / maxSpeed;

		// Calculate radius based on velocity
		var velocity:Vec4 = object.parent.getTrait(PlayerElectron).getVelocity();
		var speed:Float = Math.abs(velocity.length() / 2);
		var diameter:Float = 2 * (rho * speed + minRadius);

		// Update the scale of the sphere accordingly
		object.transform.scale = new Vec4(diameter, diameter, diameter);
	}

	/// Any removal tasks
	public function destroy() {
		// Nought
	}
}
