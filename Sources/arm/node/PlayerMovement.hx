package arm.node;

@:keep class PlayerMovement extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _OnKeyboard_003 = new armory.logicnode.OnKeyboardNode(this);
		_OnKeyboard_003.property0 = "Down";
		_OnKeyboard_003.property1 = "w";
		_OnKeyboard_003.addOutputs([new armory.logicnode.NullNode(this)]);
		var _OnKeyboard_001 = new armory.logicnode.OnKeyboardNode(this);
		_OnKeyboard_001.property0 = "Down";
		_OnKeyboard_001.property1 = "s";
		_OnKeyboard_001.addOutputs([new armory.logicnode.NullNode(this)]);
		var _OnKeyboard_002 = new armory.logicnode.OnKeyboardNode(this);
		_OnKeyboard_002.property0 = "Down";
		_OnKeyboard_002.property1 = "w";
		_OnKeyboard_002.addOutputs([new armory.logicnode.NullNode(this)]);
	}
}