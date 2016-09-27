package bones.dice 
{
	import flash.system.*;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.animation.Tween;
	import starling.core.Starling;
	
	import bones.data.Atlases;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Dice extends Sprite 
	{
		private var image:Image;
		private var tween:Tween;
		private var diceValues:Array = [];
		private var type:int;
		private var indexDice:int;
		private var nextIndexDice:int;
		private var selected:Boolean;
		private var enable:Boolean;
		
		
		public function Dice(_diceValues:Array, _type:int) 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveStage);
			//addEventListener(TouchEvent.TOUCH, onUnitTouch);
			
			diceValues = _diceValues;
			type = _type;
		}
		
		private function onRemoveStage(e:Event):void 
		{
			image.dispose();
			image = null;
			if (tween != null)
			{	
				Starling.juggler.remove(tween);
				tween = null;
			}
			diceValues = null;
			super.dispose();
			System.gc();
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			selected = false;
			indexDice = 0;
			nextIndexDice = indexDice + 1;
			var frame:String;
			if (type == 0) frame = "dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + ".png";
			else frame = "blue_dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + ".png";
			image = new Image(Atlases.textureAtlas.getTexture(frame));
			addChild(image);
			
			frame = null;
		}
		
		public function moveDown():void
		{
			indexDice++;
			if (indexDice > 3) indexDice = 0;
			nextIndexDice = indexDice + 1;
			if (nextIndexDice > 3) nextIndexDice = 0;
			var frame:String;
			if (type == 0) frame = "dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + ".png";
			else frame = "blue_dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + ".png";
			image.texture = Atlases.textureAtlas.getTexture(frame);
			
			tween = new Tween(this, 0.15);
			tween.moveTo(this.x, (this.y + 42));
			tween.onComplete = tweenComplete;
			Starling.juggler.add(tween);
		}
		
		private function tweenComplete():void 
		{
			Starling.juggler.remove(tween);
			tween = null;
		}
		
		public function select():void
		{
			var frame:String;
			if (selected){
				selected = false;
				if (type == 0) frame = "dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + ".png";
				else frame = "blue_dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + ".png";
				image.texture = Atlases.textureAtlas.getTexture(frame);
			}else{
				selected = true;
				if (type == 0) frame = "dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + "Y.png";
				else frame = "blue_dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + "Y.png";
				image.texture = Atlases.textureAtlas.getTexture(frame);
			}
			frame = null;
		}
		
		public function getSelect():Boolean
		{
			return selected;
		}
		
		public function diceEnable():void
		{
			if (enable) enable = false;
			else enable = true;
		}
		
		public function getEnable():Boolean
		{
			return enable;
		}
		
		public function getValue():int
		{
			return diceValues[indexDice];
		}
		
		public function getType():int 
		{
			return type;
		}
		
	}

}