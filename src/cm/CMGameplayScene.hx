package cm;

import flash.geom.Point;
import com.haxepunk.HXP;
import extendedhxpunk.ext.EXTScene;
import extendedhxpunk.ext.EXTOffsetType;
import extendedhxpunk.ext.EXTUtility;
import extendedhxpunk.ui.UIView;
import extendedhxpunk.ext.EXTTimer;
import cm.ui.JVExampleMenuButton;

/**
 * CMGameplayScene
 * Scene for puzzle/production gameplay to take place in.
 * Created by Fletcher 8/22/2014
 */
class CMGameplayScene extends EXTScene
{
	public function new() 
	{
		super();
	}
	
	override public function begin():Void
	{
		super.begin();
		
		var backButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(20, 20), "back", backButtonCallback);
		backButton.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
		backButton.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
		
		var fullView:UIView = new UIView(EXTUtility.ZERO_POINT, new Point(CMConstants.PLAY_SPACE_WIDTH, CMConstants.PLAY_SPACE_HEIGHT));
		fullView.addSubview(backButton);
		this.staticUiController.rootView.addSubview(fullView);
		
		// Add assembly lines
		_assemblyLine = new CMAssemblyLine(2, CMConstants.ASSEMBLY_LINE_LENGTH);
		_assemblyLine.spawnNewBlocks();
		
		_spawnTimer = EXTTimer.createTimer(1.0, true, spawnTimerCallback);
	}
	
	override public function update():Void
	{
		super.update();
	}
	
	public function backButtonCallback(args:Array<Dynamic>):Void
	{
		_spawnTimer.invalidate();
		_spawnTimer = null;
		 HXP.scene = new MainScene();
	}
	
	public function spawnTimerCallback(timer:EXTTimer):Void
	{
		_assemblyLine.spawnNewBlocks();
	}
	
	/**
	 * Private
	 */
	var _assemblyLine:CMAssemblyLine;
	var _spawnTimer:EXTTimer;
}
