package twogames;

import flash.geom.Point;
import com.haxepunk.*;
import com.haxepunk.graphics.*;
import com.haxepunk.masks.*;
import twogames.*;

class GGJHexTile extends Entity
{
	public var gridLocation:Point;
	public var highlighted(default, set):Bool;
	public var gameObjects:Array<GGJGameObject>;

	public function new(gridX:Int, gridY:Int, grid:GGJGrid)
	{
		var screenCenterX:Int = cast (HXP.screen.width / 2);
		var screenCenterY:Int = cast (HXP.screen.height / 2);

		var distanceFromCenterX:Int = cast (gridX - GGJConstants.MIDDLE_COLUMN_INDEX);
		var distanceFromCenterY:Int = cast (gridY - GGJConstants.MIDDLE_COLUMN_INDEX);
		var yOffset:Int = cast (Math.abs(distanceFromCenterX) * (GGJConstants.GRID_SPACE_HEIGHT * 0.5));

		_grid = grid;
		_brownImage = new Image("gfx/hex_brown.png");
		_greenImage = new Image("gfx/hex_green.png");
		_blueImage = new Image("gfx/hex_blue.png");
		_highlightImage = new Image("gfx/hex_highlight.png");
		_brownImage.centerOrigin();
		_greenImage.centerOrigin();
		_blueImage.centerOrigin();
		_highlightImage.centerOrigin();
		_graphicList = new Graphiclist();
		_graphicList.add(_brownImage);

		gridLocation = new Point(gridX, gridY);
		var pixelmask:Pixelmask = new Pixelmask("gfx/hex_brown.png", Std.int(-_brownImage.width / 2), Std.int(-_brownImage.height / 2));
		this.gameObjects = new Array();

		super(screenCenterX + (distanceFromCenterX * GGJConstants.GRID_SPACE_WIDTH), 
			  screenCenterY + (distanceFromCenterY * GGJConstants.GRID_SPACE_HEIGHT) + yOffset, 
			  _graphicList);

		this.type = "grid_space";
		this.mask = pixelmask;
	}

	public function neighbors():Array<GGJHexTile>
	{
		return _grid.neighborsForHexTilePosition(cast gridLocation.x, cast gridLocation.y);
	}

	public function turnBrown():Void
	{
		_graphicList.removeAll();
		_graphicList.add(_brownImage);

		if (this.highlighted)
			this.addGraphic(_highlightImage);
	}

	public function turnGreen():Void
	{
		_graphicList.removeAll();
		_graphicList.add(_greenImage);
		
		if (this.highlighted)
			this.addGraphic(_highlightImage);
	}

	public function turnBlue():Void
	{
		_graphicList.removeAll();
		_graphicList.add(_blueImage);
		
		if (this.highlighted)
			this.addGraphic(_highlightImage);
	}

	public function addObjectGraphic(g:Graphic):Void
	{
		if (this.highlighted)
			_graphicList.remove(_highlightImage);

		_graphicList.add(g);

		if (this.highlighted)
			_graphicList.add(_highlightImage);
	}

	public function removeObjectGraphic(g:Graphic):Void
	{
		_graphicList.remove(g);
	}

	public function set_highlighted(v:Bool):Bool
	{
		if (v && !highlighted)
			_graphicList.add(_highlightImage);
		else if (!v && highlighted)
			_graphicList.remove(_highlightImage);
		return highlighted = v;
	}

	/**
	 * Private
	 */
	private var _brownImage:Image;
	private var _greenImage:Image;
	private var _blueImage:Image;
	private var _highlightImage:Image;
	private var _graphicList:Graphiclist;
	private var _grid:GGJGrid;
}
