package twogames;

class GGJGameAction
{
	public var name:String;
	
	public function new(actionName:String, originTile:GGJHexTile, turn:GGJGameTurn, originObject:GGJGameObject)
	{
		this.name = actionName;
		_originTile = originTile;
		_originObject = originObject;
		_turn = turn;
	}

	public function activate():Void
	{
		_turn.currentAction = this;
	}

	public function execute(targetTile:GGJHexTile):Bool
	{
		return false;
	}

	/**
	 * Private
	 */
	private var _originTile:GGJHexTile;
	private var _originObject:GGJGameObject;
	private var _turn:GGJGameTurn;
}
