package cm;

/**
 * CMObjectSpriteState
 * @author Fletcher
 */
class CMObjectSpriteState
{
	public var x:Float;
	public var y:Float;
	public var w:Float;
	public var h:Float;
	//TODO - fcole - Color?
	
	public function new(x:Float = 0.0, y:Float = 0.0, w:Float = 0.0, h:Float = 0.0) 
	{
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
	}
}
