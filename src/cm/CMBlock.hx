package cm;

import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import extendedhxpunk.ext.EXTColor;
import extendedhxpunk.ext.EXTTimer;
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
	public var level(default, set):Int;
	public var blockType:Int;
	public var assemblyLine:CMAssemblyLine;
	public var sprite(get, never):CMObjectSprite;
	
	public function new(blockType:Int, level:Int, spawnX:Float = 0.0, spawnY:Float = 0.0, assemblyLine:CMAssemblyLine = null) 
	{
		this.blockType = blockType;
		this.level = level;
		this.assemblyLine = assemblyLine;
		
		var color:EXTColor = CMLocalData.sharedInstance().currentColorPalette.colorForIndex(CMColorPalette.INDEX_BLOCK_1 + blockType);
		var pixelLength:Float = this.size * CMConstants.GRID_SPACE_HEIGHT;
		_sprite = new CMObjectSprite(spawnX, spawnY, CMConstants.ASSEMBLY_LINE_WIDTH, pixelLength, color, CMConstants.ASSEMBLY_LINE_OBJECT_BUFFER);
		_sprite.type = "block";
		HXP.scene.add(_sprite);
	}
	
	public function animateToPosition():Void
	{
		var point:Point = this.assemblyLine.pointForBlock(this);
		var nextState:CMObjectSpriteState = new CMObjectSpriteState(point.x, point.y, CMConstants.ASSEMBLY_LINE_WIDTH, this.size * CMConstants.GRID_SPACE_HEIGHT);
		_sprite.appendState(nextState);
	}
	
	public function set_level(l:Int):Int
	{
		level = l;
		this.size = cast (CMConstants.BASE_OBJECT_GRID_SPACES + ((level - 1) * CMConstants.BASE_OBJECT_GRID_SPACES / 8));
		return level;
	}
	
	public function consume():Void
	{
		var point:Point = this.assemblyLine.pointForBlock(this);
		var offLineState:CMObjectSpriteState = new CMObjectSpriteState(point.x + CMConstants.ASSEMBLY_LINE_WIDTH, point.y, CMConstants.ASSEMBLY_LINE_WIDTH, this.size * CMConstants.GRID_SPACE_HEIGHT);
		var finalState:CMObjectSpriteState = new CMObjectSpriteState(point.x + CMConstants.ASSEMBLY_LINE_WIDTH, point.y, 2.0, 2.0);
		_sprite.appendState(offLineState);
		_sprite.appendState(finalState);
		EXTTimer.createTimer(0.8, false, postConsume);
	}
	
	public function postConsume(timer:EXTTimer):Void
	{
		this.remove();
	}
	
	public function remove():Void
	{
		HXP.scene.remove(_sprite);
	}
	
	public function get_sprite():CMObjectSprite
	{
		return _sprite;
	}
	
	/**
	 * Private
	 */
	private var _sprite:CMObjectSprite;
}
