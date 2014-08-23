package twogames;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class GGJWorker extends GGJGameObject
{
	public function new(playerId:Int)
	{
		super(playerId);
		var myImage:Image = playerId == 1 ? new Image("gfx/hex_worker_blue.png") : new Image("gfx/hex_worker_red.png");
		myImage.centerOrigin();
		this.graphic = myImage;
		this.organizable = true;
	}
	
	override public function gameActionsForImperialistTurn(turn:GGJImperialistTurn):Array<GGJGameAction>
	{
		if (!this.hasPerformedAction)
		{
			var retVal:Array<GGJGameAction> = new Array();
			retVal.push(new GGJMoveAction(1, this.tile, turn, this));
			retVal.push(new GGJHarvestAction(1, this.tile, turn, this));
			return retVal;
		}
		else
			return super.gameActionsForImperialistTurn(turn);
	}

	override public function gameActionsForWorkersTurn(turn:GGJWorkersTurn):Array<GGJGameAction>
	{
		if (!this.hasPerformedAction)
		{
			var retVal:Array<GGJGameAction> = new Array();
			retVal.push(new GGJMoveAction(1, this.tile, turn, this));
			retVal.push(new GGJHarvestAction(1, this.tile, turn, this));
			if (this.organized)
				retVal.push(new GGJOrganizeAction(1, this.tile, turn, this));
			return retVal;
		}
		else
			return super.gameActionsForWorkersTurn(turn);
	}
}
