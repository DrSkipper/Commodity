package cm;

import com.haxepunk.Tween;
import com.haxepunk.tweens.misc.VarTween;

/**
 * CMSpriteDestinationQueue
 * @author Fletcher
 */
class CMSpriteDestinationQueue
{
	public var currentState:CMObjectSpriteState;
	
	public function new(parentSprite:CMObjectSprite, initialState:CMObjectSpriteState = null) 
	{
		_sprite = parentSprite;
		this.currentState = initialState == null ? 
							new CMObjectSpriteState() : 
							new CMObjectSpriteState(initialState.x, initialState.y, initialState.w, initialState.h);
		_queue = new Array();
		_tweens = new Array();
	}
	
	public function update():Void
	{
		if (_tweening)
		{
			var doneTweens:Int = 0;
			for (i in 0..._tweens.length)
			{
				var tween:Tween = _tweens[i];
				if (tween.active)
					tween.update();
				else
					++doneTweens;
			}
			
			if (doneTweens == _tweens.length)
			{
				_tweens.splice(0, _tweens.length);
				_tweening = false;
			}
		}
		
		if (!_tweening && _queue.length > 0)
		{
			var nextDestination:CMObjectSpriteDestination = _queue.shift();
			var xTween:VarTween = new VarTween(null, TweenType.OneShot);
			var yTween:VarTween = new VarTween(null, TweenType.OneShot);
			var wTween:VarTween = new VarTween(null, TweenType.OneShot);
			var hTween:VarTween = new VarTween(null, TweenType.OneShot);
			_tweens.push(xTween);
			_tweens.push(yTween);
			_tweens.push(wTween);
			_tweens.push(hTween);
			xTween.tween(this.currentState, "x", nextDestination.state.x, nextDestination.duration);
			yTween.tween(this.currentState, "y", nextDestination.state.y, nextDestination.duration);
			wTween.tween(this.currentState, "w", nextDestination.state.w, nextDestination.duration);
			hTween.tween(this.currentState, "h", nextDestination.state.h, nextDestination.duration);
			
			_tweening = true;
		}
	}
	
	//public function tweenCallback(param:Dynamic):Void
	//{
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
	private var _tweens:Array<Tween>;
}
