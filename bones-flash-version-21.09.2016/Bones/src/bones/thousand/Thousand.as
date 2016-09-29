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
		private var button:Button;
		
		private var gameOver:Boolean;
		
		
		private var messageText:TextField;
		private var buttonApply:Button;
		private var buttonCancel:Button;
		private var boxDice:Array;
		private var players:Array
		private var diceCountMax:int;
		private var score:int;
		private var playerIndex:int;
		private var timer:Timer;
		private var pause:Boolean;
		
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
			
			gameOver = false;
			score = 0;
			
			createBackground();
			createButtons();
			createMessage();
			createPlayers();
			
			trace('[THOUSAND]: added to stage');
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			while (this.numChildren) {
				this.removeChildren(0, -1, true);
			}
			
			image.dispose();
			image = null;
			button.dispose();
			button = null;
			
			messageText.dispose();
			messageText = null;
			buttonApply.dispose();
			buttonApply = null;
			buttonCancel.dispose();
			buttonCancel = null;
			boxDice = null;
			players = null;
			timer.stop();
			timer = null;			
			
			this.removeFromParent(true);
			super.dispose();
			System.gc();
			
			trace('[THOUSAND]: removed from stage');
		}
		
		private function onButtonsClick(e:Event):void 
		{
			switch(Button(e.target).name){
				case Constants.THOUSAND_BUTTON_HELP:
				{
					dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(e.target).name }));
					break;
				}
				case Constants.THOUSAND_BUTTON_END_GAME:
				{
					Data.userRatingThousand = score;
					if (gameOver == false){
						gameOver = true;
						dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(e.target).name }));
					}
					break;
				}
				case Constants.BUTTON_SETTINGS:
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
			var bitmap:Bitmap = new Images.ImgThousand();
			image = new Image(Texture.fromBitmap(bitmap));
			image.x = 0;
			image.y = 0;
			addChild(image);
			bitmap = null;
		}
		
		private function createButtons():void
		{
			var bitmap:Bitmap = new Images.ImgButtonEndGame();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.THOUSAND_BUTTON_END_GAME;
			button.x = 15;
			button.y = Constants.GAME_WINDOW_HEIGHT - 60;
			addChild(button);
			
			bitmap = new Images.ImgButtonSettings();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.BUTTON_SETTINGS;
			button.x = (Constants.GAME_WINDOW_WIDTH / 2) - (button.width / 2);
			button.y = Constants.GAME_WINDOW_HEIGHT - 60;
			addChild(button);
			
			bitmap = new Images.ImgButtonHelp();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.THOUSAND_BUTTON_HELP;
			button.x = (Constants.GAME_WINDOW_WIDTH - button.width - 15);
			button.y = Constants.GAME_WINDOW_HEIGHT - 60;
			addChild(button);
			
			bitmap = null;
		}
		
		
		private function createMessage():void
		{
			var textFormat:TextFormat = new TextFormat("Arial", 18, 0xFFFFFF, "center", "center");
			messageText = new TextField(300, 100, "Чтобы вступить в игру. Вам необходимо набрать 75 очков!", textFormat);
			messageText.x = 280;
			messageText.y = 100;
			addChild(messageText);
			textFormat = null;
		}
		
		private function createPlayers():void
		{
			var textFormat:TextFormat = new TextFormat("Arial", 18, 0xFFFFFF, "left", "center");
			
			score = 0;
			playerIndex = 0;
			players = [
				["Вы", new TextField(200, 50, "Вы", textFormat), 0, false, 45, 533],
				["Джек", new TextField(200, 50, "Джек", textFormat), 0, false, 45, 240],
				["Барбосса", new TextField(200, 50, "Барбосса", textFormat), 0, false, 628, 240],
				["Анжелика", new TextField(200, 50, "Анжелика", textFormat), 0, false, 628, 533]
			];
			
			var i:int;
			for (i = 0; i < players.length; i++){
				(players[i][1] as TextField).text += ": не вступил.";
				(players[i][1] as TextField).x = players[i][4];
				(players[i][1] as TextField).y = players[i][5];
				addChild((players[i][1] as TextField));
			}
		}
	}

}