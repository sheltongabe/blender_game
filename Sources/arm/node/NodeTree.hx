package arm.node;

@:keep class NodeTree extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _SetLightStrength = new armory.logicnode.SetLightStrengthNode(this);
		_SetLightStrength.addInput(new armory.logicnode.NullNode(this), 0);
		_SetLightStrength.addInput(new armory.logicnode.ObjectNode(this, ""), 0);
		_SetLightStrength.addInput(new armory.logicnode.FloatNode(this, 100.0), 0);
		_SetLightStrength.addOutputs([new armory.logicnode.NullNode(this)]);
	}
}