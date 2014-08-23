package cm.local;

/**
 * CMLocalData
 * Access to data, states, and settings local to this game copy
 * Created by Fletcher, 8/22/2014
 */
class CMLocalData
{
	public var currentColorPalette(default, null):CMColorPalette;
	
	/**
	 * Singleton access
	 */
	public static function sharedInstance():CMLocalData
	{
		if (_Singleton == null)
			_Singleton = new CMLocalData();
		return _Singleton;
	}
	
	/**
	 * For singleton guarding
	 */
	private static var _Singleton:CMLocalData = null;
	private function new()
	{
		this.currentColorPalette = new CMColorPalette(1);
	}
}
