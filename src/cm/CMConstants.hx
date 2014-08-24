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

	public static inline var GRID_SPACE_WIDTH:Int = 16;
	public static inline var GRID_SPACE_HEIGHT:Int = 16;

	public static inline var BASE_OBJECT_GRID_SPACES:Int = 4;
	public static inline var ASSEMBLY_LINE_WIDTH:Int = 200;
	public static inline var ASSEMBLY_LINE_OBJECT_BUFFER:Int = 16; // pixels
	public static inline var ASSEMBLY_LINE_LENGTH:Int = 7; // Number of base objects that fit in an assembly line
	
	public static inline var BLOCK_TYPES:Int = 3;
	public static inline var BLOCK_SPAWN_COOLDOWN:Float = 3.0;
	public static inline var BLOCK_TAP_COOLDOWN:Float = 0.8;
}

// L->C->$->C
// Ludum Dare 30 game
// I've been thinking a bunch about the commodification of labor recently so this game is kinda about that and maybe kinda sorta relates to the theme #LD48
