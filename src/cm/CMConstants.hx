package cm;

/**
 * CMConstants
 * Static class containing game-tuning constants
 */
class CMConstants
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
	public static inline var PLAY_SPACE_HEIGHT:Int = 640;

	public static inline var GRID_SPACE_WIDTH:Int = 10;
	public static inline var GRID_SPACE_HEIGHT:Int = 10;

	public static inline var BASE_OBJECT_GRID_SPACES = 8;
	public static inline var ASSEMBLY_LINE_WIDTH = 200;
	public static inline var ASSEMBLY_LINE_OBJECT_BUFFER = 1; // grid spaces
	public static inline var ASSEMBLY_LINE_LENGTH = 5; // Number of base objects that fit in an assembly line
}

// L->C->$->C