package bones.dice 
{
	import flash.system.*;
	
	import starling.display.MovieClip;
	import starling.events.Event; 
	import starling.core.Starling;
	
	import bones.data.Atlases;
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Dice extends MovieClip 
	{
		
		public function Dice(_x:int, _y:int) 
		{
			Atlases.setTextureAtlasEmbeddedAsset(Atlases.AtlasDice1, Atlases.XmlAtlasDice1);
			super(Atlases.textureAtlasAnimation.getTextures("dice_"), 12);
			
			x = _x;
			y = _y;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
            addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			loop = true;
			play();
			
			Starling.juggler.add(this);
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			stop();
			Atlases.disposeTextureAtlas();
			Starling.juggler.removeTweens(this);
			while (this.numFrames > 1)
			{
				this.removeFrameAt(0);
			}
			this.removeFromParent(true);
			super.dispose();
			System.gc();
		}
		
		private function onComplete(e:Event):void 
		{
			
		}
		
	}

}