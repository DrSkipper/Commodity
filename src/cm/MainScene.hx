package twogames;

import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.graphics.*;
import extendedhxpunk.ext.*;
import extendedhxpunk.ui.*;
import twogames.ui.*;

class MainScene extends EXTScene
{
	 public function new()
	 {
		super();
	 }

	override public function begin():Void
	{
		// UI
		var titleDialog:JVExampleDialog = new JVExampleDialog(new Point(0, -200), new Point(250, 60));
		var titleText:Text = new Text("Solidarity", 0, 0, { "size" : 22, "color" : 0xEEEEEE });
		var titleLabel:UILabel = new UILabel(EXTUtility.ZERO_POINT, titleText);
		titleDialog.addSubview(titleLabel);

		// Play button
		_playButton = new JVExampleMenuButton(new Point(0, 80), "play", playButtonCallback);

		this.staticUiController.rootView.addSubview(titleDialog);
		this.staticUiController.rootView.addSubview(_playButton);
	}
	
	public function playButtonCallback(args:Array<Dynamic>):Void
	{
		HXP.scene = new GGJGameplayScene();
	}
	
	/**
	 * Private
	 */
	private var _toggleButton:JVExampleMenuButton;
	private var _playButton:JVExampleMenuButton;
}
