package twogames;

import twogames.ui.*;

class GGJGameTurn
{
	public var selectedTile(default, set):GGJHexTile;
	public var currentAction:GGJGameAction;
	public var playerId:Int;

	public function new(playerId_:Int, itemView:GGJGridSpaceItemsView)
	{
		_itemView = itemView;
		this.playerId = playerId_;
	}

	public function handleTileClick(tile:GGJHexTile):Void
	{
		if (this.selectedTile == null)
			this.selectedTile = tile;
		else
		{
			if (this.currentAction != null)
			{
				var actionResult:Bool = this.currentAction.execute(tile);

				_itemView.enableButtons();
				if (actionResult)
					this.selectedTile = null;

				this.currentAction = null;
			}
			else
			{
				this.selectedTile = null;
			}
		}
	}

	public function actionsForTile(tile:GGJHexTile):Array<GGJGameAction>
	{
		return new Array();
	}

	public function set_selectedTile(tile:GGJHexTile):GGJHexTile
	{
		if (selectedTile != null)
			selectedTile.highlighted = false;
		if (tile != null)
		{
			tile.highlighted = true;

			var organizer:Bool = false;
			if (this.playerId == 3 && tile.gameObjects.length > 0 && tile.gameObjects[0].organized)
				organizer = true;

			_itemView.updateForGameActions(this.actionsForTile(tile), organizer);
			_itemView.enableButtons();
		}
		else
		{
			_itemView.updateForGameActions(null, false);
		}
		return selectedTile = tile;
	}

	/**
	 * Private
	 */
	private var _itemView:GGJGridSpaceItemsView;
}
