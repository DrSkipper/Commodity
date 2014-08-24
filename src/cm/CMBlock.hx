package cm;

import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import extendedhxpunk.ext.EXTColor;
import cm.local.CMLocalData;
import cm.local.CMColorPalette;

/**
 * CMBlock
 * Data for a production puzzle block.
 * Created by Fletcher 8/22/2014
 */
class CMBlock
{
	public var gridSpace:Int;
	public var size:Int;
	public var level:Int;
	public var blockType:Int;
	public var assemblyLine:CMAssemblyLine;
	
	public function new(blockType:Int, level:Int, spawnX:Float = 0.0, spawnY:Float = 0.0, assemblyLine:CMAssemblyLine = null) 
	{
		this.blockType = blockType;
		this.level = level;
		this.size = cast (CMConstants.BASE_OBJECT_GRID_SPACES + ((level - 1) * CMConstants.BASE_OBJECT_GRID_SPACES / 2));
		this.assemblyLine = assemblyLine;
		
		var color:EXTColor = CMLocalData.sharedInstance().currentColorPalette.colorForIndex(CMColorPalette.INDEX_BLOCK_1);
		var pixelLength:Float = this.size * CMConstants.GRID_SPACE_HEIGHT;
		_sprite = new CMObjectSprite(spawnX, spawnY, CMConstants.ASSEMBLY_LINE_WIDTH, pixelLength, color, CMConstants.ASSEMBLY_LINE_OBJECT_BUFFER);
		HXP.scene.add(_sprite);
	}
	
	public function animateToPosition():Void
	{
		var point:Point = this.assemblyLine.pointForBlock(this);
		var nextState:CMObjectSpriteState = new CMObjectSpriteState(point.x, point.y, CMConstants.ASSEMBLY_LINE_WIDTH, this.size * CMConstants.GRID_SPACE_HEIGHT);
		_sprite.appendState(nextState);
	}
	
	/**
	 * Private
	 */
	private var _sprite:CMObjectSprite;
}
