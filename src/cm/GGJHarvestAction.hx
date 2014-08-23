package twogames;

class GGJHarvestAction extends GGJGameAction
{
	public var harvestRange:Int;

	public function new(harvestableRange:Int, originTile:GGJHexTile, turn:GGJGameTurn, originObject:GGJGameObject)
	{
		super("harvest", originTile, turn, originObject);
		this.harvestRange = harvestableRange;
	}

	override public function activate():Void
	{
		super.activate();

		_originTile.highlighted = false;
		_neighbors = _originTile.neighbors();
		for (i in 0..._neighbors.length)
		{
			if (_neighbors[i].gameObjects.length > 0)
			{
				var gameObject:GGJGameObject = _neighbors[i].gameObjects[0];
				if (gameObject.ownedPlayerId == 0)
					_neighbors[i].highlighted = true;
			}
		}
	}

	override public function execute(targetTile:GGJHexTile):Bool
	{
		super.execute(targetTile);

		var gameObject:GGJGameObject = null;
		var validTile:Bool = false;

		for (i in 0..._neighbors.length)
		{
			if (targetTile != null && targetTile == _neighbors[i] && targetTile.gameObjects.length > 0)
			{
				gameObject = targetTile.gameObjects[0];
				if (gameObject.ownedPlayerId == 0)
					validTile = true;
			}

			_neighbors[i].highlighted = false;
		}

		if (validTile)
		{
			gameObject.tile = null;
			_originObject.hasPerformedAction = true;
			
			if (_originObject.ownedPlayerId == 1)
				++GGJGlobals.blueEmpireMoney;
			else if (_originObject.ownedPlayerId == 2)
				++GGJGlobals.redEmpireMoney;
		}
		else
			_originTile.highlighted = true;

		return validTile;
	}

	/**
	 * Private
	 */
	private var _neighbors:Array<GGJHexTile>;
}
