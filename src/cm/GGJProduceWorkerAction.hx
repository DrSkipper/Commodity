package twogames;

class GGJProduceWorkerAction extends GGJGameAction
{
	public var spawnRange:Int;

	public function new(spawnableRange:Int, originTile:GGJHexTile, turn:GGJGameTurn, originObject:GGJGameObject)
	{
		super("+worker $1m", originTile, turn, originObject);
		this.spawnRange = spawnableRange;
	}

	override public function activate():Void
	{
		super.activate();

		_originTile.highlighted = false;
		_neighbors = _originTile.neighbors();
		for (i in 0..._neighbors.length)
		{
			if (_neighbors[i].gameObjects.length == 0)
				_neighbors[i].highlighted = true;
		}
	}

	override public function execute(targetTile:GGJHexTile):Bool
	{
		super.execute(targetTile);

		var validTile:Bool = false;
		for (i in 0..._neighbors.length)
		{
			if (targetTile != null && targetTile == _neighbors[i] && targetTile.gameObjects.length == 0)
				validTile = true;

			_neighbors[i].highlighted = false;
		}

		if ((_originObject.ownedPlayerId == 1 && GGJGlobals.blueEmpireMoney <= 0) ||
			(_originObject.ownedPlayerId == 2 && GGJGlobals.redEmpireMoney <= 0))
			validTile = false;

		if (validTile)
		{
			var worker:GGJWorker = new GGJWorker(_originObject.ownedPlayerId);
			worker.tile = targetTile;
			worker.hasPerformedAction = true;
			_originObject.hasPerformedAction = true;

			if (_originObject.ownedPlayerId == 1)
			{
				--GGJGlobals.blueEmpireMoney;
				++GGJGlobals.currentBlueObjects;
				++GGJGlobals.totalCurrentUnits;
			}
			else if (_originObject.ownedPlayerId == 2)
			{
				--GGJGlobals.redEmpireMoney;
				++GGJGlobals.currentRedObjects;
				++GGJGlobals.totalCurrentUnits;
			}
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
