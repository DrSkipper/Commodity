package cm;

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
		
		
	}
	
	/**
	 * Private
	 */
	public var _length:Int;
}
