package cm;

import com.haxepunk.Engine;
import com.haxepunk.HXP;
import extendedhxpunk.ext.EXTConsole;
import cm.local.CMLocalData;
import cm.local.CMColorPalette;

class Main extends Engine
{
	function new()
	{
		super(CMConstants.PLAY_SPACE_WIDTH, CMConstants.PLAY_SPACE_HEIGHT, CMConstants.FPS, false);
	}

	override public function init()
	{
		EXTConsole.initializeConsole();
		HXP.screen.color = CMLocalData.sharedInstance().currentColorPalette.colorForIndex(CMColorPalette.INDEX_BACKGROUND_1).webColor;
		
		HXP.scene = new MainScene();
		// JVSceneManager.sharedInstance().goToMainMenuScene();
	}
	
	override public function update():Void
	{
		super.update();
		// JVSceneManager.sharedInstance().update();
#if debug
		EXTConsole.update();
#end
	}
	
	public static function main()
	{
		var app = new Main();
	}
}
