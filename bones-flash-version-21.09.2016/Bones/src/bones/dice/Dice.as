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
	
	import bones.data.Atlases;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Dice extends Sprite 
	{
		private var image:Image;
		private var diceValues:Array = [];
		private var type:int;
		private var indexDice:int;
		private var nextIndexDice:int;
		private var selected:Boolean;
		
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
			var frame:String = "dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + ".png";
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
			var frame:String = "dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + ".png";
			image.texture = Atlases.textureAtlas.getTexture(frame);
			y += 42;
		}
		
		public function select():void
		{
			var frame:String;
			if (selected){
				selected = false;
				frame = "dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + ".png";
				image.texture = Atlases.textureAtlas.getTexture(frame);
			}else{
				selected = true;
				frame = "dice" + diceValues[indexDice] + "0" +  diceValues[indexDice] + diceValues[nextIndexDice] + "Y.png";
				image.texture = Atlases.textureAtlas.getTexture(frame);
			}
			frame = null;
		}
		
		public function getSelect():Boolean
		{
			return selected;
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