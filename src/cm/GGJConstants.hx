package twogames;

/**
 * GGJConstants
 * Static class containing game-tuning constants
 */
class GGJConstants
{
#if flash
	public static inline var FPS:Int = 60;
#else
	public static inline var FPS:Int = 60;
#end
	public static inline var ASSUMED_FPS_FOR_PHYSICS:Int = 60;
	
	//TODO - fcole - Figure out how we're gonna handle different screen sizes
	//NOTE - Screen size is set in application.xml
	public static inline var PLAY_SPACE_WIDTH:Int = 1024;
	public static inline var PLAY_SPACE_HEIGHT:Int = 768;

	//NOTE - Hex grid should have an odd number of columns
	public static inline var HEX_GRID_COLUMNS:Int = 13;
	public static inline var MIDDLE_COLUMN_INDEX:Int = 6;

	public static inline var GRID_SPACE_WIDTH:Int = 48;
	public static inline var GRID_SPACE_HEIGHT:Int = 56;
}
