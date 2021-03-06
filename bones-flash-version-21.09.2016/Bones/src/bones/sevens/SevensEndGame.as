package bones.sevens 
{
	import flash.system.*;
	import flash.display.Bitmap;
	
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.animation.Tween;
	import starling.core.Starling;

	
	import bones.events.Navigation;
	import bones.data.Constants;
	import bones.data.Images;
	import bones.data.Data;
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class SevensEndGame extends Sprite 
	{
		private var sprite:Sprite;
		private var button:Button;
		private var image:Image;
		private var quad:Quad;
		private var tween:Tween;
		private var textField:TextField;
		
		public function SevensEndGame() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
			
			name = Constants.SEVENS_END_GAME;
			createQuad();
			createBackground();
			createRating();
			createButtons();
			tweenStart();
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			Starling.juggler.remove(tween);
			tween = null;
			
			button.dispose();
			image.dispose();
			quad.dispose();
			textField.dispose();
			sprite.dispose();
			while (this.numChildren) {
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			super.dispose();
			System.gc();
		}
		
		private function createQuad():void
		{
			quad = new Quad(Constants.GAME_WINDOW_WIDTH, Constants.GAME_WINDOW_HEIGHT,  0x000000);
			quad.alpha = 0.5;
			quad.x = 0 - this.x;
			quad.y = 0 - this.y;
			this.addChild(quad);
		}
		
		private function createBackground():void
		{
			sprite = new Sprite();
			sprite.x = 0;
			sprite.y = -500;
			addChild(sprite);
			
			var bitmap:Bitmap = new Images.ImgLostGame();
			image = new Image(Texture.fromBitmap(bitmap));
			image.x = (Constants.GAME_WINDOW_WIDTH / 2) - (image.width / 2);
			image.y = (Constants.GAME_WINDOW_HEIGHT / 2) - (image.height / 2);
			sprite.addChild(image);
			bitmap = null;
		}
		
		private function createRating():void 
		{
			var userName:String = "Вы";
			if (Data.userFirstName != null) {
				userName = Data.userFirstName + " " + Data.userLastName;
			}
			
			var textFormat:TextFormat = new TextFormat("Monotype Corsiva", 48, 0x5C2D15, "center", "center");
			textField = new TextField(image.width, 60, "Семёрка", textFormat);
			textField.x = image.x;
			textField.y = 100;
			sprite.addChild(textField);
			
			textFormat = new TextFormat("Monotype Corsiva", 26, 0x5C2D15, "center", "center");
			textField = new TextField(image.width, 35, "Рейтинг игроков", textFormat);
			textField.x = image.x;
			textField.y = 150;
			sprite.addChild(textField);
			
			textFormat = new TextFormat("Monotype Corsiva", 18, 0x5C2D15, "left", "center");
			var userWentUp:Boolean = false;
			var n:int = 0;
			for (var i:int = 0; i < Data.ratingSevens.length; i++){
				if (Data.userRatingSevens >= Data.ratingSevens[i][1] && userWentUp == false) {
					setText(200, n, userName, Data.userRatingSevens, "очков", textFormat);
					userWentUp = true;
					n++;
				}
				setText(200, n, Data.ratingSevens[i][0], Data.ratingSevens[i][1], Data.ratingSevens[i][2], textFormat);
				n++;
			}
			
			if (userWentUp == false){
				setText(200, n, userName, Data.userRatingSevens, "очков", textFormat);
			}
			
			userName = null;
			textFormat = null;
			
		}
		
		private function setText(y:Number, n:Number, name:String, score:Number, text:String, textFormat:TextFormat):void {
			textField = new TextField(195, 25, (String)(n+1) + " " + name, textFormat);
			textField.x = image.x + 50;
			textField.y = y + (20 * n);
			textField.wordWrap = false;
			sprite.addChild(textField);
			textField = new TextField(150, 25, score + " " + text, textFormat);
			textField.x = image.x + 250;
			textField.y = y + (20 * n);
			sprite.addChild(textField);
		}
		
		private function createButtons():void
		{
			var bitmap:Bitmap = new Images.ImgButtonRestartGame();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.SEVENS_END_GAME_BUTTON_RESTART_GAME;
			button.x = image.x - (button.width / 4);
			button.y = image.height + 55;
			sprite.addChild(button);
			
			bitmap = new Images.ImgButtonBackMenu();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.SEVENS_END_GAME_BUTTON_BACK_MENU;
			button.x = image.width + 55;
			button.y = image.height + 55;
			sprite.addChild(button);
			
			bitmap = null;
		}
		
		private function tweenStart():void
		{
			tween = new Tween(sprite, 1.0);
			tween.moveTo(0, 0);
			tween.onComplete = tweenComplete;
			Starling.juggler.add(tween);
		}
		
		private function tweenComplete():void
		{
			
		}
		
		private function onButtonsClick(e:Event):void 
		{
			switch(Button(e.target).name){
				case Constants.SEVENS_END_GAME_BUTTON_RESTART_GAME:
				{
					dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(e.target).name }));
					break;
				}
				case Constants.SEVENS_END_GAME_BUTTON_BACK_MENU:
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
	}

}