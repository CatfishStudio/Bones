package bones.sevens 
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
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.text.TextFormat;
	
	import bones.events.Navigation;
	import bones.data.Constants;
	import bones.data.Images;
	import bones.data.Atlases;
	import bones.data.Sounds;
	import bones.data.Data;
	import bones.data.Utils;
	import bones.dice.Dice;
	import bones.dice.RedDice;;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Sevens extends Sprite 
	{
		private var button:Button;
		private var image:Image;
		private var textField1:TextField;
		private var textField2:TextField;
		private var tween:Tween;
		private var timer:Timer;
		private var movieClip:MovieClip;
		
		private var animDices:Vector.<MovieClip>;
		private var animRollDices:Vector.<MovieClip>;
		private var animRedDices:Vector.<MovieClip>;
		private var fieldDices:Vector.<Vector.<Dice>>;
		private var additionalDices:Vector.<Dice>;
		private var completeColumns:Vector.<RedDice>;
		
		private var diceValues:Array = [
			[[1, 5, 4, 6], [1, 3, 4, 2], [1, 6, 4, 5], [1, 2, 4, 3]],
            [[2, 5, 3, 6], [2, 1, 3, 4], [2, 6, 3, 5], [2, 4, 3, 1]],
            [[3, 5, 2, 6], [3, 4, 2, 1], [3, 6, 2, 5], [3, 1, 2, 4]],
            [[4, 5, 1, 6], [4, 2, 1, 3], [4, 6, 1, 5], [4, 3, 1, 2]],
            [[5, 1, 6, 4], [5, 2, 6, 3], [5, 4, 6, 1], [5, 3, 6, 2]],
            [[6, 1, 5, 4], [6, 3, 5, 2], [6, 4, 5, 1], [6, 2, 5, 3]]
		];
		private var canClick:Boolean = true;
		private var score:int;
		private var redScore:Array = [10, 20, 35, 60, 100];
		
		
		public function Sevens() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
			
			name = Constants.SEVENS;
			canClick = true;
			score = 0;
			
			createBackground();
			createBoard();
			createButtons();
			createAttemptDices();
			createField();
			createCompleteColumns();
			rollDice();
			
			trace('[SEVENS]: added to stage');
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			button.dispose();
			button = null;
			image.dispose();
			image = null;
			textField1.dispose();
			textField1 = null;
			textField2.dispose();
			textField2 = null;
			movieClip.dispose();
			movieClip = null;
			
			if (tween != null)
			{	
				Starling.juggler.remove(tween);
				tween = null;
			}			
			
			var i:int;
			var j:int;
			if(animDices != null){
				for (i = 0; i < animDices.length; i++) {
					Starling.juggler.removeTweens(animDices[i]);
					animDices[i].dispose();
				}
				animDices = null;
			}
			
			if(animRollDices != null){
				for (i = 0; i < animRollDices.length; i++) {
					Starling.juggler.removeTweens(animRollDices[i]);
					animRollDices[i].dispose();
				}
				animRollDices = null;
			}
			
			if (animRedDices != null){
				for (i = 0; i < animRedDices.length; i++){
					removeChild(animRedDices[i]);
					animRedDices[i].dispose();
					animRedDices[i] = null;
				}
				animRedDices = null;
			}
			
			if (fieldDices != null){
				for (i = 0; i < fieldDices.length; i++){
					for (j = 0; j < fieldDices[i].length; j++){
						if (fieldDices[i][j] != null) {
							removeChild(fieldDices[i][j]);
							fieldDices[i][j].dispose();
							fieldDices[i][j] = null;
						}
					}
				}
				fieldDices = null;
			}
			
			if (additionalDices != null){
				for (i = 0; i < additionalDices.length; i++){
					if (additionalDices[i] != null) {
						removeChild(additionalDices[i]);
						additionalDices[i].dispose();
						additionalDices[i] = null;
					}
				}
				additionalDices = null;
			}
			
			if (completeColumns != null){
				for (i = 0; i < completeColumns.length; i++){
					if (completeColumns[i] != null) {
						removeChild(completeColumns[i]);
						completeColumns[i].dispose();
						completeColumns[i] = null;
					}
				}
				completeColumns = null;
			}
			
			diceValues = null;
			
			while (this.numChildren) {
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			super.dispose();
			System.gc();
			
			trace('[SEVENS]: removed from stage');
		}
		
		private function onButtonsClick(e:Event):void 
		{
			switch(Button(e.target).name){
				case Constants.SEVENS_BUTTON_HELP:
				{
					//dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(e.target).name }));
					dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.SEVENS_WIN }));
					break;
				}
				case Constants.SEVENS_BUTTON_END_GAME:
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
			var bitmap:Bitmap = new Images.ImgSevens();
			image = new Image(Texture.fromBitmap(bitmap));
			image.x = 0;
			image.y = 0;
			addChild(image);
			bitmap = null;
		}
		
		private function createBoard():void
		{
			var textFormat:TextFormat = new TextFormat("Arial", 18, 0xFFFFFF, "left", "center");
			textFormat.bold = true;
			textField1 = new TextField(200, 60, "Сумма кубиков: ", textFormat);
			textField1.x = 625;
			textField1.y = 515;
			addChild(textField1);
			
			textFormat.bold = false;
			textField2 = new TextField(200, 60, "Ваши очки: " + score.toString(), textFormat);
			textField2.x = 625;
			textField2.y = 555;
			addChild(textField2);
			
			textFormat = null;
		}
		
		private function createButtons():void
		{
			var bitmap:Bitmap = new Images.ImgButtonHelp();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.SEVENS_BUTTON_HELP;
			button.x = 15;
			button.y = Constants.GAME_WINDOW_HEIGHT - 230;
			addChild(button);
			
			bitmap = new Images.ImgButtonEndGame();
			button = new Button(Texture.fromBitmap(bitmap));
			button.name = Constants.SEVENS_BUTTON_END_GAME;
			button.x = 15;
			button.y = Constants.GAME_WINDOW_HEIGHT - 175;
			addChild(button);
			
			bitmap = null;
		}
		
		private function createAttemptDices():void
		{
			animDices = new Vector.<MovieClip>();
			
			var i:int;
			for (i = 0; i < 7; i++){
				movieClip = new MovieClip(Atlases.textureAtlasAnimation.getTextures("anim_dice_"), 12);
				movieClip.stop(); 
				movieClip.addEventListener(TouchEvent.TOUCH, onTouchRoll);
				animDices.push(movieClip);
				Starling.juggler.add(animDices[i]);
			}
			
			animDices[0].x = 45;
			animDices[0].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[0]);
			
			animDices[1].x = 160;
			animDices[1].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[1]);
			
			animDices[2].x = 280;
			animDices[2].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[2]);
			
			animDices[3].x = 400;
			animDices[3].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[3]);
			
			animDices[4].x = 520;
			animDices[4].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[4]);
			
			animDices[5].x = 640;
			animDices[5].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[5]);
			
			animDices[6].x = 760;
			animDices[6].y = Constants.GAME_WINDOW_HEIGHT - 80;
			addChild(animDices[6]);
			
		}
		
		private function onTouchRoll(e:TouchEvent):void 
		{
			//e.getTouch(e.target as DisplayObject, TouchPhase.HOVER) ? (e.target as MovieClip).play() : (e.target as MovieClip).stop();
			if (e.getTouch(e.target as DisplayObject, TouchPhase.HOVER)){
				(e.target as MovieClip).play();
				
			}else{
				(e.target as MovieClip).stop();
				
			}
			if (e.getTouch(e.target as DisplayObject, TouchPhase.BEGAN) && canClick){
				(e.target as MovieClip).visible = false;
				rollDice();
			}
		}
		
		private function createField():void
		{
			fieldDices = new Vector.<Vector.<Dice>>();
			for (var i:int = 0; i < 5; i++) {
				var newRow:Vector.<Dice> = new Vector.<Dice>();
				for (var j:int = 0; j < 10; j++) {
					newRow.push(new Dice(diceValues[Utils.getRandomInt(0,6)][Utils.getRandomInt(0,4)], Utils.getRandomInt(0,2)));
					newRow[j].x = 300 + (45 * i);
					newRow[j].y = 180 + (42 * j);
					if (j == 9) newRow[j].diceEnable();
					newRow[j].addEventListener(TouchEvent.TOUCH, onDiceTouch);
					addChild(newRow[j]);
				}
				fieldDices.push(newRow);
			}
		}
		
		private function createCompleteColumns():void
		{
			completeColumns = new Vector.<RedDice>();
			var i:int;
			for (i = 0; i < 5; i++){
				completeColumns.push(new RedDice());
				completeColumns[i].x = 300 + (45 * i);
				completeColumns[i].y = 558;
				completeColumns[i].visible = false;
				addChild(completeColumns[i]);
			}
			
		}
		
		private function rollDice():void
		{
			canClick = false;
			var i:int;
			if(additionalDices != null){
				for (i = 0; i < additionalDices.length; i++) {
					if (additionalDices[i] == null) continue;
					removeChild(additionalDices[i]);
					additionalDices[i].dispose();
					additionalDices[i] = null;
				}
			}
			additionalDices = null;
			
			var movieClip:MovieClip;
			animRollDices = new Vector.<MovieClip>()
			for (i = 0; i < 2; i++){
				movieClip = new MovieClip(Atlases.textureAtlasAnimation.getTextures("anim_dice_"), 12);
				movieClip.play(); 
				movieClip.x = 25 - (50 * Utils.getRandomInt(1, 4));
				movieClip.y = 400 - (50 * Utils.getRandomInt(1, 4));
				animRollDices.push(movieClip);
				addChild(animRollDices[i]);
				Starling.juggler.add(animRollDices[i]);
				
				tween = new Tween(animRollDices[i], 1.0);
				tween.moveTo(50 + (50 * Utils.getRandomInt(1, 4)), 300 - (50 * Utils.getRandomInt(1, 4)));
				tween.onComplete = rollDiceComplete;
				Starling.juggler.add(tween);
			}
			
			
		}
		
		private function rollDiceComplete():void 
		{
			additionalDices = new Vector.<Dice>();
			Starling.juggler.removeTweens(tween);
			var value:int;
			var i:int;
			for (i = 0; i < animRollDices.length; i++) {
				value = Utils.getRandomInt(1, 7);
				
				additionalDices.push(new Dice(diceValues[Utils.getRandomInt(0,6)][Utils.getRandomInt(0,4)], 0));
				additionalDices[i].x = animRollDices[i].x;
				additionalDices[i].y = animRollDices[i].y;
				additionalDices[i].diceEnable();
				additionalDices[i].addEventListener(TouchEvent.TOUCH, onDiceTouch);
				addChild(additionalDices[i]);
				
				animRollDices[i].stop();
				Starling.juggler.removeTweens(animRollDices[i]);
				removeChild(animRollDices[i]);
				animRollDices[i].dispose();
			}
			animRollDices = null;
			canClick = true;
			checkGameOver();
		}
		
		private function onDiceTouch(e:TouchEvent):void 
		{
			if (e.getTouch(e.target as DisplayObject, TouchPhase.BEGAN) && canClick){
				var dice:Dice = ((e.target as Image).parent as Dice);
				if (dice.getEnable()){
					dice.select();
					checkCombination();
				}
			}
		}
		
		private function checkCombination():void
		{
			var dices:Vector.<Dice> = new Vector.<Dice>();
			var result:int = 0;
			var i:int;
			var count:int = additionalDices.length;
			for (i = 0; i < count; i++){
				if (additionalDices[i] == null) continue;
				if (additionalDices[i].getSelect()){
					result += additionalDices[i].getValue();
					dices.push(additionalDices[i]);
				}
			}
			count = fieldDices.length;
			for (i = 0; i < count; i++){
				if (fieldDices[i].length == 0) continue;
				if (fieldDices[i][fieldDices[i].length - 1] == null) continue;
				if (fieldDices[i][fieldDices[i].length - 1].getSelect()){
					result += fieldDices[i][fieldDices[i].length - 1].getValue();
					dices.push(fieldDices[i][fieldDices[i].length - 1]);
				}
			}
			
			
			if (result == 7){
				textField1.text = "Сумма кубиков: " + result.toString();
				addScore(dices);
				removeCombination();
			}else if (result > 7){
				textField1.text = "Сумма кубиков: " + result.toString();
				redCombination();
			}else if (result < 7){
				textField1.text = "Сумма кубиков: " + result.toString();
			}
			
			dices = null;
		}
		
		private function removeCombination():void
		{
			var i:int;
			var j:int;
			var count:int = additionalDices.length;
			for (i = 0; i < count; i++){
				if (additionalDices[i] == null) continue;
				if (additionalDices[i].getSelect()){
					removeChild(additionalDices[i]);
					additionalDices[i].dispose();
					additionalDices[i] = null;
				}
			}
			if (additionalDices[0] == null && additionalDices[additionalDices.length - 1] === null)
			{
				rollDice();
			}
			count = fieldDices.length;
			for (i = 0; i < count; i++){
				if (fieldDices[i].length == 0) continue;
				if (fieldDices[i][fieldDices[i].length - 1].getSelect()){
					removeChild(fieldDices[i][fieldDices[i].length - 1]);
					fieldDices[i][fieldDices[i].length - 1].dispose();
					fieldDices[i][fieldDices[i].length - 1] = null;
					fieldDices[i].pop();
					
					if (fieldDices[i].length == 0){ // red dice (clear column)
						completeColumn(i);
					}else{ // dice move down
					
						for (j = fieldDices[i].length-1; j >= 0; j--){
							fieldDices[i][j].moveDown();
							if (j == fieldDices[i].length - 1) fieldDices[i][j].diceEnable();
						}
					}
				}
			}
			
			checkGameOver();
			textField1.text = "Сумма кубиков: ";
		}
		
		private function redCombination():void
		{
			canClick = false;
			var i:int;
			var j:int;
			var count:int = additionalDices.length;
			for (i = 0; i < count; i++){
				if (additionalDices[i] == null) continue;
				if (additionalDices[i].getSelect()){
					additionalDices[i].redHighlight();
				}
			}
			count = fieldDices.length;
			for (i = 0; i < count; i++){
				if (fieldDices[i][fieldDices[i].length - 1].getSelect()){
					fieldDices[i][fieldDices[i].length - 1].redHighlight();
				}
			}
			
			timer = new Timer(1000, 1);
			//timer.addEventListener(TimerEvent.TIMER, onTick); 
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
            timer.start(); 
			
		}
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			timer = null;
			var i:int;
			var j:int;
			var count:int = additionalDices.length;
			for (i = 0; i < count; i++){
				if (additionalDices[i] == null) continue;
				if (additionalDices[i].getSelect()){
					additionalDices[i].notHighlight();
					additionalDices[i].select();
				}
			}
			count = fieldDices.length;
			for (i = 0; i < count; i++){
				if (fieldDices[i][fieldDices[i].length - 1].getSelect()){
					fieldDices[i][fieldDices[i].length - 1].notHighlight();
					fieldDices[i][fieldDices[i].length - 1].select();
				}
			}
			canClick = true;
			textField1.text = "Сумма кубиков: ";
		}
		
		private function completeColumn(column:int):void
		{
			if (completeColumns[column].visible === false){
				canClick = false;
				
				addRedScore();
				
				if (animRedDices == null) animRedDices = new Vector.<MovieClip>();
				
				animRedDices.push(new MovieClip(Atlases.textureAtlasAnimation.getTextures("win_dice_"), 12));
				animRedDices[animRedDices.length - 1].x = completeColumns[column].x;
				animRedDices[animRedDices.length - 1].y = 180;
				animRedDices[animRedDices.length - 1].name = column.toString();
				animRedDices[animRedDices.length - 1].play();
				addChild(animRedDices[animRedDices.length - 1]);
				Starling.juggler.add(animRedDices[animRedDices.length - 1]);
				
				tween = new Tween(animRedDices[animRedDices.length-1], 1.0);
				tween.moveTo(completeColumns[column].x, completeColumns[column].y);
				tween.onComplete = tweenRedDiceComplete;
				Starling.juggler.add(tween);
				
			}
		}
		
		private function tweenRedDiceComplete():void 
		{
			Starling.juggler.remove(tween);
			tween = null;
			
			var i:int;
			for (i = 0; i < animRedDices.length; i++){
				animRedDices[i].stop();
				removeChild(animRedDices[i]);
				Starling.juggler.remove(animRedDices[i]);
				completeColumns[int(animRedDices[i].name)].visible = true;
				animRedDices[i].dispose();
				animRedDices[i] = null;
			}
			animRedDices = null;
			canClick = true;
			checkGameOver();
		}
		
		private function addScore(dices:Vector.<Dice>):void
		{
			var countBlack:int = 0;
			var countBlue:int = 0;
			var i:int;
			for (i = 0; i < dices.length; i++){
				if (dices[i].getType() == 0) countBlack++;
				if (dices[i].getType() == 1) countBlue++;
			}
			
			if (countBlue > 0 && countBlack == 0){
				if (countBlue == 2) score += 30;
				else if (countBlue > 2) score += 50;
			}else if (countBlue == 0 && countBlack > 0){
				if (countBlack == 2) score += 7;
				else if (countBlack == 3) score += 15;
				else if (countBlack > 3) score += 30;
			}else if (countBlue > 0 && countBlack > 0){
				score += 7;
			}
			
			textField2.text = "Ваши очки: " + score.toString();
		}
		
		private function addRedScore():void
		{
			score += redScore.shift();
			textField2.text = "Ваши очки: " + score.toString();
		}
		
		private function checkPossibleCombination():Boolean
		{
			var attempt:int = 0;
			var i:int;
			for (i = 0; i < animDices.length; i++){
				if (animDices[i].visible) attempt++;
			}
			
			if (attempt > 0){
				return true;
			}
			
			var values: Array = [];
			
            var lastRow: int;
			for (i = 0; i < fieldDices.length; i++){
				lastRow = fieldDices[i].length - 1;
				if (lastRow < 0) continue;
				if (fieldDices[i][lastRow] != null) values.push(fieldDices[i][lastRow].getValue());
			}
			
			if (additionalDices != null){
				for (i = 0; i < additionalDices.length; i++){
					if (additionalDices[i] != null) values.push(additionalDices[i].getValue());
				}
			}
			
			values.sort(function (valueA:int, valueB:int){
				return valueB - valueA;
			});
			
			var value:int;
			var j:int;
			for (i = 0; i < values.length; i++){
				value = values[i];
				for (j = 0; j < values.length; j++){
					if (i != j){
						if ((value + values[j]) == 7) { 
							return true;
						}else if ((value + values[j]) < 7) {
							value += values[j];
						}else if ((value + values[j]) > 7) {
							value = values[i];
						}
					}
				}
			}
			
			return false;
		}
		
		private function checkGameOver():void
		{
			if (completeColumns[0].visible && completeColumns[1].visible && completeColumns[2].visible && completeColumns[3].visible && completeColumns[4].visible) {
				trace('[SAVENS]: game over - win!');
				Data.userRatingSevens = score;
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.SEVENS_WIN }));
				return;
			}
			
			if (checkPossibleCombination() == false){
				trace('[SAVENS]: game over - lost!');
				Data.userRatingSevens = score;
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.SEVENS_LOST }));
			}
		}
		
	}

}