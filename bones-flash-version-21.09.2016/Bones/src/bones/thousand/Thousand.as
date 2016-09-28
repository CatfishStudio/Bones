package bones.thousand 
{
	import flash.system.*;
	import flash.display.Bitmap;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.display.MovieClip;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFormat;
	
	import bones.events.Navigation;
	import bones.data.Constants;
	import bones.data.Images;
	import bones.data.Atlases;
	import bones.data.Sounds;
	import bones.data.Data;
	import bones.data.Utils;
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Thousand extends Sprite 
	{
		private var image:Image;
		
		public function Thousand() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
			name = Constants.THOUSAND;
			
			createBackground();
			
			trace('[THOUSAND]: added to stage');
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			image.dispose();
			image = null;
			
			while (this.numChildren) {
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			super.dispose();
			System.gc();
			
			trace('[THOUSAND]: removed from stage');
		}
		
		private function onButtonsClick(e:Event):void 
		{
			/*
			switch(Button(e.target).name){
				case Constants.SEVENS_BUTTON_HELP:
				{
					dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(e.target).name }));
					break;
				}
				case Constants.SEVENS_BUTTON_END_GAME:
				{
					Data.userRatingSevens = score;
					if (gameOver == false){
						gameOver = true;
						dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(e.target).name }));
					}
					break;
				}
				default:
				{
					break;
				}
			}
			*/
		}
				
		private function createBackground():void
		{
			var bitmap:Bitmap = new Images.ImgThousand();
			image = new Image(Texture.fromBitmap(bitmap));
			image.x = 0;
			image.y = 0;
			addChild(image);
			bitmap = null;
		}
		
	}

}