package arm;

import arm.base.ElectronBase;

import iron.object.LightObject;

/**
 * @class	Electron
 * @brief	Define the characteristics of a basic Electron
 * @details
 * These include adjusting the light distance and radius randomly
 * up and down a small amount each frame.
 */
class Electron extends iron.Trait {
	/// Mechanics for the electron
	var electronMechanics:ElectronBase;

	/// The light that is being used
	var electronLight:LightObject;

	public function new() {
		super();

		// Register functions
		notifyOnInit(init);
		notifyOnUpdate(update);
		notifyOnRemove(destroy);
	}

	/// Initialize any properties specific to general electrons
	public function init() {
		// Connect to ElectonBase for the mechanics
		this.electronMechanics = new ElectronBase(object);
		electronMechanics.init();
	}

	/// Update the electrons by adjusting their light distance and radius
	public function update() {
		electronMechanics.update();
	}

	/// Do Any removal tasks
	public function destroy() {
		// nought
	}
}
