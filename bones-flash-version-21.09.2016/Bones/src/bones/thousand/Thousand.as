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
		private var tween:Tween;
		private var animDices:Vector.<MovieClip>;
		
		
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
			createDice();
			
			trace('[THOUSAND]: added to stage');
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			var i:int;
			if (players != null){
				for (i = 0; i < players.length; i++){
					removeChild((players[i][1] as TextField));
					(players[i][1] as TextField).dispose();
					players[i][1] = null;
				}
				players = null;
			}
			
			if (boxDice != null){
				for (i = 0; i < boxDice.length; i++){
					removeChild(boxDice[i][4]);
					(boxDice[i][4] as Sprite).removeChildren(0, -1, true);
					(boxDice[i][4] as Sprite).dispose();
					boxDice[i][4] = null;
				}
				boxDice = null;
			}
			
			if (animDices != null){
				for (i = 0; i < animDices.length; i++){
					removeChild(animDices[i]);
					animDices[i].dispose();
					animDices[i] = null;
				}
				animDices = null;
			}
			
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
			
			if(timer != null){
				timer.stop();
				timer = null;		
			}
			
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
					Data.userRatingThousand = players[0][2];
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
				case "buttonApply":
				{
					buttonApply.visible = false;
					buttonCancel.visible = false;
					rollDice();
					break;
				}
				case "buttonCancel":
				{
					buttonApply.visible = false;
					buttonCancel.visible = false;
					onButtonCancel();
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
			
			bitmap = new Images.ImgButtonThrow();
			buttonApply = new Button(Texture.fromBitmap(bitmap));
			buttonApply.name = "buttonApply";
			buttonApply.scale = 0.7;
			buttonApply.x = 250;
			buttonApply.y = 200;
			addChild(buttonApply);
			
			bitmap = new Images.ImgButtonNotThrow();
			buttonCancel = new Button(Texture.fromBitmap(bitmap));
			buttonCancel.name = "buttonCancel";
			buttonCancel.scale = 0.7;
			buttonCancel.x = 435;
			buttonCancel.y = 200;
			addChild(buttonCancel);
			
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
				["Морган", new TextField(200, 50, "Морган", textFormat), 0, false, 45, 240],
				["Анжелика", new TextField(200, 50, "Анжелика", textFormat), 0, false, 628, 240],
				["Тэтч", new TextField(200, 50, "Тэтч", textFormat), 0, false, 628, 533]
			];
			
			var i:int;
			for (i = 0; i < players.length; i++){
				(players[i][1] as TextField).text += ": не вступил.";
				(players[i][1] as TextField).x = players[i][4];
				(players[i][1] as TextField).y = players[i][5];
				addChild((players[i][1] as TextField));
			}
		}
		
		private function createDice():void
		{
			this.pause = false;
			diceCountMax = 5;
			boxDice = [
				[1, false, 305, 595, new Sprite()],
				[2, false, 355, 595, new Sprite()],
				[3, false, 405, 595, new Sprite()],
				[4, false, 455, 595, new Sprite()],
				[5, false, 505, 595, new Sprite()],
			];
			
			animDices = new Vector.<MovieClip>();
			
			var i:int;
			for (i = 0; i < boxDice.length; i++){
				image = new Image(Atlases.textureAtlas.getTexture("anim_dice" + (String)(i + 1) + (String)(i + 1) + ".png"));
				(boxDice[i][4] as Sprite).x = boxDice[i][2];
				(boxDice[i][4] as Sprite).y = boxDice[i][3];
				(boxDice[i][4] as Sprite).addChild(image);
				addChild((boxDice[i][4] as Sprite));
				
				animDices.push(new MovieClip(Atlases.textureAtlasAnimation.getTextures("anim_dice_"), 12))
				animDices[i].name = i.toString();
				animDices[i].stop();
				animDices[i].visible = false;
				animDices[i].x = boxDice[i][2];
				animDices[i].y = boxDice[i][3];
				addChild(animDices[i]);
				Starling.juggler.add(animDices[i]);
			}
		}
		
		private function onButtonCancel():void
		{
			if (players[0][3] == true) {// если пользователь уже вошел в игру
				players[0][2] += score;
				(players[0][1] as TextField).text = players[0][0] + ": " + players[0][2];
			}else{ // пользователь ещё не вошел в игру
				if (score >= 75){ // пользователь набрал необходимое количество очков для входа
					players[0][2] += score;
					(players[0][1] as TextField).text = players[0][0] + ": " + players[0][2];
					players[0][3] = true;
				}
			}
			
			if (players[0][2] >= 1000){
				endGame("WIN");
			}else{
				score = 0;
				playerIndex++;
				diceCountMax = 5;
				var i:int;
				for (i = 0; i < boxDice.length; i++){
					boxDice[i][1] = false;
				}
				rollDiceAI();
			}
		}
		
		
		private function rollDice():void
		{
			Sounds.PlaySound(Sounds.Sound2);
			
			var i:int;
			var index:int;
			var newPosX:int;
			var newPosY:int;
			
			if (diceCountMax == 0) diceCountMax = 5;
			
			for (i = 0; i < boxDice.length; i++){
				if (boxDice[i][1] == false){
					index = Utils.getRandomInt(1, 7); // 1,2,3,4,5,6
					if (index == 0) index = 1;
					newPosX = 250 + (Math.random() / 0.1) * (i * 8);
					newPosY = 250 + (Math.random() / 0.1) * (i * 5);
					
					(boxDice[i][4] as Sprite).removeChildren(0, -1, true);
					image = new Image(Atlases.textureAtlas.getTexture("anim_dice" + index.toString() + index.toString() + ".png"));
					(boxDice[i][4] as Sprite).addChild(image);
					(boxDice[i][4] as Sprite).x = newPosX;
					(boxDice[i][4] as Sprite).y = newPosY;
					(boxDice[i][4] as Sprite).visible = false;
					boxDice[i][0] = index;
					
					animDices[i].x = boxDice[i][2];
					animDices[i].y = boxDice[i][3];
					animDices[i].play();
					animDices[i].visible = true;
					
					tween = new Tween(animDices[i], 1.0);
					tween.moveTo(newPosX, newPosY);
					tween.onComplete = onRollDiceTweenComplete;
					Starling.juggler.add(tween);
				}
				
			}
		}
		
		private function onRollDiceTweenComplete():void 
		{
			var i:int;
			var totalScore:int;
			diceCountMax--;
			if (diceCountMax == 0){
				
				Starling.juggler.remove(tween);
				tween = null;
				for (i = 0; i < animDices.length; i++){
					animDices[i].stop();
					animDices[i].visible = false;
					(boxDice[i][4] as Sprite).visible = true;
				}
				
				diceCountMax = 5;
				if (checkScoreDice() == true) { // что-то выпало
					if (diceCountMax == 0) { // если все кости принесли очки
						if (score < 0) { // если выпали 1,2,3,4,5 и у игрока -100 очков
							if (players[0][3] == false){ // Пользователь еще не вошел в игре (передаем ход дальше)
								buttonApply.visible = false;
								buttonCancel.visible = false;
								score = 0;
								playerIndex++;
								diceCountMax = 5;
								messageText.text = "Вы набрали -100 очков. Вы пропускаете этот ход.";
								for (i = 0; i < boxDice.length; i++){
									boxDice[i][1] = false;
								}
								timer = new Timer(2500, 1);
								timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
								timer.start(); 
							}else{ // Пользователь уже вошел в игру (отнимаем -100 и передаём ход дальше)
								buttonApply.visible = false;
								buttonCancel.visible = false;
								players[0][2] -= 100;
								(players[0][1] as TextField).text = players[0][0] + ": " + players[0][2];
								score = 0;
								playerIndex++;
								diceCountMax = 5;
								messageText.text = "Вы набрали -100 очков. Вы пропускаете этот ход.";
								for (i = 0; i < boxDice.length; i++){
									boxDice[i][1] = false;
								}
								timer = new Timer(2500, 1);
								timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
								timer.start(); 
							}
						}else{ // score > 0
							totalScore = score + players[0][2];
							if (score >= 1000 || totalScore >= 1000) {
								score = totalScore;
								messageText.text = "Вы победили!!!\n Вы набрали " + totalScore + " очков.";
								endGame("WIN");
							}else{
								messageText.text = "Вы набрали " + score + " очков. \nЖелаете бросить ещё?";
								if (diceCountMax == 0){
									for (i = 0; i < boxDice.length; i++){
										boxDice[i][1] = false;
									}
									buttonApply.visible = true;
									buttonCancel.visible = true;
								}
							}
						}
					}else{
						messageText.text = "Вы набрали " + score + " очков. \nЖелаете бросить ещё?";
						if (diceCountMax == 0){
							for (i = 0; i < boxDice.length; i++){
								boxDice[i][1] = false;
							}
						}
						buttonApply.visible = true;
						buttonCancel.visible = true;
						
						totalScore = score + players[0][2];
						if (totalScore >= 1000){
							score = totalScore;
							messageText.text = "Вы победили!!!\n Вы набрали " + totalScore + " очков.";
							endGame("WIN");
						}
					}
				} else{ // ничего не выпало
					score = 0;
					playerIndex++;
					diceCountMax = 5;
					messageText.text = "Вам ничего не выпало. Ход переходит к " + players[playerIndex][0] + ".";
					buttonApply.visible = false;
					buttonCancel.visible = false;
					for (i = 0; i < boxDice.length; i++){
						boxDice[i][1] = false;
					}
					timer = new Timer(2500, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
					timer.start(); 
				}
			}
		}
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			timer.stop();
			timer = null;
			if (pause == false) rollDiceAI();
		}
		
		private function rollDiceAI():void
		{
			Sounds.PlaySound(Sounds.Sound2);
			
			var i:int;
			var index:int;
			var newPosX:int;
			var newPosY:int;
			
			if (diceCountMax === 0) diceCountMax = 5;
			
			for (i = 0; i < boxDice.length; i++){
				if (boxDice[i][1] == false){
					index = Utils.getRandomInt(1, 7); // 1,2,3,4,5,6
					if (index == 0) index = 1;
					newPosX = 250 + (Math.random() / 0.1) * (i * 8);
					newPosY = 250 + (Math.random() / 0.1) * (i * 5);
					
					(boxDice[i][4] as Sprite).removeChildren(0, -1, true);
					image = new Image(Atlases.textureAtlas.getTexture("anim_dice" + index.toString() + index.toString() + ".png"));
					
					(boxDice[i][4] as Sprite).addChild(image);
					(boxDice[i][4] as Sprite).x = newPosX;
					(boxDice[i][4] as Sprite).y = newPosY;
					(boxDice[i][4] as Sprite).visible = false;
					boxDice[i][0] = index;
					
					animDices[i].x = boxDice[i][2];
					animDices[i].y = boxDice[i][3];
					animDices[i].play();
					animDices[i].visible = true;
					
					tween = new Tween(animDices[i], 1.0);
					tween.moveTo(newPosX, newPosY);
					tween.onComplete = onRollDiceAITweenComplete;
					Starling.juggler.add(tween);
				}
			}
		}
		
		private function onRollDiceAITweenComplete():void 
		{
			var i:int;
			var totalScore:int;
			diceCountMax--;
			
			if (diceCountMax == 0){
				
				Starling.juggler.remove(tween);
				tween = null;
				for (i = 0; i < animDices.length; i++){
					animDices[i].stop();
					animDices[i].visible = false;
					(boxDice[i][4] as Sprite).visible = true;
				}
				
				diceCountMax = 5;
				if (checkScoreDice() == true){ // что-то выпало (checkScoreDice изменяет значение diceCountMax)
					if (diceCountMax === 0) { // если все кости принесли очки
						if (score < 0) { // если выпали 1,2,3,4,5 и у игрока -100 очков
							if (players[playerIndex][3] == false) { // ИИ еще не вошел в игре (передаем ход дальше)
								if (playerIndex < 3){// ход переходит к следующему ИИ игроку
									playerIndex++;
									score = 0;
									diceCountMax = 5;
									messageText.text = players[playerIndex - 1][0] + " получил -100 очков.\nХод переходит к " + this.players[playerIndex][0];
									buttonApply.visible = false;
									buttonCancel.visible = false;
									for (i = 0; i < boxDice.length; i++){
										boxDice[i][1] = false;
									}
									timer = new Timer(2500, 1);
									timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
									timer.start(); 
								}else{ // ход переходит к пользователю
									if (timer != null) timer.stop();
									messageText.text = players[playerIndex][0] + " получил -100 очков.\nХод переходит к Вам.";
									score = 0;
									playerIndex = 0;
									diceCountMax = 5;
									buttonApply.visible = true;
									buttonCancel.visible = true;
									for (i = 0; i < boxDice.length; i++){
										boxDice[i][1] = false;
									}
								}
							}else{ // ИИ уже вошел в игру (отнимаем -100 и передаём ход дальше)
								players[playerIndex][2] -= 100;
								(players[playerIndex][1] as TextField).text = players[playerIndex][0] + ": " + players[playerIndex][2];
								
								if (playerIndex < 3) { // ход переходит к следующему ИИ игроку
									playerIndex++;
									score = 0;
									diceCountMax = 5;
									messageText.text = players[playerIndex - 1][0] + " получил -100 очков.\nХод переходит к " + players[playerIndex][0];
									buttonApply.visible = false;
									buttonCancel.visible = false;
									for (i = 0; i < boxDice.length; i++){
										boxDice[i][1] = false;
									}
									timer = new Timer(2500, 1);
									timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
									timer.start(); 
								} else { // ход переходит к пользователю
									if (timer != null) timer.stop();
									messageText.text = players[playerIndex][0] + " получил -100 очков.\nХод переходит к Вам.";
									score = 0;
									playerIndex = 0;
									diceCountMax = 5;
									buttonApply.visible = true;
									buttonCancel.visible = true;
									for (i = 0; i < boxDice.length; i++){
										boxDice[i][1] = false;
									}
								}
								
							}
						}else{ // score > 0
							totalScore = score + players[playerIndex][2];
							if (score >= 1000 || totalScore >= 1000) {
								endGame("LOST");
							}else{
								diceCountMax = 5;
								for (i = 0; i < boxDice.length; i++){
									boxDice[i][1] = false;
								}
								messageText.text = players[playerIndex][0] + " набрал " + score + " очков\nи продолжает бросать кости.";
								timer = new Timer(2500, 1);
								timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
								timer.start(); 
							}
						}
						
					}else{ // если еще остались кости которые не принесли очки
						if (players[playerIndex][3] == false){ // ИИ еще не вошел в игру
							if (score < 75) { // ИИ не набрал нужное количество очков, продолжает бросать кости
								messageText.text = players[playerIndex][0] + " набрал " + score + " очков\nи продолжает бросать кости.";
								timer = new Timer(2500, 1);
								timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
								timer.start(); 
							}else{ // ИИ набрал достаточно очков для входа и передаёт ход следующему игроку.
								players[playerIndex][2] += score;
								(players[playerIndex][1] as TextField).text = players[playerIndex][0] + ": " + players[playerIndex][2];
								players[playerIndex][3] = true;
								
								if (players[playerIndex][2] >= 1000){
									endGame("LOST");
								}else{
									
									if (playerIndex < 3) { // ход переходит к следующему ИИ игроку
										playerIndex++;
										messageText.text = players[playerIndex - 1][0] + " набрал " + score + " очков.\nХод переходит к " + players[playerIndex][0];
										score = 0;
										diceCountMax = 5;
										buttonApply.visible = false;
										buttonCancel.visible = false;
										for (i = 0; i < boxDice.length; i++){
											boxDice[i][1] = false;
										}
										timer = new Timer(2500, 1);
										timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
										timer.start(); 
									}else{ // ход переходит к пользователю
										if (timer != null) timer.stop();
										messageText.text = players[playerIndex][0] + " набрала " + score + " очков.\nХод переходит к Вам.";
										score = 0;
										playerIndex = 0;
										diceCountMax = 5;
										buttonApply.visible = true;
										buttonCancel.visible = true;
										for (i = 0; i < boxDice.length; i++){
											boxDice[i][1] = false;
										}
									}
								}
							}
						}else{ // ИИ уже вошел в игру
							totalScore = score + players[playerIndex][2];
							if (totalScore >= 1000) {
								messageText.text = players[playerIndex][0] + " набрал " + totalScore + " очков\nи победил!";
								endGame("LOST");
								return;
							}
							
							if (diceCountMax > 2) { // если очки принесли только 1-2 кубика - ИИ продолжает бросать
								messageText.text = players[playerIndex][0] + " набрал " + score + " очков\nи продолжает бросать кости.";
								timer = new Timer(2500, 1);
								timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
								timer.start(); 
							}else{ // если очки принесли 3 и блее кубиков - ИИ решает бросать сам
								if (Utils.getRandomInt(0, 10) > 5){ // ИИ кидает еще
									messageText.text = players[playerIndex][0] + " набрал " + score + " очков\nи продолжает бросать кости.";
									timer = new Timer(2500, 1);
									timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
									timer.start();
								}else{ // ИИ отказывается
									// сохраняем результат ИИ
									if (players[playerIndex][3] == true) { // если ИИ уже вошел в игру
										players[playerIndex][2] += score;
										(players[playerIndex][1] as TextField).text = players[playerIndex][0] + ": " + players[playerIndex][2];
									}else{ // ИИ ещё не вошел в игру
										if (score >= 75) { // ИИ набрал необходимое количество очков для входа
											players[playerIndex][2] += score;
											(players[playerIndex][1] as TextField).text = players[playerIndex][0] + ": " + players[playerIndex][2];
											players[playerIndex][3] = true;
										}
									}
									
									if (players[playerIndex][2] >= 1000) {
										endGame("LOST");
									}else{
										if (playerIndex < 3) { // ход переходит к следующему ИИ игроку
											playerIndex++;
											messageText.text = players[playerIndex - 1][0] + " набрал " + score + " очков.\nХод переходит к " + players[playerIndex][0];
											score = 0;
											diceCountMax = 5;
											buttonApply.visible = false;
											buttonCancel.visible = false;
											for (i = 0; i < boxDice.length; i++){
												boxDice[i][1] = false;
											}
											timer = new Timer(2500, 1);
											timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
											timer.start(); 
										}else{ // ход переходит к пользователю
											if (timer != null) timer.stop();
											messageText.text = players[playerIndex][0] + " набрала " + score + " очков.\nХод переходит к Вам.";
											score = 0;
											playerIndex = 0;
											diceCountMax = 5;
											buttonApply.visible = true;
											buttonCancel.visible = true;
											for (i = 0; i < boxDice.length; i++){
												boxDice[i][1] = false;
											}
										}
									}
								}
							}
						}
					}
				}else{ // ничего не выпало
					if (playerIndex < 3) { // ход переходит к следующему ИИ игроку
						playerIndex++;
						messageText.text = players[playerIndex - 1][0] + " ничего не выпало.\nХод переходит к " + players[playerIndex][0];
						score = 0;
						diceCountMax = 5;
						buttonApply.visible = false;
						buttonCancel.visible = false;
						for (i = 0; i < boxDice.length; i++){
							boxDice[i][1] = false;
						}
						timer = new Timer(2500, 1);
						timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
						timer.start(); 
					}else{ // ход переходит к пользователю
						if (timer != null) timer.stop();
						messageText.text = players[playerIndex][0] + " ничего не выпало.\nХод переходит к Вам.";
						score = 0;
						playerIndex = 0;
						diceCountMax = 5;
						buttonApply.visible = true;
						buttonCancel.visible = true;
						for (i = 0; i < boxDice.length; i++){
							boxDice[i][1] = false;
						}
					}
				}
			}
		}
		
		private function checkScoreDice():Boolean
		{
			var result: Boolean = false;
			if (checkDice5() == true){
				result = true;
			}else{
				if (checkDice4() == true){
					checkDice1();
					result = true;
				}else{
					if (checkDice3() == true){
						checkDice1();
						result = true;
					}else{
						if (checkDice1() == true) result = true;
					}
				}
			}
			return result;
		}
		
		private function checkDice5():Boolean
		{
			var i:int;
			var dice: Array = [];
			/* Поиск уникальной комбинации */
			for (i = 0; i < boxDice.length; i++){
				if (boxDice[i][1] === false) dice.push(boxDice[i][0]);
				else diceCountMax--;
			}
			
			dice.sort(function (valueA:int, valueB:int):int{
				return valueA - valueB;
			});
			
			if (dice.length == 5){
				if (dice[0] == 1 && dice[1] == 2 && dice[2] == 3 && dice[3] == 4 && dice[4] == 5){
					score = -100;
					selectDice(null);
					diceCountMax -= 5;
					return true;
				}
				if (dice[0] == 2 && dice[1] == 3 && dice[2] == 4 && dice[3] == 5 && dice[4] == 6){
					score += 200;
					selectDice(null);
					diceCountMax -= 5;
					return true;
				}
				if (dice[0] == dice[1] && dice[0] == dice[2] && dice[0] == dice[3] && dice[0] == dice[4]) {
					score += 1000;
					selectDice(null);
					diceCountMax -= 5;
					return true;
				}
			}else{
				return false;
			}
			return false;
		}
		
		private function checkDice4():Boolean
		{
			var i:int;
			var j:int;
			var dice: Array = [];
			/* Поиск одинаковых значений кубиков */
			for (i = 0; i < boxDice.length; i++){
				if (boxDice[i][1] == false){
					for (j = 0; j < boxDice.length; j++){
						if (i != j && boxDice[j][1] == false && boxDice[i][0] == boxDice[j][0]){
							dice.push(j);
						}
					}
					if (dice.length == 3){
						dice.push(i);
						if (boxDice[i][0] == 1) score += 100;
						if (boxDice[i][0] == 2) score += 200;
						if (boxDice[i][0] == 3) score += 300;
						if (boxDice[i][0] == 4) score += 400;
						if (boxDice[i][0] == 5) score += 500;
						if (boxDice[i][0] == 6) score += 600;
						selectDice(dice);
						diceCountMax -= 4;
						return true;
					} else {
						dice = [];
					}
				}
			}
			return false;
		}
		
		private function checkDice3():Boolean
		{
			var i:int;
			var j:int;
			var dice: Array = [];
			/* Поиск одинаковых значений кубиков */
			for (i = 0; i < boxDice.length; i++){
				if (boxDice[i][1] == false){
					for (j = 0; j < boxDice.length; j++){
						if (i != j && boxDice[j][1] == false && boxDice[i][0] == boxDice[j][0]){
							dice.push(j);
						}
					}
					if (dice.length == 2){
						dice.push(i);
						if (boxDice[i][0] == 1) score += 30;
						if (boxDice[i][0] == 2) score += 20;
						if (boxDice[i][0] == 3) score += 30;
						if (boxDice[i][0] == 4) score += 40;
						if (boxDice[i][0] == 5) score += 50;
						if (boxDice[i][0] == 6) score += 60;
						selectDice(dice);
						diceCountMax -= 3;
						return true;
					}else{
						dice = [];
					}
				}
			}
			return false;
		}
		
		private function checkDice1():Boolean
		{
			var i:int;
			var result:Boolean = false;
			var dice: Array = [];
			for (i = 0; i < boxDice.length; i++){
				if (boxDice[i][1] == false) {
					if (boxDice[i][0] == 1){
						result = true;
						score += 10;
						dice.push(i);
						diceCountMax -= 1;
					}
					if (boxDice[i][0] == 5){
						result = true;
						score += 5;
						dice.push(i);
						diceCountMax -= 1;
					}
				}
			}
			if (result == true) selectDice(dice);
			return result;
		}
		
		private function selectDice(dice:Array):void
		{
			var i:int;
			if (dice == null) {
				for (i = 0; i < boxDice.length; i++){
					boxDice[i][1] = false;
					tween = new Tween(boxDice[i][4], 0.5);
					tween.moveTo(boxDice[i][2], boxDice[i][3]);
					Starling.juggler.add(tween);
				}
			}else{
				var count:int = dice.length;
				for (i = 0; i < count; i++){
					boxDice[dice[i]][1] = true;
					tween = new Tween(boxDice[dice[i]][4], 0.5);
					tween.moveTo(boxDice[dice[i]][2], boxDice[dice[i]][3]);
					Starling.juggler.add(tween);
				}
			}
		}
		
		private function endGame(type:String):void
		{
			pause = true;
			if (timer != null) timer.stop();
			
			Data.userRatingThousand = players[0][2];
			
			if (type == "WIN"){
				if (gameOver == false){
					players[0][2] += score;
					Data.userRatingThousand = players[0][2];
					gameOver = true;
					timer = new Timer(1500, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, winGame); 
					timer.start();
					
				}
			}else{
				if (gameOver == false){
					gameOver = true;
					timer = new Timer(1500, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, lostGame); 
					timer.start();
				}
			}
		}
		
		private function winGame(e:TimerEvent):void
		{
			dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.THOUSAND_WIN }));
		}
		
		private function lostGame(e:TimerEvent):void
		{
			dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.THOUSAND_LOST }));
		}
		
		public function Pause(value:Boolean):void
		{
			if (value == true){
				pause = value;
				if (timer != null){
					timer.stop();
					timer = null;
				}
			}else{
				pause = value;
				timer = new Timer(500, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
				timer.start();
			}
			
		}
		
	}

}