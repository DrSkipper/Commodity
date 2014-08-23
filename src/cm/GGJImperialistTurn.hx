package twogames;

import twogames.ui.*;

class GGJImperialistTurn extends GGJGameTurn
{
	public function new(playerId_:Int, itemView:GGJGridSpaceItemsView)
	{
		super(playerId_, itemView);
	}

	override public function actionsForTile(tile:GGJHexTile):Array<GGJGameAction>
	{
		var retVal:Array<GGJGameAction> = new Array();

		for (i in 0...tile.gameObjects.length)
		{
			var gameObject:GGJGameObject = tile.gameObjects[i];
			if (gameObject.ownedPlayerId == this.playerId)
				retVal = retVal.concat(tile.gameObjects[i].gameActionsForImperialistTurn(this));
		}

		return retVal;
	}
}
