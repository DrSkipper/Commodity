package cm;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.graphics.Image;
import extendedhxpunk.ext.EXTColor;
import cm.local.CMLocalData;
import cm.local.CMColorPalette;

/**
 * CMAssemblyLineSprite
 * @author Fletcher
 */
class CMObjectSprite extends Entity
{
	public var state:CMObjectSpriteState;
	
	public function new(x:Float, y:Float, w:Float, h:Float, color:EXTColor, buffer:Float = 0.0) 
	{
		super();
		_image = new Image("gfx/solid.png");
		_image.color = color.webColor;
		this.graphic = _image;
		_buffer = buffer;
		
		var initialState:CMObjectSpriteState = new CMObjectSpriteState(x, y, 2.0, 2.0);
		var targetState:CMObjectSpriteState = new CMObjectSpriteState(x, y, w - buffer, h - buffer);
		var targetDestination:CMObjectSpriteDestination = new CMObjectSpriteDestination();
		targetDestination.state = targetState;
		targetDestination.duration = 0.2;
		
		_stateQueue = new CMSpriteDestinationQueue(this, initialState);
		this.applySpriteState(initialState);
		_stateQueue.addDestination(targetDestination);
		this.state = targetState;
	}
	
	public function applySpriteState(state:CMObjectSpriteState):Void
	{
		_image.scaledWidth = state.w;
		_image.scaledHeight = state.h;
		_image.x = -state.w / 2;
		_image.y = -state.h / 2;
		this.width = cast state.w;
		this.height = cast state.h;
		this.x = state.x;
		this.y = state.y;
		this.centerOrigin();
	}
	
	public function appendState(state:CMObjectSpriteState):Void
	{
		state.w -= _buffer;
		state.h -= _buffer;
		
		var nextDestination:CMObjectSpriteDestination = new CMObjectSpriteDestination();
		nextDestination.state = state;
		nextDestination.duration = 0.4;
		_stateQueue.addDestination(nextDestination);
		this.state = state;
	}
	
	override public function update():Void
	{
		super.update();
		_stateQueue.update();
		this.applySpriteState(_stateQueue.currentState);
	}
	
	override public function removed():Void
	{
		super.removed();
		_stateQueue.clearTweens();
		_stateQueue = null;
	}
	
	public function setColor(color:EXTColor)
	{
		_image.color = color.webColor;
	}
	
	/**
	 * Private
	 */
	private var _image:Image;
	private var _stateQueue:CMSpriteDestinationQueue;
	private var _buffer:Float;
}
