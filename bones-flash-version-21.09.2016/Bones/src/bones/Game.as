package bones 
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	import bones.events.Navigation;
	import bones.data.Constants;
	import bones.data.Sounds;
	import bones.data.Atlases;
	import bones.menu.Menu;
	import bones.settings.Settings;
	import bones.help.Help;
	import bones.rating.Rating;
	import bones.sevens.Sevens;
	import bones.sevens.SevensHelp;
	import bones.sevens.SevensEndGame;
	import bones.sevens.SevensWinGame;
	import bones.thousand.Thousand;
	import bones.thousand.ThousandEndGame;
	import bones.thousand.ThousandHelp;
	import bones.thousand.ThousandWinGame;
	import bones.data.Data;
	import bones.vkAPI.VK;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Game extends Sprite 
	{
		private var _thousand:Thousand;
		public function Game() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Navigation.CHANGE_SCREEN, onChangeScreen);
			
			initGameTextureAtlas();
			menu();
		}
		
		private function initGameTextureAtlas():void 
		{
			Atlases.setTextureAtlasEmbeddedAsset(Atlases.AtlasAnim, Atlases.XmlAtlasAnim);
			Atlases.setTextureAtlasFromBitmap(Atlases.AtlasDice, Atlases.XmlAtlasDice);
			
		}
		
		
		private function menu():void
		{
			if (getChildByName(Constants.MENU) != null) {
				removeChild(getChildByName(Constants.MENU));
			}else{
				//windowAllClose();
				addChild(new Menu());
			}
		}
		
		private function settings():void
		{
			Sounds.PlaySound(Sounds.Sound4);
			if (getChildByName(Constants.SETTINGS) != null)
			{
				removeChild(getChildByName(Constants.SETTINGS));
				if (_thousand != null) _thousand.Pause(false);
			}
			else
			{
				if (_thousand != null) _thousand.Pause(true);
				addChild(new Settings());
			}
		}
		
		private function help():void
		{
			Sounds.PlaySound(Sounds.Sound4);
			if (getChildByName(Constants.HELP) != null)
			{
				removeChild(getChildByName(Constants.HELP));
			}
			else
			{
				addChild(new Help());
			}
		}
		
		private function rating():void
		{
			Sounds.PlaySound(Sounds.Sound4);
			if (getChildByName(Constants.RATING) != null)
			{
				removeChild(getChildByName(Constants.RATING));
			}
			else
			{
				addChild(new Rating());
			}
		}
		
		private function sevens():void
		{
			Sounds.PlaySound(Sounds.Sound3);
			if (getChildByName(Constants.SEVENS) != null)
			{
				removeChild(getChildByName(Constants.SEVENS));
			}
			else
			{
				addChild(new Sevens());
			}
		}
		
		private function sevensHelp():void
		{
			Sounds.PlaySound(Sounds.Sound4);
			if (getChildByName(Constants.SEVENS_HELP) != null)
			{
				removeChild(getChildByName(Constants.SEVENS_HELP));
			}
			else
			{
				addChild(new SevensHelp());
			}
		}
		
		private function sevensEndGame():void
		{
			Sounds.PlaySound(Sounds.Sound4);
			if (getChildByName(Constants.SEVENS_END_GAME) != null)
			{
				removeChild(getChildByName(Constants.SEVENS_END_GAME));
			}
			else
			{
				addChild(new SevensEndGame());
			}
		}
		
		private function sevensWinGame():void
		{
			Sounds.PlaySound(Sounds.Sound4);
			if (getChildByName(Constants.SEVENS_WIN) != null)
			{
				removeChild(getChildByName(Constants.SEVENS_WIN));
			}
			else
			{
				addChild(new SevensWinGame());
			}
		}
		
		private function thousand():void
		{
			Sounds.PlaySound(Sounds.Sound3);
			if (getChildByName(Constants.THOUSAND) != null)
			{
				removeChild(_thousand);
				_thousand.dispose();
				_thousand = null;
			}
			else
			{
				_thousand = new Thousand();
				addChild(_thousand);
			}
		}
		
		private function thousandHelp():void
		{
			Sounds.PlaySound(Sounds.Sound4);
			if (getChildByName(Constants.THOUSAND_HELP) != null)
			{
				removeChild(getChildByName(Constants.THOUSAND_HELP));
				if (_thousand != null) _thousand.Pause(false);
			}
			else
			{
				if (_thousand != null) _thousand.Pause(true);
				addChild(new ThousandHelp());
			}
		}
		
		private function thousandEndGame():void
		{
			Sounds.PlaySound(Sounds.Sound4);
			if (getChildByName(Constants.THOUSAND_END_GAME) != null)
			{
				removeChild(getChildByName(Constants.THOUSAND_END_GAME));
			}
			else
			{
				if (_thousand != null) _thousand.Pause(true);
				addChild(new ThousandEndGame());
			}
		}
	
		private function thousandWinGame():void
		{
			Sounds.PlaySound(Sounds.Sound4);
			if (getChildByName(Constants.THOUSAND_WIN) != null)
			{
				removeChild(getChildByName(Constants.THOUSAND_WIN));
			}
			else
			{
				if (_thousand != null) _thousand.Pause(true);
				addChild(new ThousandWinGame());
			}
		}
		
		private function windowAllClose():void
		{
			if (getChildByName(Constants.SETTINGS) != null) removeChild(getChildByName(Constants.SETTINGS));
			/*
			if (getChildByName(Constants.WINDOW_BACK_MENU) != null)	removeChild(getChildByName(Constants.WINDOW_BACK_MENU));
			if (getChildByName(Constants.WINDOW_BACK_STAIRS) != null) removeChild(getChildByName(Constants.WINDOW_BACK_STAIRS));
			if (getChildByName(Constants.WINDOW_ENDED_LIFE) != null)removeChild(getChildByName(Constants.WINDOW_ENDED_LIFE));
			if (getChildByName(Constants.WINDOW_LOST) != null)	removeChild(getChildByName(Constants.WINDOW_LOST));
			if (getChildByName(Constants.WINDOW_VICTORY) != null) removeChild(getChildByName(Constants.WINDOW_VICTORY));
			if (getChildByName(Constants.WINDOW_END_GAME) != null) removeChild(getChildByName(Constants.WINDOW_END_GAME));
			*/
		}
	
	
		private function onChangeScreen(event:Navigation):void 
		{
			switch(event.data.id)
			{
				// THOUSAND --------------------
				case Constants.MENU_BUTTON_THOUSAND:
				{
					thousand();
					menu();
					break;
				}
				case Constants.THOUSAND_LOST:
				{
					thousandEndGame();
					break;
				}
				case Constants.THOUSAND_WIN:
				{
					thousandWinGame();
					break;
				}
				case Constants.THOUSAND_BUTTON_END_GAME:
				{
					thousandEndGame();
					break;
				}
				case Constants.THOUSAND_BUTTON_HELP:
				{
					thousandHelp();
					break;
				}
				case Constants.THOUSAND_HELP_BUTTON_CLOSE:
				{
					thousandHelp();
					break;
				}
				case Constants.THOUSAND_END_GAME_BUTTON_RESTART_GAME:
				{
					thousandEndGame();
					thousand();
					thousand();
					break;
				}
				case Constants.THOUSAND_END_GAME_BUTTON_BACK_MENU:
				{
					thousandEndGame();
					thousand();
					menu();
					break;
				}
				case Constants.THOUSAND_WIN_GAME_BUTTON_RESTART_GAME:
				{
					thousandWinGame();
					thousand();
					thousand();
					break;
				}
				case Constants.THOUSAND_WIN_GAME_BUTTON_BACK_MENU:
				{
					thousandWinGame();
					thousand();
					menu();
					break;
				}
				//------------------------------
				// SEVENS ----------------------
				case Constants.MENU_BUTTON_SEVENS:
				{
					sevens();
					menu();
					break;
				}
				case Constants.SEVENS_LOST:
				{
					sevensEndGame();
					break;
				}
				case Constants.SEVENS_WIN:
				{
					sevensWinGame();
					break;
				}
				case Constants.SEVENS_BUTTON_END_GAME:
				{
					sevensEndGame();
					break;
				}
				case Constants.SEVENS_BUTTON_HELP:
				{
					sevensHelp();
					break;
				}
				case Constants.SEVENS_HELP_BUTTON_CLOSE:
				{
					sevensHelp();
					break;
				}
				case Constants.SEVENS_END_GAME_BUTTON_RESTART_GAME:
				{
					sevensEndGame();
					sevens();
					sevens();
					break;
				}
				case Constants.SEVENS_END_GAME_BUTTON_BACK_MENU:
				{
					sevensEndGame();
					sevens();
					menu();
					break;
				}
				case Constants.SEVENS_WIN_GAME_BUTTON_RESTART_GAME:
				{
					sevensWinGame();
					sevens();
					sevens();
					break;
				}
				case Constants.SEVENS_WIN_GAME_BUTTON_BACK_MENU:
				{
					sevensWinGame();
					sevens();
					menu();
					break;
				}
				//------------------------------
				case Constants.BUTTON_SETTINGS:
				{
					settings();
					break;
				}
				case Constants.SETTINGS_BUTTON_CLOSE:
				{
					settings();
					break;
				}
				case Constants.MENU_BUTTON_IVENT:
				{
					// VK
					VK.vkConnection.callMethod("showInviteBox");
					break;
				}				
				case Constants.MENU_BUTTON_HELP:
				{
					help();
					break;
				}
				case Constants.HELP_BUTTON_CLOSE:
				{
					help();
					break;
				}
				case Constants.MENU_BUTTON_RATING:
				{
					rating();
					break;
				}
				case Constants.RATING_BUTTON_CLOSE:
				{
					rating();
					break;
				}
				case Constants.BUTTON_POST_SEVENS:
				{
					// POST
					VK.vkConnection.api('wall.post', { message: 'Игры в кости - Тысяча и Семёрка. \nЯ прошел игру Семёрка! \nНабрал ' + Data.userRatingSevens + ' очков. \nПрисоединяйтесь к игре https://vk.com/app5380703', attachments : 'photo-62618339_409463964' } , function(data) {} , function(data) {} );
					break;
				}
				case Constants.BUTTON_POST_THOUSAND:
				{
					// POST
					VK.vkConnection.api('wall.post', { message: 'Игры в кости - Тысяча и Семёрка. \nЯ прошел игру Тысяча! \nНабрал ' + Data.userRatingThousand + ' очков. \nПрисоединяйтесь к игре https://vk.com/app5380703', attachments : 'photo-62618339_409463964' } , function(data) {} , function(data) {} );
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