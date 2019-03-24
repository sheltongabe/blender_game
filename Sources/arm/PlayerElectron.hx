package arm;

import arm.Electron;
import iron.math.Vec4;

/**
 * @class 	PlayerElectron
 * @brief	Extend Electron and allow wasd movement 
 */
class PlayerElectron extends Electron {
	/// Player Velocity
	var velocity:Vec4;

	/// Register Startup Functions
	public function new() {
		super();

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
	}
	
	/// Remove PlayerElectron
	public override function remove() {
		super.remove();
	}
}
