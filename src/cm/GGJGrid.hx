package twogames;

import flash.geom.Point;
import com.haxepunk.*;

class GGJGrid
{
	// Should be an odd number of columns
	public var tilecolumns:Array<Array<GGJHexTile>>;

	public function new()
	{
		tilecolumns = new Array();
		for (i in 0...GGJConstants.HEX_GRID_COLUMNS)
		{
			var tilerow:Array<GGJHexTile> = new Array();
			for (j in 0...this.tilesInColumn(i))
			{
				var tile:GGJHexTile = new GGJHexTile(i, j, this);
				tilerow.push(tile);
				HXP.scene.add(tile);
			}
			tilecolumns.push(tilerow);
		}
	}

	public function tilesInColumn(columnIndex:Int):Int
	{
		var distanceFromCenter:Int = cast Math.abs(GGJConstants.MIDDLE_COLUMN_INDEX - columnIndex);
		return GGJConstants.HEX_GRID_COLUMNS - distanceFromCenter;
	}

	public function neighborsForHexTilePosition(positionX:Int, positionY:Int):Array<GGJHexTile>
	{
		var surroundingPoints:Array<Point> = new Array();

		// Above
		surroundingPoints.push(new Point(positionX, positionY - 1));

		// Below
		surroundingPoints.push(new Point(positionX, positionY + 1));

		// Upper-Left
		if (positionX <= GGJConstants.MIDDLE_COLUMN_INDEX)
			surroundingPoints.push(new Point(positionX - 1, positionY - 1));
		else
			surroundingPoints.push(new Point(positionX - 1, positionY));

		// Lower-Left
		if (positionX <= GGJConstants.MIDDLE_COLUMN_INDEX)
			surroundingPoints.push(new Point(positionX - 1, positionY));
		else
			surroundingPoints.push(new Point(positionX - 1, positionY + 1));

		// Upper-Right
		if (positionX < GGJConstants.MIDDLE_COLUMN_INDEX)
			surroundingPoints.push(new Point(positionX + 1, positionY));
		else
			surroundingPoints.push(new Point(positionX + 1, positionY - 1));

		// Lower-Right
		if (positionX < GGJConstants.MIDDLE_COLUMN_INDEX)
			surroundingPoints.push(new Point(positionX + 1, positionY + 1));
		else
			surroundingPoints.push(new Point(positionX + 1, positionY));

		var retVal:Array<GGJHexTile> = new Array();
		for (point in surroundingPoints)
		{
			if (point.x < 0 || point.x >= GGJConstants.HEX_GRID_COLUMNS)
				continue;

			if (point.y < 0 || point.y >= tilecolumns[cast point.x].length)
				continue;

			retVal.push(tilecolumns[cast point.x][cast point.y]);
		}
		return retVal;
	}
}
