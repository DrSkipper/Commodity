package twogames;

class GGJOrganizeAction extends GGJGameAction
{
	public var talkRange:Int;

	public function new(talkableRange:Int, originTile:GGJHexTile, turn:GGJGameTurn, originObject:GGJGameObject)
	{
		super("organize", originTile, turn, originObject);
		this.talkRange = talkableRange;
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
				if (!gameObject.organized && gameObject.organizable)
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
				if (!gameObject.organized && gameObject.organizable)
					validTile = true;
			}

			_neighbors[i].highlighted = false;
		}

		if (validTile)
		{
			gameObject.organized = true;
			gameObject.hasPerformedAction = true;
			_originObject.hasPerformedAction = true;
			++GGJGlobals.totalOrganizedUnits;
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
