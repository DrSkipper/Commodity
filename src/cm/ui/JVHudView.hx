package cm.ui;

import flash.geom.Point;
import com.haxepunk.HXP;
import extendedhxpunk.ui.UIView;
import extendedhxpunk.ext.EXTUtility;
import extendedhxpunk.ext.EXTOffsetType;
import extendedhxpunk.ext.EXTCamera;
import cm.MainScene;

/**
 * JVHudView
 * The standard in-game HUD.
 * Created by Fletcher 11/3/13
 */
class JVHudView extends UIView
{
	public function new(camera:EXTCamera) 
	{
		super(EXTUtility.ZERO_POINT, new Point(HXP.screen.width, HXP.screen.height));
		
		_camera = camera;
		
		var backButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(10, 10), "quit", backButtonCallback);
		backButton.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
		backButton.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
		
		var zoomInButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(-10, 10), "zoom in", zoomInButtonCallback);
		zoomInButton.offsetAlignmentForSelf = EXTOffsetType.TOP_RIGHT;
		zoomInButton.offsetAlignmentInParent = EXTOffsetType.TOP_RIGHT;
		
		var zoomOutButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(-10, 50), "zoom out", zoomOutButtonCallback);
		zoomOutButton.offsetAlignmentForSelf = EXTOffsetType.TOP_RIGHT;
		zoomOutButton.offsetAlignmentInParent = EXTOffsetType.TOP_RIGHT;
		
		this.addSubview(backButton);
// #if debug
// 		this.addSubview(zoomInButton);
// 		this.addSubview(zoomOutButton);
// #end
	}
	
	public function backButtonCallback(args:Array<Dynamic>):Void
	{
		HXP.scene = new MainScene();
	}
	
	public function zoomInButtonCallback(args:Array<Dynamic>):Void
	{
		_camera.zoomWithAnchor(0.1, EXTUtility.ZERO_POINT, EXTOffsetType.CENTER);
	}
	
	public function zoomOutButtonCallback(args:Array<Dynamic>):Void
	{
		_camera.zoomWithAnchor(-0.1, EXTUtility.ZERO_POINT, EXTOffsetType.CENTER);
	}
	
	/**
	 * Private
	 */
	private var _camera:EXTCamera;
}
