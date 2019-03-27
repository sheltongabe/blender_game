package arm;

import js.Function;
import armory.trait.physics.PhysicsWorld;
import arm.PlayerElectron;

import iron.math.Vec4;
import armory.trait.physics.RigidBody;

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

		this.updateGluonStrength();
	}

	/// Handle collisions with the walls
	public function updateGluonStrength() {
		var physics:PhysicsWorld = PhysicsWorld.active;
		var sphereBody:RigidBody = object.getTrait(RigidBody);
		if(!sphereBody.ready) return;

		// Get the objects in contact with you
		var contacts:Array<RigidBody> = physics.getContacts(sphereBody);
		if(contacts == null)
			return;
		
		// For each contact lower from the Gluon Field Strength
		for(contact in contacts) {
			if(contact.object.name.split('.')[0] == "Wall-Template") {
				object.parent.properties["gluonFieldStrength"] -= object.properties["DAMAGE"];
			}
			else 
				trace(contact.object.name.substr(0, 13));
		}
	}

	/// Any removal tasks
	public function destroy() {
		// Nought
	}
}
