package arm.base;

import arm.base.ArmoryRandom;

import iron.Scene;
import iron.object.Object;
import iron.object.LightObject;

/**
 * @class	ElectronBase
 * @brief	Define the flickering characteristic of a basic electron
 * @details
 * These include adjusting the light distance and radius randomly
 * up and down a small amount each frame.
 */
class ElectronBase {
	/// The Electron
	var electron:Object;

	/// The light that is being used
	var electronLight:LightObject;

	public function new(electron:Object) {
		// Register Electron
		this.electron = electron;
	}

	/// Initialize any properties specific to general electrons
	public function init() {
		// Grab the light
		electronLight = Scene.active.getLight("electronLight_" + electron.properties["ID_NUMBER"]);

		// Set the position 0.25m above the floor
		electron.transform.translate(0, 0, .25);
	}

	/// Update the electrons by adjusting their light distance and radius
	public function update() {
		// Update the light strength
		
		var dStrength:Float = ArmoryRandom.randFloat(-electron.properties["D_STRENGTH"], electron.properties["D_STRENGTH"]);
		electronLight.data.raw.strength = this.clamp(electronLight.data.raw.strength + dStrength,
				electron.properties["MIN_STRENGTH"], 
				electron.properties["MAX_STRENGTH"]);

		// Update the light distance
		var dDistance:Float = ArmoryRandom.randFloat(-electron.properties["D_DISTANCE"], electron.properties["D_DISTANCE"]);
		electronLight.data.raw.size = this.clamp(electronLight.data.raw.size + dDistance,
				electron.properties["MIN_DISTANCE"], 
				electron.properties["MAX_DISTANCE"]);
	}

	/// Clamp the value between min and max and return
	public function clamp(value:Float, min:Float, max:Float) {
		if(value > max) {
			value = max;
		}
		else if(value < min) {
			value = min;
		}
		return value;
	}
}