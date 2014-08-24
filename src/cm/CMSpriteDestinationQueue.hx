package cm;

import com.haxepunk.Tween;
import com.haxepunk.Tweener;
import com.haxepunk.tweens.misc.VarTween;

/**
 * CMSpriteDestinationQueue
 * @author Fletcher
 */
class CMSpriteDestinationQueue extends Tweener
{
	public var currentState:CMObjectSpriteState;
	
	public function new(parentSprite:CMObjectSprite, initialState:CMObjectSpriteState = null) 
	{
		super();
		_sprite = parentSprite;
		this.currentState = initialState == null ? 
							new CMObjectSpriteState() : 
							new CMObjectSpriteState(initialState.x, initialState.y, initialState.w, initialState.h);
		_queue = new Array();
	}
	
	override public function update():Void
	{
		super.update();
		this.updateTweens();
		
		if (_tweening && !this.hasTween)
			_tweening = false;
		
		if (!_tweening && _queue.length > 0)
		{
			var nextDestination:CMObjectSpriteDestination = _queue.shift();
			var xTween:VarTween = new VarTween(null, TweenType.OneShot);
			var yTween:VarTween = new VarTween(null, TweenType.OneShot);
			var wTween:VarTween = new VarTween(null, TweenType.OneShot);
			var hTween:VarTween = new VarTween(null, TweenType.OneShot);
			//trace("starting tween");
			//trace("x = " + nextDestination.state.x);
			//trace("y = " + nextDestination.state.y);
			//trace("w = " + nextDestination.state.w);
			//trace("h = " + nextDestination.state.h);
			xTween.tween(this.currentState, "x", nextDestination.state.x, nextDestination.duration);
			yTween.tween(this.currentState, "y", nextDestination.state.y, nextDestination.duration);
			wTween.tween(this.currentState, "w", nextDestination.state.w, nextDestination.duration);
			hTween.tween(this.currentState, "h", nextDestination.state.h, nextDestination.duration);
			this.addTween(xTween, true);
			this.addTween(yTween, true);
			this.addTween(wTween, true);
			this.addTween(hTween, true);
			
			_tweening = true;
		}
	}
	
	//public function tweenCallback(param:Dynamic):Void
	//{
		//trace("done");
		//++_doneTweens;
	//}
	
	public function addDestination(destination:CMObjectSpriteDestination):Void
	{
		_queue.push(destination);
	}
	
	/**
	 * Private
	 */
	private var _sprite:CMObjectSprite;
	private var _queue:Array<CMObjectSpriteDestination>;
	private var _tweening:Bool;
}
