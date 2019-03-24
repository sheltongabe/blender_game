package arm.base;



import iron.system.Input;
/**
 * @class 	PlayerControl
 * @brief	Maintain a database of the controls and have and API to query
 */
class PlayerControl {
	/// Initialize an instance (never used)
	public function new() { }

	/// Map of controls
	static var keyboardControls:Map<String, String> = [
		"forward" => "w",
		"backward" => "s",
		"left" => "a",
		"right" => "d"
	];

	/// Return if the forward control is active
	public static function isForward() {
		return Input.getKeyboard().down(PlayerControl.keyboardControls["forward"]);
	}

	/// Return if the backward control is active
	public static function isBackward() {
		return Input.getKeyboard().down(PlayerControl.keyboardControls["backward"]);
	}

	/// Return if the left control is active
	public static function isLeft() {
		return Input.getKeyboard().down(PlayerControl.keyboardControls["left"]);
	}

	/// Return if the right control is active
	public static function isRight() {
		return Input.getKeyboard().down(PlayerControl.keyboardControls["right"]);
	}
}
