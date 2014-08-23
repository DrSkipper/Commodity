package twogames;

import flash.geom.Point;
import com.haxepunk.*;
import com.haxepunk.utils.*;
import com.haxepunk.graphics.*;
import extendedhxpunk.ext.*;
import extendedhxpunk.ui.*;
import twogames.ui.*;

class GGJGameplayScene extends EXTScene
{
	public var grid:GGJGrid;

	public function new()
	{
		super();

		GGJGlobals.blueEmpireMoney = 0;
		GGJGlobals.redEmpireMoney = 0;
		GGJGlobals.totalCurrentUnits = 0;
		GGJGlobals.totalOrganizedUnits = 0;
		GGJGlobals.currentRedObjects = 0;
		GGJGlobals.currentBlueObjects = 0;
	}

	override public function begin():Void
	{
		super.begin();

		// HUD
		_hudView = new JVHudView(this.worldCamera);
		_itemView = new GGJGridSpaceItemsView();
		var endTurnButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(30, -30), "end turn", endTurn, new Array());
		endTurnButton.offsetAlignmentInParent = EXTOffsetType.BOTTOM_LEFT;
		endTurnButton.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_LEFT;

		_currentPlayerText = new Text("blue empire", 0, 0, { "size" : 20, "color" : 0x101010 });
		var currentPlayerLabel:UILabel = new UILabel(new Point(0, -10), _currentPlayerText);
		currentPlayerLabel.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		currentPlayerLabel.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_CENTER;
		endTurnButton.addSubview(currentPlayerLabel);

		_blueEmpireMoneyText = new Text("blue's bank: $" + GGJGlobals.blueEmpireMoney + " mil", 0, 0, { "size" : 20, "color" : 0x101010 });
		var blueMoneyLabel:UILabel = new UILabel(new Point(-20, 20), _blueEmpireMoneyText);
		blueMoneyLabel.offsetAlignmentInParent = EXTOffsetType.TOP_RIGHT;
		blueMoneyLabel.offsetAlignmentForSelf = EXTOffsetType.TOP_RIGHT;
		_hudView.addSubview(blueMoneyLabel);

		_redEmpireMoneyText = new Text("red's bank: $" + GGJGlobals.redEmpireMoney + " mil", 0, 0, { "size" : 20, "color" : 0x101010 });
		var redMoneyLabel:UILabel = new UILabel(new Point(0, 10), _redEmpireMoneyText);
		redMoneyLabel.offsetAlignmentInParent = EXTOffsetType.BOTTOM_CENTER;
		redMoneyLabel.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		blueMoneyLabel.addSubview(redMoneyLabel);

		_hudView.addSubview(endTurnButton);
		_hudView.addSubview(_itemView);
		this.staticUiController.rootView.addSubview(_hudView);

		// Debug labels
		_totalCurrentUnitsText = new Text("Total Units: " + GGJGlobals.totalCurrentUnits, 0, 0, { "size" : 20, "color" : 0x101010 });
		var totalCurrentUnitsLabel = new UILabel(new Point(20, 50), _totalCurrentUnitsText);
		totalCurrentUnitsLabel.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
		totalCurrentUnitsLabel.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;

		_totalOrganizedUnitsText = new Text("Organized Units: " + GGJGlobals.totalOrganizedUnits, 0, 0, { "size" : 20, "color" : 0x101010 });
		var totalOrganizedUnitsLabel = new UILabel(new Point(0, 10), _totalOrganizedUnitsText);
		totalOrganizedUnitsLabel.offsetAlignmentInParent = EXTOffsetType.BOTTOM_CENTER;
		totalOrganizedUnitsLabel.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		totalCurrentUnitsLabel.addSubview(totalOrganizedUnitsLabel);

		_currentBlueObjectsText = new Text("Blue Objects: " + GGJGlobals.currentBlueObjects, 0, 0, { "size" : 20, "color" : 0x101010 });
		var currentBlueObjectsLabel = new UILabel(new Point(0, 10), _currentBlueObjectsText);
		currentBlueObjectsLabel.offsetAlignmentInParent = EXTOffsetType.BOTTOM_CENTER;
		currentBlueObjectsLabel.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		totalOrganizedUnitsLabel.addSubview(currentBlueObjectsLabel);

