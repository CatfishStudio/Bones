package bones 
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	import bones.events.Navigation;
	import bones.data.Constants;
	import bones.menu.Menu;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Game extends Sprite 
	{
		
		public function Game() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Navigation.CHANGE_SCREEN, onChangeScreen);
			
			//initGameTextureAtlas();
			menu();
		}
		
		
		private function menu():void
		{
			if (getChildByName(Constants.MENU) != null) {
				removeChild(getChildByName(Constants.MENU));
			}else{
				windowAllClose();
				addChild(new Menu());
			}
		}
	
		private function windowAllClose():void
		{
			/*
			if (getChildByName(Constants.WINDOW_BACK_MENU) != null)	removeChild(getChildByName(Constants.WINDOW_BACK_MENU));
			if (getChildByName(Constants.WINDOW_BACK_STAIRS) != null) removeChild(getChildByName(Constants.WINDOW_BACK_STAIRS));
			if (getChildByName(Constants.WINDOW_ENDED_LIFE) != null)removeChild(getChildByName(Constants.WINDOW_ENDED_LIFE));
			if (getChildByName(Constants.WINDOW_LOST) != null)	removeChild(getChildByName(Constants.WINDOW_LOST));
			if (getChildByName(Constants.WINDOW_VICTORY) != null) removeChild(getChildByName(Constants.WINDOW_VICTORY));
			if (getChildByName(Constants.WINDOW_END_GAME) != null) removeChild(getChildByName(Constants.WINDOW_END_GAME));
			if (getChildByName(Constants.SETTINGS) != null) removeChild(getChildByName(Constants.SETTINGS));
			*/
		}
	
	
		private function onChangeScreen(event:Navigation):void 
		{
			switch(event.data.id)
			{
				case Constants.MENU_BUTTON_THOUSAND:
				{
					break;
				}				
				case Constants.MENU_BUTTON_SEVENS:
				{
					break;
				}				
				case Constants.MENU_BUTTON_SETTINGS:
				{
					break;
				}				
				case Constants.MENU_BUTTON_IVENT:
				{
					break;
				}				
				case Constants.MENU_BUTTON_HELP:
				{
					break;
				}				
				case Constants.MENU_BUTTON_RATING:
				{
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