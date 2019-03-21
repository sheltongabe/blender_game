package arm;

import kha.math.Random;
import iron.object.LightObject;

/**
 * @class	Electron
 * @brief	Define the characteristics of a basic Electron
 * @details
 * These include adjusting the light distance and radius randomly
 * up and down a small amount each frame.
 */
class Electron extends iron.Trait {

	var strength = 0.0;
	var deltaStrength = 0.1;

	public function new() {
		super();

		// Register functions
		notifyOnInit(init);
		notifyOnUpdate(update);
		notifyOnRemove(destroy);
	}

	/// Initialize any properties specific to general electrons
	public function init() {

	}

	/// Update the electrons by adjusting their light distance and radius
	public function update() {
		strength += deltaStrength;
		(object).data.raw.strength = strength;
		//var deltaDistance:Float = 
	}

	/// Do Any removal tasks
	public function destroy() {
		// nought
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
