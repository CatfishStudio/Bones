package bones.sevens 
{
	import flash.system.*;
	import flash.display.Bitmap;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.text.TextFormat;
	
	import bones.events.Navigation;
	import bones.data.Constants;
	import bones.data.Images;
	import bones.data.Atlases;
	import bones.data.Data;
	import bones.dice.Dice;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Sevens extends Sprite 
	{
		private var button:Button;
		private var image:Image;
		private var textField:TextField;
		private var moveClip:MovieClip;
		
		public function Sevens() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
			
			name = Constants.SEVENS;
			createBackground();
			createButtons();
			createDices();
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			button.dispose();
			image.dispose();
			moveClip.dispose();
			//textField.dispose();
			while (this.numChildren) {
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			super.dispose();
			System.gc();
		}
		
		private function onButtonsClick(e:Event):void 
		{
			switch(Button(e.target).name){
				case Constants.SEVENS_BUTTON_HELP:
				{
					dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(e.target).name }));
					break;
				}
				case Constants.SEVENS_BUTTON_END_GAME:
				{
					dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(e.target).name }));
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		private function createBackground():void
		{
			var bitmap:Bitmap = new Images.ImgSevens();
			image = new Image(Texture.fromBitmap(bitmap));
			image.x = 0;
			image.y = 0;
			addChild(image);
			bitmap = null;
		}
		
		private function createButtons():void
		{
			var bitmap:Bitmap = new Images.ImgButtonHelp();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.SEVENS_BUTTON_HELP;
			button.x = 15;
			button.y = Constants.GAME_WINDOW_HEIGHT - 230;
			addChild(button);
			
			bitmap = new Images.ImgButtonEndGame();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.SEVENS_BUTTON_END_GAME;
			button.x = 15;
			button.y = Constants.GAME_WINDOW_HEIGHT - 175;
			addChild(button);
			
			bitmap = null;
		}
		
		private function createDices():void
		{
			/*
			for (var i:int = 0; i < 7; i++){
				var dice:Dice = new Dice(45 + (50 * i), Constants.GAME_WINDOW_HEIGHT - 75);
				dice.name = "dice" + i.toString();
				addChild(dice);
				dice.dispose();
				dice = null;
			}
			*/
			
			Atlases.setTextureAtlasEmbeddedAsset(Atlases.AtlasDice1, Atlases.XmlAtlasDice1);
			
			moveClip = new MovieClip(Atlases.textureAtlasAnimation.getTextures("dice_"), 12);
			moveClip.x = 45;
			moveClip.y = Constants.GAME_WINDOW_HEIGHT - 80;
			moveClip.stop();
			moveClip.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(moveClip);
			Starling.juggler.add(moveClip);
			
			moveClip = new MovieClip(Atlases.textureAtlasAnimation.getTextures("dice_"), 12);
			moveClip.x = 160;
			moveClip.y = Constants.GAME_WINDOW_HEIGHT - 80;
			moveClip.stop();
			moveClip.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(moveClip);			
			Starling.juggler.add(moveClip);

		}
		
		private function onTouch(e:TouchEvent):void 
		{
			if (e.getTouch(this, TouchPhase.HOVER)){
				trace('HOVER');
			}
			if (e.getTouch(this, TouchPhase.MOVED)){
				trace('MOVED');
			}
			moveClip.play();
		}
		
		
	}

}