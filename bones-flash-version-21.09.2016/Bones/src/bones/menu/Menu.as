package bones.menu 
{
	import flash.system.*;
	import flash.display.Bitmap;
	
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.display.Image;
	
	import bones.events.Navigation;
	import bones.data.Constants;
	import bones.data.Images;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Menu extends Sprite 
	{
		private var button:Button;
		private var image:Image;
		
		public function Menu() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
			name = Constants.MENU;
			createBackground();
			createButtons();
			
			trace('[MENU]: added to stage');
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			image.dispose();
			image = null;
			button.dispose();
			button = null;
			while (this.numChildren)
			{
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			super.dispose();
			System.gc();
			
			trace('[MENU]: removed from stage');
		}
		
		private function onButtonsClick(e:Event):void 
		{
			//trace(Button(e.target).name);
			dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(e.target).name }));
		}
		
		private function createBackground():void
		{
			var bitmap:Bitmap = new Images.ImgBackground();
			image = new Image(Texture.fromBitmap(bitmap));
			addChild(image);
			bitmap = null;
		}
		
		private function createButtons():void
		{
			var bitmap:Bitmap = new Images.ImgButton1000();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.MENU_BUTTON_THOUSAND;
			button.x = (Constants.GAME_WINDOW_WIDTH / 2) - (button.width / 2);
			button.y = 150;
			addChild(button);
			
			bitmap = new Images.ImgButton7();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.MENU_BUTTON_SEVENS;
			button.x = (Constants.GAME_WINDOW_WIDTH / 2) - (button.width / 2);
			button.y = 250;
			addChild(button);
			
			bitmap = new Images.ImgButtonSettings();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.BUTTON_SETTINGS;
			button.x = (Constants.GAME_WINDOW_WIDTH / 2) - (button.width / 2);
			button.y = 350;
			addChild(button);
			
			bitmap = new Images.ImgButtonIvent();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.MENU_BUTTON_IVENT;
			button.x = (Constants.GAME_WINDOW_WIDTH / 2) - (button.width / 2);
			button.y = 450;
			addChild(button);
			
			bitmap = new Images.ImgButtonHelp();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.MENU_BUTTON_HELP;
			button.x = (Constants.GAME_WINDOW_WIDTH / 2) - (button.width / 2);
			button.y = 550;
			addChild(button);
			
			bitmap = new Images.ImgButtonRating();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.MENU_BUTTON_RATING;
			button.x = (Constants.GAME_WINDOW_WIDTH / 2) - (button.width / 2);
			button.y = 650;
			addChild(button);
			
			bitmap = null;
		}
		
	}

}