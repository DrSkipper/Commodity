package twogames;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class GGJResources extends GGJGameObject
{
	public function new(playerId:Int)
	{
		super(playerId);
		var myImage:Image = new Image("gfx/hex_resources.png");
		myImage.centerOrigin();
		this.graphic = myImage;
	}
	
	override public function gameActionsForImperialistTurn(turn:GGJImperialistTurn):Array<GGJGameAction>
	{
		return super.gameActionsForImperialistTurn(turn);
	}

	override public function gameActionsForWorkersTurn(turn:GGJWorkersTurn):Array<GGJGameAction>
	{
		return super.gameActionsForWorkersTurn(turn);
	}
}
