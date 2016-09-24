package bones.rating 
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

	import bones.events.Navigation;
	import bones.data.Constants;
	import bones.data.Images;
	import bones.data.Data;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Rating extends Sprite 
	{
		private var button:Button;
		private var image:Image;
		private var quad:Quad;
		private var textField:TextField;
		
		public function Rating() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
			
			name = Constants.RATING;
			createQuad();
			createBackground();
			createButtons();
			ratingShow();
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			button.dispose();
			image.dispose();
			quad.dispose();
			textField.dispose();
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
			var bitmap:Bitmap = new Images.ImgRating();
			image = new Image(Texture.fromBitmap(bitmap));
			image.x = (Constants.GAME_WINDOW_WIDTH / 2) - (image.width / 2);
			image.y = (Constants.GAME_WINDOW_HEIGHT / 2) - (image.height / 2);
			addChild(image);
			bitmap = null;
		}
		
		private function createButtons():void
		{
			var bitmap:Bitmap = new Images.ImgButtonClose();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.RATING_BUTTON_CLOSE;
			button.x = (Constants.GAME_WINDOW_WIDTH / 2) - (button.width / 1.15);
			button.y = image.height - 50;
			addChild(button);
			
			bitmap = null;
		}
		
		private function ratingShow():void
		{
			var userName:String = "Вы";
			if (Data.userFirstName != null) {
				userName = Data.userFirstName + " " + Data.userLastName;
			}
			
			var textFormat:TextFormat = new TextFormat("Monotype Corsiva", 48, 0x5C2D15, "center", "center");
			textField = new TextField(image.width, 60, "Тысяча", textFormat);
			textField.x = image.x;
			textField.y = 55;
			addChild(textField);
			
			textFormat = new TextFormat("Monotype Corsiva", 16, 0x5C2D15, "left", "center");
			var userWentUp:Boolean = false;
			var n:int = 0;
			var i:int = 0;
			for (i = 0; i < Data.ratingThousand.length; i++){
				if (Data.userRatingThousand >= Data.ratingThousand[i][1] && userWentUp == false) {
					setText(100, n, userName, Data.userRatingThousand, "очков", textFormat);
					userWentUp = true;
					n++;
				}
				setText(100, n, Data.ratingThousand[i][0], Data.ratingThousand[i][1], Data.ratingThousand[i][2], textFormat);
				n++;
			}
			
			if (userWentUp == false){
				setText(100, n, userName, Data.userRatingThousand, "очков", textFormat);
			}
			
			textFormat = new TextFormat("Monotype Corsiva", 48, 0x5C2D15, "center", "center");
			textField = new TextField(image.width, 60, "Семёрка", textFormat);
			textField.x = image.x;
			textField.y = 320;
			addChild(textField);
			
			textFormat = new TextFormat("Monotype Corsiva", 16, 0x5C2D15, "left", "center");
			userWentUp = false;
			n = 0;
			for (i = 0; i < Data.ratingSevens.length; i++){
				if (Data.userRatingSevens >= Data.ratingSevens[i][1] && userWentUp == false) {
					setText(375, n, userName, Data.userRatingSevens, "очков", textFormat);
					userWentUp = true;
					n++;
				}
				setText(375, n, Data.ratingSevens[i][0], Data.ratingSevens[i][1], Data.ratingSevens[i][2], textFormat);
				n++;
			}
			
			if (userWentUp == false){
				setText(375, n, userName, Data.userRatingSevens, "очков", textFormat);
			}
			
			userName = null;
			textFormat = null;
		}
		
		private function setText(y:Number, n:Number, name:String, score:Number, text:String, textFormat:TextFormat):void {
			textField = new TextField(195, 25, (String)(n+1) + " " + name, textFormat);
			textField.x = image.x + 50;
			textField.y = y + (20 * n);
			textField.wordWrap = false;
			addChild(textField);
			textField = new TextField(150, 25, score + " " + text, textFormat);
			textField.x = image.x + 250;
			textField.y = y + (20 * n);
			addChild(textField);
		}
		
		private function onButtonsClick(e:Event):void 
		{
			switch(Button(e.target).name){
				case Constants.RATING_BUTTON_CLOSE:
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