		_currentRedObjectsText = new Text("Red Objects: " + GGJGlobals.currentRedObjects, 0, 0, { "size" : 20, "color" : 0x101010 });
		var currentRedObjectsLabel = new UILabel(new Point(0, 10), _currentRedObjectsText);
		currentRedObjectsLabel.offsetAlignmentInParent = EXTOffsetType.BOTTOM_CENTER;
		currentRedObjectsLabel.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		currentBlueObjectsLabel.addSubview(currentRedObjectsLabel);

		#if debug
		_hudView.addSubview(totalCurrentUnitsLabel);
		#end

		// Turn
		_currentTurn = new GGJImperialistTurn(1, _itemView);
		_currentPlayerId = 1;

		// Tiles
		this.grid = new GGJGrid();
		var buildingA:GGJBuilding = new GGJBuilding(1);
		buildingA.tile = this.grid.tilecolumns[2][2];
		++GGJGlobals.currentBlueObjects;

		var buildingB:GGJBuilding = new GGJBuilding(2);
		var secondBuildingColumn:Array<GGJHexTile> = this.grid.tilecolumns[GGJConstants.HEX_GRID_COLUMNS - 3];
		buildingB.tile = secondBuildingColumn[secondBuildingColumn.length - 3];
		++GGJGlobals.currentRedObjects;

		// Resources
		var resource:GGJResources = new GGJResources(0);
		resource.tile = this.grid.tilecolumns[0][0];

		var neighbors:Array<GGJHexTile> = resource.tile.neighbors();
		for (i in 0...neighbors.length - 1)
		{
			resource = new GGJResources(0);
			resource.tile = neighbors[i];
		}

		resource = new GGJResources(0);
		resource.tile = this.grid.tilecolumns[GGJConstants.MIDDLE_COLUMN_INDEX][0];

		neighbors = resource.tile.neighbors();
		for (i in 1...neighbors.length)
		{
			resource = new GGJResources(0);
			resource.tile = neighbors[i];
		}

		resource = new GGJResources(0);
		resource.tile = this.grid.tilecolumns[0][this.grid.tilecolumns[0].length - 1];

		neighbors = resource.tile.neighbors();
		for (i in 0...neighbors.length)
		{
			if (i == 1)
				continue;
			resource = new GGJResources(0);
			resource.tile = neighbors[i];
		}

		resource = new GGJResources(0);
		resource.tile = this.grid.tilecolumns[GGJConstants.MIDDLE_COLUMN_INDEX][GGJConstants.MIDDLE_COLUMN_INDEX * 2];

		neighbors = resource.tile.neighbors();
		for (i in 1...neighbors.length)
		{
			resource = new GGJResources(0);
			resource.tile = neighbors[i];
		}

		resource = new GGJResources(0);
		resource.tile = this.grid.tilecolumns[GGJConstants.HEX_GRID_COLUMNS - 1][0];

		neighbors = resource.tile.neighbors();
		for (i in 0...neighbors.length - 1)
		{
			resource = new GGJResources(0);
			resource.tile = neighbors[i];
		}

		resource = new GGJResources(0);
		resource.tile = this.grid.tilecolumns[GGJConstants.HEX_GRID_COLUMNS - 1][this.grid.tilecolumns[GGJConstants.HEX_GRID_COLUMNS - 1].length - 1];

		neighbors = resource.tile.neighbors();
		for (i in 0...neighbors.length)
		{
			if (i == 1)
				continue;
			resource = new GGJResources(0);
			resource.tile = neighbors[i];
		}

		resource = new GGJResources(0);
		resource.tile = this.grid.tilecolumns[GGJConstants.MIDDLE_COLUMN_INDEX][GGJConstants.MIDDLE_COLUMN_INDEX];

		neighbors = resource.tile.neighbors();
		for (i in 0...neighbors.length)
		{
			if (i == 0 || i == 1 || i == 2 || i == 5)
				continue;
			resource = new GGJResources(0);
			resource.tile = neighbors[i];
		}

		// Initial workers
		var initialWorkers:Array<GGJWorker> = new Array();
		neighbors = buildingA.tile.neighbors();
		for (i in 0...neighbors.length)
		{
			if (i != 0 && i != 3)
				continue;
			var worker:GGJWorker = new GGJWorker(1);
			worker.tile = neighbors[i];
			initialWorkers.push(worker);
			++GGJGlobals.currentBlueObjects;
			++GGJGlobals.totalCurrentUnits;
		}

