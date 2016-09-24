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
	
	import bones.events.Navigation;
	import bones.data.Constants;
	import bones.data.Images;
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class SevensHelp extends Sprite 
	{
		private var button:Button;
		private var image:Image;
		private var quad:Quad;
		
		public function SevensHelp() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
			
			name = Constants.SEVENS_HELP;
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
			var bitmap:Bitmap = new Images.ImgHelpSevens();
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
			button.name = Constants.SEVENS_HELP_BUTTON_CLOSE;
			button.x = (Constants.GAME_WINDOW_WIDTH / 2) - (button.width / 1.15);
			button.y = image.height - 50;
			addChild(button);
			
			bitmap = null;
		}
		
		private function onButtonsClick(e:Event):void 
		{
			switch(Button(e.target).name){
				case Constants.SEVENS_HELP_BUTTON_CLOSE:
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