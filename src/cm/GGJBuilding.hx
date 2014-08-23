package twogames;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class GGJBuilding extends GGJGameObject
{
	public function new(playerId:Int)
	{
		super(playerId);
		var myImage:Image = playerId == 1 ? new Image("gfx/hex_building_blue.png") : new Image("gfx/hex_building_red.png");
		myImage.centerOrigin();
		this.graphic = myImage;
	}

	override public function gameActionsForImperialistTurn(turn:GGJImperialistTurn):Array<GGJGameAction>
	{
		var retVal:Array<GGJGameAction> = new Array();
		retVal.push(new GGJProduceWorkerAction(1, this.tile, turn, this));
		retVal.push(new GGJProduceSoldierAction(1, this.tile, turn, this));
		return retVal;
	}

	override public function gameActionsForWorkersTurn(turn:GGJWorkersTurn):Array<GGJGameAction>
	{
		var retVal:Array<GGJGameAction> = new Array();
		return retVal;
	}
}
