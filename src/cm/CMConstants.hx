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

	public static inline var GRID_SPACE_WIDTH:Int = 8;
	public static inline var GRID_SPACE_HEIGHT:Int = 8;

	public static inline var BASE_OBJECT_GRID_SPACES = 8;
	public static inline var ASSEMBLY_LINE_WIDTH = 200;
	public static inline var ASSEMBLY_LINE_OBJECT_BUFFER = 16; // pixels
	public static inline var ASSEMBLY_LINE_LENGTH = 7; // Number of base objects that fit in an assembly line
}

// L->C->$->C
// Ludum Dare 30 game
// I've been thinking a bunch about the commodification of labor recently so this game is kinda about that and maybe kinda sorta relates to the theme #LD48
