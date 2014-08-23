package twogames.ui;

import flash.geom.Point;
import com.haxepunk.graphics.*;
import extendedhxpunk.ext.*;
import extendedhxpunk.ui.*;
import twogames.*;

class GGJGridSpaceItemsView extends JVExampleDialog
{
	public function new()
	{
		super(new Point(-15, -15), new Point(170, 200));
		this.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_RIGHT;
		this.offsetAlignmentInParent = EXTOffsetType.BOTTOM_RIGHT;
		buttons = new Array();

		var organizerText = new Text("* organizer *", 0, 0, { "size" : 20, "color" : 0x991111 });
		_organizerLabel = new UILabel(new Point(0, -10), organizerText);
		_organizerLabel.offsetAlignmentInParent = EXTOffsetType.BOTTOM_CENTER;
		_organizerLabel.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_CENTER;
	}

	public function updateForGameActions(gameActions:Array<GGJGameAction>, showOrganizerLabel:Bool):Void
	{
		var buttonsLength:Int = buttons.length;
		for (i in 0...buttonsLength)
		{
			this.removeSubview(buttons[0]);
			buttons.shift();
		}

		if (gameActions != null)
		{
			for (i in 0...gameActions.length)
			{
				var button:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 20 + (50 * i)), gameActions[i].name, activateAction, [gameActions[i]]);
				button.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
				button.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
				this.addSubview(button);
				buttons.push(button);
			}
		}

		this.removeSubview(_organizerLabel);
		if (showOrganizerLabel)
			this.addSubview(_organizerLabel);
	}

	public function activateAction(args:Array<Dynamic>):Void
	{
		var actionForButton:GGJGameAction = cast args[0];
		actionForButton.activate();
		this.disableButtons();
	}

	public function enableButtons():Void
	{
		for (i in 0...buttons.length)
			buttons[i].enabled = true;
	}

	public function disableButtons():Void
	{
		for (i in 0...buttons.length)
			buttons[i].enabled = false;
	}

	/**
	 * Private
	 */
	private var buttons:Array<JVExampleMenuButton>;
	private var _organizerLabel:UILabel;
}
