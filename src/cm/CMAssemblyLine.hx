package cm;

import flash.geom.Point;
import com.haxepunk.HXP;
import extendedhxpunk.ext.EXTColor;
import cm.local.CMLocalData;
import cm.local.CMColorPalette;

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
		var color:EXTColor = CMLocalData.sharedInstance().currentColorPalette.colorForIndex(CMColorPalette.INDEX_BACKGROUND_2);
		_pixelLength = length * CMConstants.BASE_OBJECT_GRID_SPACES * CMConstants.GRID_SPACE_HEIGHT;
		_sprite = new CMObjectSprite(slot * (CMConstants.PLAY_SPACE_WIDTH / 4 + 1),
									 CMConstants.PLAY_SPACE_HEIGHT / 2,
									 CMConstants.ASSEMBLY_LINE_WIDTH,
									 _pixelLength,
									 color);
		HXP.scene.add(_sprite);
		
		_blocks = new Array();
	}
	
	public function pointForBlock(block:CMBlock):Point
	{
		return new Point(_sprite.state.x, (_sprite.state.y - _pixelLength / 2) + (block.gridSpace * CMConstants.GRID_SPACE_HEIGHT) + (block.size * CMConstants.GRID_SPACE_HEIGHT / 2));
	}
	
	public function spawnNewBlocks():Void
	{
		var topBlock:CMBlock = new CMBlock(0, 0, _sprite.x, _sprite.y - _pixelLength / 2, this);
		var bottomBlock:CMBlock = new CMBlock(0, 0, _sprite.x, _sprite.y + _pixelLength / 2, this);
		this.addBlocks(topBlock, bottomBlock);
	}
	
	public function addBlocks(topBlock:CMBlock, bottomBlock:CMBlock):Void
	{
		topBlock.gridSpace = 0;
		bottomBlock.gridSpace = _length * CMConstants.BASE_OBJECT_GRID_SPACES - bottomBlock.size;
		
		var success:Bool = this.makeRoomForBlock(topBlock, true);
		if (success)
		{
			_blocks.unshift(topBlock);
			success = this.makeRoomForBlock(bottomBlock, false);
			
			if (success)
				_blocks.push(bottomBlock);
		}
		
		if (success)
		{
			// Loop through blocks and call moveTo their positions
			for (i in 0..._blocks.length)
			{
				_blocks[i].animateToPosition();
			}
		}
		else
		{
			this.killLine();
		}
		
	}
	
	// Returns false if room cannot be made
	public function makeRoomForBlock(block:CMBlock, bubbleDown:Bool):Bool
	{
		// Find first colliding block
		var collidingBlock:CMBlock = null;
		var start:Int = 0;
		var end:Int = 0;
		if (bubbleDown)
		{
			start = block.gridSpace;
			end = block.gridSpace + block.size;
		}
		else
		{
			start = block.gridSpace + block.size - 1;
			end = block.gridSpace - 1;
		}
		
		for (i in start...end)
		{
			collidingBlock = this.getBlockAtGridSpace(i, bubbleDown);
			if (collidingBlock != null)
				break;
		}
		
		// If there's a collision, try to move the colliding object
		if (collidingBlock != null)
		{
			if (bubbleDown)
			{
				var newGridSpace:Int = block.gridSpace + block.size;
				if (newGridSpace >= _length)
				{
					trace("fuuuuu");
					return false;
				}
				else
					collidingBlock.gridSpace = newGridSpace;
			}
			else
			{
				var newGridSpace:Int = block.gridSpace - collidingBlock.size - 1;
				if (newGridSpace < 0)
				{
					trace("shiiiii");
					return false;
				}
				else
					collidingBlock.gridSpace = newGridSpace;
			}
			return this.makeRoomForBlock(collidingBlock, bubbleDown);
		}
		return true;
	}
	
	public function getBlockAtGridSpace(gridSpace:Int, fromTop:Bool):CMBlock
	{
		if (fromTop)
		{
			for (i in 0..._blocks.length)
			{
				var block:CMBlock = _blocks[_blocks.length - (i + 1)];
				if (gridSpace >= block.gridSpace && gridSpace < block.gridSpace + block.size)
					return block;
			}
		}
		else
		{
			for (i in 0..._blocks.length)
			{
				var block:CMBlock = _blocks[i];
				if (gridSpace >= block.gridSpace && gridSpace < block.gridSpace + block.size)
					return block;
			}
		}
		return null;
	}
	
	public function killLine():Void
	{
		
	}
	
	/**
	 * Private
	 */
	private var _length:Int;
	private var _pixelLength:Float;
	private var _sprite:CMObjectSprite;
	private var _blocks:Array<CMBlock>;
}
