package twogames.ui;

import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.graphics.*;
import extendedhxpunk.ext.*;
import extendedhxpunk.ui.*;
import twogames.*;

class GGJVictoryView extends JVExampleDialog
{
	public function new(victoriousPlayerId:Int)
	{
		super(new Point(0, 0), new Point(320, 200));

		var victoryString:String = "the workers are victorious";
		if (victoriousPlayerId == 1)
			victoryString = "blue wins";
		else if (victoriousPlayerId == 2)
			victoryString = "red wins";

		var okayButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 30), "okay", okayButtonCallback);
		this.addSubview(okayButton);

		var victoryText:Text = new Text(victoryString, 0, 0, { "size" : 22, "color" : 0xEEEEEE });
		var victoryLabel:UILabel = new UILabel(new Point(0, -40), victoryText);
		this.addSubview(victoryLabel);
	}

	public function okayButtonCallback(args:Array<Dynamic>):Void
	{
		HXP.scene = new MainScene();
	}
}
