package twogames;

class GGJAttackAction extends GGJGameAction
{
	public var attackRange:Int;

	public function new(attackableRange:Int, originTile:GGJHexTile, turn:GGJGameTurn, originObject:GGJGameObject)
	{
		super("attack", originTile, turn, originObject);
		this.attackRange = attackableRange;
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
				// if (gameObject.ownedPlayerId != _originObject.ownedPlayerId)
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
				// if (gameObject.ownedPlayerId != _originObject.ownedPlayerId)
					validTile = true;
			}

			_neighbors[i].highlighted = false;
		}

		if (validTile)
		{
			_originObject.tile = gameObject.tile;
			gameObject.tile = null;
			_originObject.hasPerformedAction = true;
			if (gameObject.ownedPlayerId == 1)
			{
				--GGJGlobals.currentBlueObjects;

				if (!(Std.is(gameObject, GGJBuilding)))
					--GGJGlobals.totalCurrentUnits;
			}
			else if (gameObject.ownedPlayerId == 2)
			{
				--GGJGlobals.currentRedObjects;

				if (!(Std.is(gameObject, GGJBuilding)))
					--GGJGlobals.totalCurrentUnits;
			}

			if (gameObject.organized)
				--GGJGlobals.totalOrganizedUnits;
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
