package bones.sevens 
{
	import adobe.utils.CustomActions;
	import flash.system.*;
	import flash.display.Bitmap;
	
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
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.text.TextFormat;
	
	import bones.events.Navigation;
	import bones.data.Constants;
	import bones.data.Images;
	import bones.data.Atlases;
	import bones.data.Sounds;
	import bones.data.Data;
	import bones.data.Utils;
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
		private var tween:Tween;
		private var dices:Vector.<MovieClip>;
		private var rollDices:Vector.<MovieClip>;
		private var field:Vector.<Vector.<Dice>>;
		private var additionalDice:Vector.<Dice>;
		
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
			createField();
			rollDice();
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			button.dispose();
			image.dispose();
			//textField.dispose();
			for (var i:int = 0; i < dices.length; i++) {
				Starling.juggler.removeTweens(dices[i]);
				dices[i].dispose();
			}
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
			dices = new Vector.<MovieClip>();
			
			var movieClip:MovieClip;
			var i:int;
			for (i = 0; i < 7; i++){
				movieClip = new MovieClip(Atlases.textureAtlasAnimation.getTextures("anim_dice_"), 12);
				movieClip.stop(); 
				movieClip.addEventListener(TouchEvent.TOUCH, onTouch);
				dices.push(movieClip);
				Starling.juggler.add(dices[i]);
			}
			
			dices[0].x = 45;
			dices[0].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(dices[0]);
			
			dices[1].x = 160;
			dices[1].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(dices[1]);
			
			dices[2].x = 280;
			dices[2].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(dices[2]);
			
			dices[3].x = 400;
			dices[3].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(dices[3]);
			
			dices[4].x = 520;
			dices[4].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(dices[4]);
			
			dices[5].x = 640;
			dices[5].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(dices[5]);
			
			dices[6].x = 760;
			dices[6].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(dices[6]);
			
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			//e.getTouch(e.target as DisplayObject, TouchPhase.HOVER) ? (e.target as MovieClip).play() : (e.target as MovieClip).stop();
			if (e.getTouch(e.target as DisplayObject, TouchPhase.HOVER)){
				(e.target as MovieClip).play();
				//Sounds.PlaySound(Sounds.Sound1);
			}else{
				(e.target as MovieClip).stop();
				//Sounds.StopSound();
			}
			if (e.getTouch(e.target as DisplayObject, TouchPhase.BEGAN)){
				(e.target as MovieClip).visible = false;
				//Sounds.StopSound();
				rollDice();
			}
		}
		
		private function createField():void
		{
			field = new Vector.<Vector.<Dice>>();
			for (var i:int = 0; i < 5; i++) {
				var newRow:Vector.<Dice> = new Vector.<Dice>();
				for (var j:int = 0; j < 10; j++) {
					newRow.push(new Dice());
					newRow[j].x = 300 + (45 * i);
					newRow[j].y = 180 + (42 * j);
					addChild(newRow[j]);
					
				}
				field.push(newRow);
			}
		}
		
		private function rollDice():void
		{
			var i:int;
			if(additionalDice != null){
				for (i = 0; i < additionalDice.length; i++) {
					removeChild(additionalDice[i]);
					additionalDice[i].dispose();
					additionalDice[i] = null;
				}
			}
			additionalDice = null;
			
			var movieClip:MovieClip;
			rollDices = new Vector.<MovieClip>()
			for (i = 0; i < 2; i++){
				movieClip = new MovieClip(Atlases.textureAtlasAnimation.getTextures("anim_dice_"), 12);
				movieClip.play(); 
				movieClip.x = 0 + (50 * i);
				movieClip.y = 0 + (50 * i);
				rollDices.push(movieClip);
				addChild(rollDices[i]);
				Starling.juggler.add(rollDices[i]);
				
				tween = new Tween(rollDices[i], 1.0);
				tween.moveTo(100 + (150 * i), 100 + (150 * i));
				tween.onComplete = rollDiceComplete;
				Starling.juggler.add(tween);
			}
			
			
		}
		
		private function rollDiceComplete():void 
		{
			additionalDice = new Vector.<Dice>();
			Starling.juggler.removeTweens(tween);
			var value:int;
			var i:int;
			for (i = 0; i < rollDices.length; i++) {
				value = Utils.getRandomInt(1, 7);
				
				additionalDice.push(new Dice());
				additionalDice[i].x = rollDices[i].x;
				additionalDice[i].y = rollDices[i].y;
				addChild(additionalDice[i]);
				
				rollDices[i].stop();
				Starling.juggler.removeTweens(rollDices[i]);
				removeChild(rollDices[i]);
				rollDices[i].dispose();
			}
			rollDices = null;
		}
		
	}

}