		neighbors = buildingB.tile.neighbors();
		for (i in 0...neighbors.length)
		{
			if (i != 1 && i != 4)
				continue;
			var worker:GGJWorker = new GGJWorker(2);
			worker.tile = neighbors[i];
			initialWorkers.push(worker);
			++GGJGlobals.currentRedObjects;
			++GGJGlobals.totalCurrentUnits;
		}

		// One worker begins organized
		initialWorkers[Std.random(initialWorkers.length)].organized = true;
		++GGJGlobals.totalOrganizedUnits;
	}

	override public function update():Void
	{
		super.update();

		_blueEmpireMoneyText.text = "blue's bank: $" + GGJGlobals.blueEmpireMoney + " mil";
		_redEmpireMoneyText.text = "red's bank: $" + GGJGlobals.redEmpireMoney + " mil";
		_totalCurrentUnitsText.text = "Total Units: " + GGJGlobals.totalCurrentUnits;
		_totalOrganizedUnitsText.text = "Organized Units: " + GGJGlobals.totalOrganizedUnits;
		_currentBlueObjectsText.text = "Blue Objects: " + GGJGlobals.currentBlueObjects;
		_currentRedObjectsText.text = "Red Objects: " + GGJGlobals.currentRedObjects;

		if (!_gameEnded)
		{
			if (GGJGlobals.totalOrganizedUnits == GGJGlobals.totalCurrentUnits)
			{
				_hudView.removeAllSubviews();
				_hudView.addSubview(new GGJVictoryView(3));
				_gameEnded = true;
			}
			else if (GGJGlobals.currentBlueObjects <= 0)
			{
				_hudView.removeAllSubviews();
				_hudView.addSubview(new GGJVictoryView(2));
				_gameEnded = true;
			}
			else if (GGJGlobals.currentRedObjects <= 0)
			{
				_hudView.removeAllSubviews();
				_hudView.addSubview(new GGJVictoryView(1));
				_gameEnded = true;
			}

			if (Input.mousePressed && !this.ignoreWorldClick())
			{
				var clickedTile:GGJHexTile = cast this.topMostCollidePoint("grid_space", Input.mouseX, Input.mouseY);
				_currentTurn.handleTileClick(clickedTile);
			}
		}
	}

	public function ignoreWorldClick():Bool
	{
		var views:Array<UIView> = _hudView.copyOfSubviews();
		for (i in 0...views.length)
		{
			if (views[i].mouseIsOverViewOrSubviews)
				return true;
		}
		return false;
	}

	public function endTurn(args:Array<Dynamic>):Void
	{
		++_currentPlayerId;
		if (_currentPlayerId > 3)
			_currentPlayerId = 1;

		if (_currentPlayerId == 1)
		{
			_currentTurn = new GGJImperialistTurn(_currentPlayerId, _itemView);
			_currentPlayerText.text = "blue empire";
		}
		else if (_currentPlayerId == 2)
		{
			_currentTurn = new GGJImperialistTurn(_currentPlayerId, _itemView);
			_currentPlayerText.text = "red empire";
		}
		else if (_currentPlayerId == 3)
		{
			_currentTurn = new GGJWorkersTurn(_currentPlayerId, _itemView);
			_currentPlayerText.text = "workers";
		}

		for (i in 0...this.grid.tilecolumns.length)
		{
			for (j in 0...this.grid.tilecolumns[i].length)
			{
				var tile:GGJHexTile = this.grid.tilecolumns[i][j];
				tile.highlighted = false;

				for (g in 0...tile.gameObjects.length)
					tile.gameObjects[g].hasPerformedAction = false;
			}
		}
	}

	/**
	 * Private
	 */
	private var _hudView:JVHudView;
	private var _itemView:GGJGridSpaceItemsView;
	private var _currentTurn:GGJGameTurn;
	private var _currentPlayerId:Int;
	private var _currentPlayerText:Text;
	private var _blueEmpireMoneyText:Text;
	private var _redEmpireMoneyText:Text;
	private var _totalCurrentUnitsText:Text;
	private var _totalOrganizedUnitsText:Text;
	private var _currentBlueObjectsText:Text;
	private var _currentRedObjectsText:Text;
	private var _gameEnded:Bool;
}
