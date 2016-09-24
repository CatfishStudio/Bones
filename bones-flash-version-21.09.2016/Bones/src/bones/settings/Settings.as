package bones.settings 
{
	import flash.system.*;
	import flash.display.Bitmap;
	
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.display.Image;
	import starling.display.Quad;
	
	import bones.events.Navigation;
	import bones.data.Constants;
	import bones.data.Images;
	import bones.Config;
	import bones.data.Sounds;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Settings extends Sprite 
	{
		private var button:Button;
		private var image:Image;
		private var quad:Quad;
		
		public function Settings() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
			
			name = Constants.SETTINGS;
			createQuad();
			createBackground();
			createButtons();
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			button.dispose();
			image.dispose();
			quad.dispose();
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
			var bitmap:Bitmap = new Images.ImgWindowSettings();
			image = new Image(Texture.fromBitmap(bitmap));
			image.x = (Constants.GAME_WINDOW_WIDTH / 2) - (image.width / 2);
			image.y = (Constants.GAME_WINDOW_HEIGHT / 2) - (image.height / 2);
			addChild(image);
			bitmap = null;
		}
		
		private function createButtons():void
		{
			var bitmap:Bitmap;
			if (Config.soundOn == true){
				bitmap = new Images.ImgButtonSettingsSoundOn();
			}else{
				bitmap = new Images.ImgButtonSettingsSoundOff();
			}
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.SETTINGS_BUTTON_SOUND;
			button.x = (Constants.GAME_WINDOW_WIDTH / 2) - (button.width / 2);
			button.y = image.y + 100;
			addChild(button);
			
			bitmap = new Images.ImgButtonClose();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.SETTINGS_BUTTON_CLOSE;
			button.x = (Constants.GAME_WINDOW_WIDTH / 2) - (button.width / 2);
			button.y = image.y + 150;
			addChild(button);
			
			bitmap = null;
		}
		
		private function updateSettings():void 
		{
			var bitmap:Bitmap;
			if (Config.soundOn == true){
				Config.soundOn = false;
				bitmap = new Images.ImgButtonSettingsSoundOff();
				button = Button(getChildByName(Constants.SETTINGS_BUTTON_SOUND));
				button.upState = Texture.fromBitmap(bitmap);
			}else{
				Config.soundOn = true;
				bitmap = new Images.ImgButtonSettingsSoundOn();
				button = Button(getChildByName(Constants.SETTINGS_BUTTON_SOUND));
				button.upState = Texture.fromBitmap(bitmap);
			}
			bitmap = null;
		}
		
		private function onButtonsClick(e:Event):void 
		{
			switch(Button(e.target).name){
				case Constants.SETTINGS_BUTTON_SOUND:
				{
					Sounds.PlaySound(Sounds.Sound3);
					updateSettings();
					break;
				}
				case Constants.SETTINGS_BUTTON_CLOSE:
				{
					Sounds.PlaySound(Sounds.Sound4);
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