package cm;

import com.haxepunk.HXP;

/**
 * CMAssemblyLine
 * Data for one production assembly line.
 * Created by Fletcher 8/22/2014
 */
class CMAssemblyLine
{
	public function new(slot:Int, length:Int, outputLine:CMAssemblyLine = null, inputLine:CMAssemblyLine = null) 
	{
		_length = length;
		var pixelLength:Float = (length + CMConstants.ASSEMBLY_LINE_OBJECT_BUFFER) * CMConstants.BASE_OBJECT_GRID_SPACES * CMConstants.GRID_SPACE_HEIGHT;
		_sprite = new CMObjectSprite(slot * (CMConstants.PLAY_SPACE_WIDTH / 4 + 1), CMConstants.PLAY_SPACE_HEIGHT / 2, CMConstants.ASSEMBLY_LINE_WIDTH, pixelLength);
		HXP.scene.add(_sprite);
		
		_blocks = new Array();
	}
	
	public function addNewBlocks(topBlock:CMBlock, bottomBlock:CMBlock):Void
	{
		topBlock.gridSpace = 0;
		bottomBlock.gridSpace = _length - bottomBlock.size;
		
		this.makeRoomForBlock(topBlock);
		_blocks.unshift(topBlock);
		
		this.makeRoomForBlock(bottomBlock);
		_blocks.push(bottomBlock);
	}
	
	public function makeRoomForBlock(block:CMBlock):Void
	{
		
	}
	
	/**
	 * Private
	 */
	private var _length:Int;
	private var _sprite:CMObjectSprite;
	private var _blocks:Array<CMBlock>;
}
