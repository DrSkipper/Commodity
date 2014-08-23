package cm;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.graphics.Image;
import cm.local.CMLocalData;
import cm.local.CMColorPalette;

/**
 * CMAssemblyLineSprite
 * @author Fletcher
 */
class CMObjectSprite extends Entity
{
	public function new(x:Float, y:Float, w:Float, h:Float) 
	{
		super();
		_image = new Image("gfx/solid.png");
		_image.color = CMLocalData.sharedInstance().currentColorPalette.colorForIndex(CMColorPalette.INDEX_BACKGROUND_2).webColor;
		this.graphic = _image;
		
		var initialState:CMObjectSpriteState = new CMObjectSpriteState(x, y, 2.0, 2.0);
		var targetState:CMObjectSpriteState = new CMObjectSpriteState(x, y, w, h);
		var targetDestination:CMObjectSpriteDestination = new CMObjectSpriteDestination();
		targetDestination.state = targetState;
		targetDestination.duration = 0.2;
		
		_stateQueue = new CMSpriteDestinationQueue(this, initialState);
		this.applySpriteState(initialState);
		_stateQueue.addDestination(targetDestination);
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
	
	override public function update():Void
	{
		super.update();
		_stateQueue.update();
		this.applySpriteState(_stateQueue.currentState);
	}
	
	/**
	 * Private
	 */
	private var _image:Image;
	private var _stateQueue:CMSpriteDestinationQueue;
}
