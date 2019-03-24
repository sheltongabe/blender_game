package arm.base;

/**
 * @class	ArmoryRandom
 * @brief	Handle random numbers correctly in Armory, use this rather than kha.math.Random
 */
class ArmoryRandom {

	/// Initialize the class
	public function new() {

	}

	/// Return a random float in the provided range
	public static function randFloat(min:Float, max:Float):Float {
		return min + (Math.random() * (max - min));
	}
}