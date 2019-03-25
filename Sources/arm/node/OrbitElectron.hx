package arm.node;

@:keep class OrbitElectron extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _ApplyForce = new armory.logicnode.ApplyForceNode(this);
		var _OnInit = new armory.logicnode.OnInitNode(this);
		_OnInit.addOutputs([_ApplyForce]);
		_ApplyForce.addInput(_OnInit, 0);
		_ApplyForce.addInput(new armory.logicnode.ObjectNode(this, "Electron_2"), 0);
		_ApplyForce.addInput(new armory.logicnode.VectorNode(this, 1.0, 1.0, 0.0), 0);
		_ApplyForce.addOutputs([new armory.logicnode.NullNode(this)]);
	}
}