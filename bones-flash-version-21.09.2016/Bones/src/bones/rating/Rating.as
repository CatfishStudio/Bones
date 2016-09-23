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
			var textFormat:TextFormat = new TextFormat("Monotype Corsiva", 48, 0x5C2D15, "center", "center");
			textField = new TextField(image.width, 50, "Тысяча", textFormat);
			textField.x = image.x;
			textField.y = 55;
			addChild(textField);
			
			textFormat = new TextFormat("Monotype Corsiva", 16, 0x5C2D15, "left", "center");
			var i:Number = 0;
			for (i = 0; i < Data.ratingThousand.length; i++){
				
				textField = new TextField(image.width, 25, (String)(i+1) + " " + Data.ratingThousand[i][0], textFormat);
				textField.x = image.x + 50;
				textField.y = 100 + (25 * i);
				addChild(textField);
				textField = new TextField(image.width, 25, Data.ratingThousand[i][1] + " " + Data.ratingThousand[i][2], textFormat);
				textField.x = image.x + 250;
				textField.y = 100 + (25 * i);
				addChild(textField);
			}
			
			textFormat = new TextFormat("Monotype Corsiva", 48, 0x5C2D15, "center", "center");
			textField = new TextField(image.width, 50, "Семёрка", textFormat);
			textField.x = image.x;
			textField.y = 320;
			addChild(textField);
			
			textFormat = new TextFormat("Monotype Corsiva", 16, 0x5C2D15, "left", "center");
			for (i = 0; i < Data.ratingSevens.length; i++){
				
				textField = new TextField(image.width, 25, (String)(i+1) + " " + Data.ratingSevens[i][0], textFormat);
				textField.x = image.x + 50;
				textField.y = 375 + (25 * i);
				addChild(textField);
				textField = new TextField(image.width, 25, Data.ratingSevens[i][1] + " " + Data.ratingSevens[i][2], textFormat);
				textField.x = image.x + 250;
				textField.y = 375 + (25 * i);
				addChild(textField);
			}
			
			textFormat = null;
			i = null;
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