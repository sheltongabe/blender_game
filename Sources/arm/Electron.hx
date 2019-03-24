package arm;

import iron.Scene;
import kha.math.Random;
import iron.object.Object;
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
	var deltaStrength = 1;
	var electronLight:LightObject;

	/// Index for the next light
	public static var nextIndex:Int = 0;

	/// Index for this Light
	var index:Int = 0;

	public function new() {
		super();

		// Register functions
		notifyOnInit(init);
		notifyOnUpdate(update);
		notifyOnRemove(destroy);
	}

	/// Initialize any properties specific to general electrons
	public function init() {
		// Set the Index for this 
		this.index = Electron.nextIndex;
		Electron.nextIndex++;
		
		// Grab the light
		electronLight = Scene.active.getLight("electronLight_" + index);

		// Set the position 0.25m above the floor
		object.transform.translate(0, 0, .25);
	}

	/// Update the electrons by adjusting their light distance and radius
	public function update() {
		strength += deltaStrength;
		// electronLight.data.raw.strength = strength;

		var dStrength:Float = this.randFloat(-object.properties["D_STRENGTH"], object.properties["D_STRENGTH"]);
		electronLight.data.raw.strength = this.clamp(electronLight.data.raw.strength + dStrength,
				object.properties["MIN_STRENGTH"], 
				object.properties["MAX_STRENGTH"]);

		var dDistance:Float = this.randFloat(-object.properties["D_DISTANCE"], object.properties["D_DISTANCE"]);
		electronLight.data.raw.size = this.clamp(electronLight.data.raw.size + dDistance,
				object.properties["MIN_DISTANCE"], 
				object.properties["MAX_DISTANCE"]);
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

	/// Return a random float in the provided range
	public function randFloat(min:Float, max:Float):Float {
		return min + (Math.random() * (max - min));
	}
}
