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
		
		private var animDices:Vector.<MovieClip>;
		private var animRollDices:Vector.<MovieClip>;
		private var fieldDices:Vector.<Vector.<Dice>>;
		private var additionalDices:Vector.<Dice>;
		
		private var diceValues:Array = [
			[[1, 5, 4, 6], [1, 3, 4, 2], [1, 6, 4, 5], [1, 2, 4, 3]],
            [[2, 5, 3, 6], [2, 1, 3, 4], [2, 6, 3, 5], [2, 4, 3, 1]],
            [[3, 5, 2, 6], [3, 4, 2, 1], [3, 6, 2, 5], [3, 1, 2, 4]],
            [[4, 5, 1, 6], [4, 2, 1, 3], [4, 6, 1, 5], [4, 3, 1, 2]],
            [[5, 1, 6, 4], [5, 2, 6, 3], [5, 4, 6, 1], [5, 3, 6, 2]],
            [[6, 1, 5, 4], [6, 3, 5, 2], [6, 4, 5, 1], [6, 2, 5, 3]]
		];
		private var canClick:Boolean = true;
		
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
			canClick = true;
			
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
			tween = null;
			var i:int;
			if(animDices != null){
				for (i = 0; i < animDices.length; i++) {
					Starling.juggler.removeTweens(animDices[i]);
					animDices[i].dispose();
				}
				animDices = null;
			}
			
			if(animRollDices != null){
				for (i = 0; i < animRollDices.length; i++) {
					Starling.juggler.removeTweens(animRollDices[i]);
					animRollDices[i].dispose();
				}
				animRollDices = null;
			}
			fieldDices = null;
			additionalDices = null;
			diceValues = null;
			
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
			animDices = new Vector.<MovieClip>();
			
			var movieClip:MovieClip;
			var i:int;
			for (i = 0; i < 7; i++){
				movieClip = new MovieClip(Atlases.textureAtlasAnimation.getTextures("anim_dice_"), 12);
				movieClip.stop(); 
				movieClip.addEventListener(TouchEvent.TOUCH, onTouch);
				animDices.push(movieClip);
				Starling.juggler.add(animDices[i]);
			}
			
			animDices[0].x = 45;
			animDices[0].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[0]);
			
			animDices[1].x = 160;
			animDices[1].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[1]);
			
			animDices[2].x = 280;
			animDices[2].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[2]);
			
			animDices[3].x = 400;
			animDices[3].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[3]);
			
			animDices[4].x = 520;
			animDices[4].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[4]);
			
			animDices[5].x = 640;
			animDices[5].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[5]);
			
			animDices[6].x = 760;
			animDices[6].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[6]);
			
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
			if (e.getTouch(e.target as DisplayObject, TouchPhase.BEGAN) && canClick){
				canClick = false;
				(e.target as MovieClip).visible = false;
				//Sounds.StopSound();
				rollDice();
			}
		}
		
		private function createField():void
		{
			fieldDices = new Vector.<Vector.<Dice>>();
			for (var i:int = 0; i < 5; i++) {
				var newRow:Vector.<Dice> = new Vector.<Dice>();
				for (var j:int = 0; j < 10; j++) {
					newRow.push(new Dice(diceValues[Utils.getRandomInt(0,6)][Utils.getRandomInt(0,4)], Utils.getRandomInt(0,2)));
					newRow[j].x = 300 + (45 * i);
					newRow[j].y = 180 + (42 * j);
					newRow[j].addEventListener(TouchEvent.TOUCH, onDiceTouch);
					addChild(newRow[j]);
				}
				fieldDices.push(newRow);
			}
		}
		
		private function rollDice():void
		{
			var i:int;
			if(additionalDices != null){
				for (i = 0; i < additionalDices.length; i++) {
					removeChild(additionalDices[i]);
					additionalDices[i].dispose();
					additionalDices[i] = null;
				}
			}
			additionalDices = null;
			
			var movieClip:MovieClip;
			animRollDices = new Vector.<MovieClip>()
			for (i = 0; i < 2; i++){
				movieClip = new MovieClip(Atlases.textureAtlasAnimation.getTextures("anim_dice_"), 12);
				movieClip.play(); 
				movieClip.x = 25 - (50 * Utils.getRandomInt(1, 4));
				movieClip.y = 400 - (50 * Utils.getRandomInt(1, 4));
				animRollDices.push(movieClip);
				addChild(animRollDices[i]);
				Starling.juggler.add(animRollDices[i]);
				
				tween = new Tween(animRollDices[i], 1.0);
				tween.moveTo(50 + (50 * Utils.getRandomInt(1, 4)), 300 - (50 * Utils.getRandomInt(1, 4)));
				tween.onComplete = rollDiceComplete;
				Starling.juggler.add(tween);
			}
			
			
		}
		
		private function rollDiceComplete():void 
		{
			additionalDices = new Vector.<Dice>();
			Starling.juggler.removeTweens(tween);
			var value:int;
			var i:int;
			for (i = 0; i < animRollDices.length; i++) {
				value = Utils.getRandomInt(1, 7);
				
				additionalDices.push(new Dice(diceValues[Utils.getRandomInt(0,6)][Utils.getRandomInt(0,4)], Utils.getRandomInt(0,2)));
				additionalDices[i].x = animRollDices[i].x;
				additionalDices[i].y = animRollDices[i].y;
				additionalDices[i].addEventListener(TouchEvent.TOUCH, onDiceTouch);
				addChild(additionalDices[i]);
				
				animRollDices[i].stop();
				Starling.juggler.removeTweens(animRollDices[i]);
				removeChild(animRollDices[i]);
				animRollDices[i].dispose();
			}
			animRollDices = null;
			canClick = true;
		}
		
		private function onDiceTouch(e:TouchEvent):void 
		{
			if (e.getTouch(e.target as DisplayObject, TouchPhase.BEGAN) && canClick){
				//(e.target as Dice).select();
				trace(e.target)
			}
		}
		
	}

}