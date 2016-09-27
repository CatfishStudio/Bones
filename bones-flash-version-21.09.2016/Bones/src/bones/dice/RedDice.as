package bones.dice 
{
	import flash.system.*;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import bones.data.Atlases;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class RedDice extends Sprite 
	{
		private var image:Image;
		
		public function RedDice() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveStage);
		}
		
		private function onRemoveStage(e:Event):void 
		{
			removeChild(image);
			image.dispose();
			image = null;
			super.dispose();
			System.gc();
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			image = new Image(Atlases.textureAtlas.getTexture('win_dice.png'));
			addChild(image);
		}
		
	}

}