var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var DiceButton = (function (_super) {
    __extends(DiceButton, _super);
    function DiceButton(game, x, y, key, callback, callbackContext, overFrame, outFrame, downFrame, upFrame) {
        _super.call(this, game, x, y, key, callback, callbackContext, overFrame, outFrame, downFrame, upFrame);
    }
    return DiceButton;
})(Phaser.Button);
var SevensState = (function (_super) {
    __extends(SevensState, _super);
    function SevensState() {
        _super.apply(this, arguments);
        this.score = 0;
        this.points = 0;
        this.attempt = 0;
        this.columnComplete = 0;
    }
    SevensState.prototype.preload = function () {
    };
    SevensState.prototype.create = function () {
        this.stage.backgroundColor = "#FFFFFF";
        this.group = new Phaser.Group(this.game, this.stage);
        this.sound1 = this.game.add.audio('sound1');
        this.sound1.loop = true;
        this.sound2 = this.game.add.audio('sound2');
        this.sound3 = this.game.add.audio('sound3');
        this.sound4 = this.game.add.audio('sound4');
        this.createBackground();
        this.createPanelScore();
        this.createPanelDice();
        this.createButtons();
        this.createField();
        this.rollDice();
    };
    SevensState.prototype.update = function () {
    };
    SevensState.prototype.render = function () {
    };
    SevensState.prototype.randomIndex = function () {
        var index = Math.round(Math.random() / 0.1);
        return index;
    };
    SevensState.prototype.randomValue = function (count) {
        var index = this.randomIndex();
        if (count === 1) {
            if (index >= 0 && index < 8)
                return 0;
            if (index >= 8 && index <= 10)
                return 1;
        }
        if (count === 3) {
            if (index >= 0 && index < 2)
                return 0;
            if (index >= 2 && index < 5)
                return 1;
            if (index >= 5 && index < 8)
                return 2;
            if (index >= 8 && index <= 10)
                return 3;
        }
        if (count === 6) {
            if (index >= 0 && index < 1)
                return 1;
            if (index >= 1 && index < 3)
                return 2;
            if (index >= 3 && index < 5)
                return 3;
            if (index >= 5 && index < 7)
                return 4;
            if (index >= 7 && index < 9)
                return 5;
            if (index >= 9 && index <= 10)
                return 6;
        }
    };
    SevensState.prototype.createBackground = function () {
        var background = new Phaser.Sprite(this.game, 0, 0, 'background');
        this.group.addChild(background);
        var logo = new Phaser.Sprite(this.game, (this.game.width / 2) - (500 / 2), 10, 'logo_seven');
        logo.scale.setTo(0.8, 0.8);
        this.group.addChild(logo);
    };
    SevensState.prototype.createPanelScore = function () {
        var graphics = new Phaser.Graphics(this.game, 100, 100);
        graphics.beginFill(0xCFC7BD, 0.5);
        graphics.lineStyle(1, 0xFDE5C8, 1);
        graphics.drawRect(525, 125, 195, 325);
        graphics.endFill();
        this.group.addChild(graphics);
        var sprite = new Phaser.Sprite(this.game, 600, 180, 'panel');
        this.group.addChild(sprite);
        var text = new Phaser.Text(this.game, 670, 185, 'Семёрка');
        this.group.addChild(text);
        var diceData = [
            [635, 260, 'dice_black_atlas', 'dice6063', 660, 260, '+'],
            [670, 260, 'dice_black_atlas', 'dice1012', 695, 260, ': +7'],
            [635, 290, 'dice_black_atlas', 'dice5051', 660, 290, '+'],
            [670, 290, 'dice_black_atlas', 'dice1016', 695, 290, '+'],
            [705, 290, 'dice_black_atlas', 'dice1012', 730, 290, ': +15'],
            [635, 320, 'dice_black_atlas', 'dice2026', 660, 320, '+'],
            [670, 320, 'dice_black_atlas', 'dice3032', 695, 320, '+'],
            [705, 320, 'dice_black_atlas', 'dice1012', 730, 320, '+'],
            [740, 320, 'dice_black_atlas', 'dice1015', 765, 320, ': +30'],
            [635, 350, 'dice_blue_atlas', 'dice5054', 660, 350, '+'],
            [670, 350, 'dice_blue_atlas', 'dice2025', 695, 350, ': +30'],
            [635, 380, 'dice_blue_atlas', 'dice4041', 660, 380, '+'],
            [670, 380, 'dice_blue_atlas', 'dice2026', 695, 380, '+'],
            [705, 380, 'dice_blue_atlas', 'dice1013', 730, 380, ': +50'],
            [635, 410, 'dice_blue_atlas', 'dice5054', 660, 410, '+'],
            [670, 410, 'dice_black_atlas', 'dice2025', 695, 410, ': +7'],
            [635, 440, 'dice_blue_atlas', 'dice5051', 660, 440, '+'],
            [670, 440, 'dice_blue_atlas', 'dice1016', 695, 440, '+'],
            [705, 440, 'dice_black_atlas', 'dice1012', 730, 440, ': +7'],
            [635, 470, 'dice_blue_atlas', 'dice2024', 660, 470, '+'],
            [670, 470, 'dice_black_atlas', 'dice3036', 695, 470, '+'],
            [705, 470, 'dice_black_atlas', 'dice1014', 730, 470, '+'],
            [740, 470, 'dice_black_atlas', 'dice1015', 765, 470, ': +7'],
            [635, 500, 'dice_win_atlas', 'dicewin02', 660, 500, ' 10, 20, 35, 60, 100']
        ];
        var count = diceData.length;
        for (var i = 0; i < count; i++) {
            sprite = new Phaser.Sprite(this.game, diceData[i][0], diceData[i][1], diceData[i][2], diceData[i][3]);
            sprite.scale.setTo(0.5, 0.5);
            this.group.addChild(sprite);
            text = new Phaser.Text(this.game, diceData[i][4], diceData[i][5], diceData[i][6], { font: '18px Arial', fill: '#FFFFFF' });
            this.group.addChild(text);
        }
        this.pointsText = new Phaser.Text(this.game, 655, 535, 'Сумма кубиков: 0', { font: '14px Arial', fill: '#FFFFFF' });
        this.group.addChild(this.pointsText);
        this.scoreText = new Phaser.Text(this.game, 640, 570, 'Ваши очки: 0', { font: '18px Arial', fill: '#FFFFFF' });
        this.group.addChild(this.scoreText);
    };
    SevensState.prototype.createPanelDice = function () {
        this.attempt = 7;
        var dice;
        var index = 0;
        var sprite;
        for (var i = 0; i < 7; i++) {
            sprite = new Phaser.Sprite(this.game, 20 + (120 * i), 625, 'box');
            this.group.addChild(sprite);
            index = i < 1 || i > 6 ? 3 : i;
            dice = new DiceButton(this.game, 40 + (120 * i), 650, 'dice_' + index + '_atlas', this.onPanelDiceClick, this, 0, 0, 0);
            dice.animations.add('dice', Phaser.Animation.generateFrameNames('dice', 0, 10, '', 2), 15, true);
            dice.onInputOver.add(this.onPanelDiceOver, this);
            dice.onInputOut.add(this.onPanelDiceOut, this);
            dice.onInputUp.add(this.onPanelDiceUp, this);
            this.group.addChild(dice);
        }
    };
    SevensState.prototype.onPanelDiceClick = function (event) {
        event.kill();
        this.attempt--;
        this.sound1.stop();
        if (sound === true)
            this.sound2.play();
        if (this.dice1 !== null) {
            this.dice1.kill();
            this.group.removeChild(this.dice1);
        }
        if (this.dice2 !== null) {
            this.dice2.kill();
            this.group.removeChild(this.dice2);
        }
        var tween;
        var index = this.randomValue(6);
        var newPosX = 25 + ((Math.random() / 0.1) * 10);
        var newPosY = 200 + ((Math.random() / 0.1) * 10);
        this.dice1 = new DiceButton(this.game, 150, 450, "dice_" + index + "_atlas", this.onDiceClick, this);
        this.dice1.diceType = 0;
        this.dice1.diceValue = index;
        tween = this.game.add.tween(this.dice1);
        tween.to({ x: newPosX, y: newPosY }, 500, 'Linear');
        tween.start();
        this.dice1.animations.add('dice', Phaser.Animation.generateFrameNames('dice', 0, 10, '', 2), 15, false);
        this.dice1.animations.play('dice');
        this.group.addChild(this.dice1);
        index = this.randomValue(6);
        newPosX = 50 + ((Math.random() / 0.1) * 20);
        newPosY = 250 + ((Math.random() / 0.1) * 20);
        this.dice2 = new DiceButton(this.game, 125, 450, "dice_" + index + "_atlas", this.onDiceClick, this);
        this.dice2.diceType = 0;
        this.dice2.diceValue = index;
        tween = this.game.add.tween(this.dice2);
        tween.to({ x: newPosX, y: newPosY }, 500, 'Linear');
        tween.start();
        this.dice2.animations.add('dice', Phaser.Animation.generateFrameNames('dice', 0, 10, '', 2), 15, false);
        this.dice2.animations.play('dice');
        this.group.addChild(this.dice2);
        this.clearDiceField();
        if (this.columnComplete === 5) {
            this.endGame("WIN");
        }
        else {
            if (this.checkVariant() === false)
                this.endGame("LOST");
        }
    };
    SevensState.prototype.onPanelDiceOver = function (event) {
        if (sound === true)
            this.sound1.play();
        event.animations.play('dice');
    };
    SevensState.prototype.onPanelDiceOut = function (event) {
        this.sound1.stop();
        event.animations.stop();
    };
    SevensState.prototype.onPanelDiceUp = function (event) {
    };
    SevensState.prototype.onDiceClick = function (event) {
        if (sound === true)
            this.sound3.play();
        if (event.frame === 10) {
            event.frame = 12;
            this.points += event.diceValue;
            this.pointsText.text = 'Сумма кубиков: ' + this.points;
        }
        else {
            event.frame = 10;
            this.points -= event.diceValue;
            this.pointsText.text = 'Сумма кубиков: ' + this.points;
        }
        this.checkDiceScore();
    };
    SevensState.prototype.checkVariant = function () {
        if (this.attempt === 0) {
            var col = 0;
            var row = 0;
            var col2 = 0;
            var row2 = 0;
            var value = 0;
            var values;
            var count = 0;
            if (this.dice1 !== null) {
                col = 0;
                row = 0;
                value = 7 - this.dice1.diceValue;
                values = [];
                count = this.field.length;
                if (this.dice2 !== null) {
                    if (this.dice2.diceValue === value)
                        return true;
                }
                for (col = 0; col < count; col++) {
                    row = this.field[col].length - 1;
                    if (row >= 0) {
                        if (this.field[col][row].diceValue === value)
                            return true;
                        if (this.field[col][row].diceValue < value)
                            values.push(this.field[col][row].diceValue);
                    }
                }
                values.sort(function (valueA, valueB) {
                    return valueB - valueA;
                });
                count = values.length;
                for (col = 0; col < count; col++) {
                    value -= values[col];
                    if (value === 0)
                        return true;
                    else if (value < 0)
                        break;
                }
            }
            if (this.dice2 !== null) {
                col = 0;
                row = 0;
                value = 7 - this.dice2.diceValue;
                values = [];
                count = this.field.length;
                if (this.dice1 !== null) {
                    if (this.dice1.diceValue === value)
                        return true;
                }
                for (col = 0; col < count; col++) {
                    row = this.field[col].length - 1;
                    if (row >= 0) {
                        if (this.field[col][row].diceValue === value)
                            return true;
                        if (this.field[col][row].diceValue < value)
                            values.push(this.field[col][row].diceValue);
                    }
                }
                values.sort(function (valueA, valueB) {
                    return valueB - valueA;
                });
                count = values.length;
                for (col = 0; col < count; col++) {
                    value -= values[col];
                    if (value === 0)
                        return true;
                    else if (value < 0)
                        break;
                }
            }
            col = 0;
            row = 0;
            col2 = 0;
            row2 = 0;
            value = 0;
            values = [];
            count = this.field.length;
            for (col = 0; col < count; col++) {
                row = this.field[col].length - 1;
                if (row >= 0) {
                    value = 7 - this.field[col][row].diceValue;
                    for (col2 = 0; col2 < count; col2++) {
                        if (col2 !== col) {
                            row2 = this.field[col2].length - 1;
                            if (row2 >= 0) {
                                if (this.field[col2][row2].diceValue === value)
                                    return true;
                                if (this.field[col2][row2].diceValue < value)
                                    values.push(this.field[col2][row2].diceValue);
                            }
                        }
                    }
                    values.sort(function (valueA, valueB) {
                        return valueB - valueA;
                    });
                    count = values.length;
                    for (col = 0; col < count; col++) {
                        value -= values[col];
                        if (value === 0)
                            return true;
                        else if (value < 0)
                            break;
                    }
                }
            }
            return false;
        }
        else {
            return true;
        }
    };
    SevensState.prototype.checkDiceScore = function () {
        if (this.points === 7) {
            var countBlack = 0;
            var countBlue = 0;
            if (this.dice1 !== null) {
                if (this.dice1.frame === 12) {
                    this.dice1.kill();
                    this.group.removeChild(this.dice1);
                    this.dice1 = null;
                    countBlack++;
                }
            }
            if (this.dice2 !== null) {
                if (this.dice2.frame === 12) {
                    this.dice2.kill();
                    this.group.removeChild(this.dice2);
                    this.dice2 = null;
                    countBlack++;
                }
            }
            var col = 0;
            var row = 0;
            var indexLastChar = 0;
            for (var i = 0; i < this.field.length; i++) {
                col = i;
                row = this.field[col].length - 1;
                if (row >= 0) {
                    indexLastChar = this.field[col][row].frameName.length - 1;
                    if (this.field[col][row].frameName[indexLastChar] === "Y") {
                        if (this.field[col][row].diceType === 0)
                            countBlack++;
                        if (this.field[col][row].diceType === 1)
                            countBlue++;
                        this.field[col][row].kill();
                        this.field[col].splice(row, 1);
                        if (this.field[col].length !== 0) {
                            this.field[col][this.field[col].length - 1].inputEnabled = true;
                            this.field[col][this.field[col].length - 1].input.useHandCursor = true;
                            this.moveDownDice(col);
                        }
                        else {
                            this.moveDownDiceWin(col);
                        }
                    }
                }
            }
            if (this.dice1 === null && this.dice2 === null)
                this.rollDice();
            var score = 0;
            if (countBlue === 2 && countBlack === 0)
                score = 30;
            if (countBlue === 3 && countBlack === 0)
                score = 50;
            if (countBlack === 2 && countBlack < 3 && countBlue === 0)
                score = 7;
            if (countBlack === 3 && countBlack < 4 && countBlue === 0)
                score = 15;
            if (countBlack >= 4 && countBlue === 0)
                score = 30;
            if (countBlack > 0 && countBlue > 0)
                score = 7;
            this.score += score;
            this.scoreText.text = 'Ваши очки: ' + this.score;
            this.points = 0;
            this.pointsText.text = 'Сумма кубиков: ' + this.points;
            if (this.columnComplete === 5) {
                this.endGame("WIN");
            }
            else {
                if (this.checkVariant() === false)
                    this.endGame("LOST");
            }
        }
        else {
            if (this.points > 7) {
                if (this.dice1 !== null) {
                    this.dice1.inputEnabled = false;
                    if (this.dice1.frame === 12)
                        this.dice1.frame = 11;
                }
                if (this.dice2 !== null) {
                    this.dice2.inputEnabled = false;
                    if (this.dice2.frame === 12)
                        this.dice2.frame = 11;
                }
                var col = 0;
                var row = 0;
                var indexLastChar = 0;
                for (var i = 0; i < this.field.length; i++) {
                    col = i;
                    row = this.field[col].length - 1;
                    if (row >= 0) {
                        indexLastChar = this.field[col][row].frameName.length - 1;
                        if (this.field[col][row].frameName[indexLastChar] === "Y") {
                            this.field[col][row].frameName = this.field[col][row].frameName.slice(0, 8) + "R";
                        }
                        this.field[col][row].inputEnabled = false;
                    }
                }
                this.timer = setInterval(this.onTimerComplete.bind(this), 1000);
            }
        }
    };
    SevensState.prototype.onTimerComplete = function (event) {
        clearInterval(this.timer);
        var col = 0;
        var row = 0;
        var indexLastChar = 0;
        for (var i = 0; i < this.field.length; i++) {
            col = i;
            row = this.field[col].length - 1;
            if (row >= 0) {
                indexLastChar = this.field[col][row].frameName.length - 1;
                if (this.field[col][row].frameName[indexLastChar] === "R") {
                    this.field[col][row].frameName = this.field[col][row].frameName.slice(0, 8);
                }
                this.field[col][row].inputEnabled = true;
                this.field[col][row].input.useHandCursor = true;
            }
        }
        if (this.dice1 !== null) {
            this.dice1.inputEnabled = true;
            this.dice1.input.useHandCursor = true;
            if (this.dice1.frame === 11)
                this.dice1.frame = 10;
        }
        if (this.dice2 !== null) {
            this.dice2.inputEnabled = true;
            this.dice2.input.useHandCursor = true;
            if (this.dice2.frame === 11)
                this.dice2.frame = 10;
        }
        this.points = 0;
        this.pointsText.text = 'Сумма кубиков: ' + this.points;
    };
    SevensState.prototype.moveDownDice = function (column) {
        var tween;
        var nextValue = 0;
        for (var row = 0; row < this.field[column].length; row++) {
            this.field[column][row].diceIndex = this.field[column][row].diceIndex === 0 ? 3 : (this.field[column][row].diceIndex - 1);
            this.field[column][row].diceValue = this.field[column][row].diceValues[this.field[column][row].diceIndex];
            nextValue = this.field[column][row].diceIndex === 3 ? 0 : (this.field[column][row].diceIndex + 1);
            this.field[column][row].frameName = "dice" + this.field[column][row].diceValue + "0" + this.field[column][row].diceValue + this.field[column][row].diceValues[nextValue];
            tween = this.game.add.tween(this.field[column][row]);
            tween.to({ y: this.field[column][row].position.y + 40 }, 100, 'Linear');
            tween.start();
        }
    };
    SevensState.prototype.moveDownDiceWin = function (column) {
        this.columnComplete++;
        var score = 0;
        if (this.columnComplete === 1)
            score = 10;
        if (this.columnComplete === 2)
            score = 20;
        if (this.columnComplete === 3)
            score = 35;
        if (this.columnComplete === 4)
            score = 60;
        if (this.columnComplete === 5)
            score = 100;
        this.score += score;
        this.scoreText.text = 'Ваши очки: ' + this.score;
        var dice = new Phaser.Sprite(this.game, 305 + (50 * column), 200, 'dice_win_atlas', 'dicewin00');
        dice.animations.add('dice', Phaser.Animation.generateFrameNames('dicewin', 0, 3, '', 2), 15, true);
        dice.animations.play('dice');
        this.group.addChild(dice);
        var tween;
        tween = this.game.add.tween(dice);
        tween.to({ y: 560 }, 2000, 'Linear');
        tween.onComplete.add(this.onMoveDownDiceWinComplete, this);
        tween.start();
    };
    SevensState.prototype.onMoveDownDiceWinComplete = function (event) {
        event.animations.stop('dice');
        event.animations.frameName = 'dicewin02';
    };
    SevensState.prototype.rollDice = function () {
        this.sound1.stop();
        if (sound === true)
            this.sound2.play();
        var tween;
        var index = this.randomValue(6);
        var newPosX = 25 + ((Math.random() / 0.1) * 10);
        var newPosY = 200 + ((Math.random() / 0.1) * 10);
        this.dice1 = new DiceButton(this.game, 150, 450, "dice_" + index + "_atlas", this.onDiceClick, this);
        this.dice1.diceType = 0;
        this.dice1.diceValue = index;
        tween = this.game.add.tween(this.dice1);
        tween.to({ x: newPosX, y: newPosY }, 500, 'Linear');
        tween.start();
        this.dice1.animations.add('dice', Phaser.Animation.generateFrameNames('dice', 0, 10, '', 2), 15, false);
        this.dice1.animations.play('dice');
        this.group.addChild(this.dice1);
        index = this.randomValue(6);
        newPosX = 50 + ((Math.random() / 0.1) * 20);
        newPosY = 250 + ((Math.random() / 0.1) * 20);
        this.dice2 = new DiceButton(this.game, 125, 450, "dice_" + index + "_atlas", this.onDiceClick, this);
        this.dice2.diceType = 0;
        this.dice2.diceValue = index;
        tween = this.game.add.tween(this.dice2);
        tween.to({ x: newPosX, y: newPosY }, 500, 'Linear');
        tween.start();
        this.dice2.animations.add('dice', Phaser.Animation.generateFrameNames('dice', 0, 10, '', 2), 15, false);
        this.dice2.animations.play('dice');
        this.group.addChild(this.dice2);
        this.clearDiceField();
        if (this.columnComplete === 5) {
            this.endGame("WIN");
        }
        else {
            if (this.checkVariant() === false)
                this.endGame("LOST");
        }
    };
    SevensState.prototype.createButtons = function () {
        var button = new Phaser.Button(this.game, 10, 565, 'button_end_game', this.onButtonClick, this);
        button.name = 'button_end_game';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.group.addChild(button);
        button = new Phaser.Button(this.game, 10, 510, 'button_help', this.onButtonClick, this);
        button.name = 'button_help';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.group.addChild(button);
    };
    SevensState.prototype.onButtonClick = function (event) {
        if (sound === true)
            this.sound4.play();
        switch (event.name) {
            case "button_end_game":
                {
                    event.inputEnabled = false;
                    this.endGame("LOST");
                    break;
                }
            case "button_restart_game":
                {
                    this.group.removeChildren();
                    this.group = null;
                    this.windowHelp = null;
                    this.dice1 = null;
                    this.dice2 = null;
                    this.field = [];
                    this.score = 0;
                    this.scoreText = null;
                    this.points = 0;
                    this.pointsText = null;
                    this.attempt = 0;
                    this.columnComplete = 0;
                    this.sound1 = null;
                    this.sound2 = null;
                    this.sound3 = null;
                    this.sound4 = null;
                    this.timer = null;
                    this.game.state.restart(true);
                    break;
                }
            case "button_back_menu":
                {
                    this.group.removeChildren();
                    this.group = null;
                    this.windowHelp = null;
                    this.dice1 = null;
                    this.dice2 = null;
                    this.field = [];
                    this.score = 0;
                    this.scoreText = null;
                    this.points = 0;
                    this.pointsText = null;
                    this.attempt = 0;
                    this.columnComplete = 0;
                    this.sound1 = null;
                    this.sound2 = null;
                    this.sound3 = null;
                    this.sound4 = null;
                    this.timer = null;
                    this.game.state.start("MenuState");
                    break;
                }
            case "button_help":
                {
                    this.windowHelpCreate();
                    break;
                }
            case "button_help_close":
                {
                    this.windowHelpClose();
                    break;
                }
            case "button_post":
                {
					//VK.api("wall.post", { message: 'Кости - Семёрка\n Я набрал ' + this.score + ' очков и победил!\nПрисоединяйтесь к игре https://vk.com/app5380703', attachments: 'photo-62618339_409463964' });
                }
            default:
                break;
        }
    };
    SevensState.prototype.onButtonOver = function (event) {
        event.scale.setTo(0.95, 0.95);
        event.anchor.x -= 0.025;
    };
    SevensState.prototype.onButtonOut = function (event) {
        event.scale.setTo(1, 1);
        event.anchor.x += 0.025;
    };
    SevensState.prototype.clearDiceField = function () {
        if (this.dice1 !== null) {
            if (this.dice1.frame === 12)
                this.dice1.frame = 11;
        }
        if (this.dice2 !== null) {
            if (this.dice2.frame === 12)
                this.dice2.frame = 11;
        }
        var col = 0;
        var row = 0;
        for (var i = 0; i < this.field.length; i++) {
            col = i;
            row = this.field[col].length - 1;
            if (row >= 0) {
                if (this.field[col][row].frameName.length > 8)
                    this.field[col][row].frameName = this.field[col][row].frameName.slice(0, 8);
            }
        }
        this.points = 0;
        this.pointsText.text = 'Сумма кубиков: ' + this.points;
    };
    SevensState.prototype.createField = function () {
        var diceValues = {
            "1": [[1, 5, 4, 6], [1, 3, 4, 2], [1, 6, 4, 5], [1, 2, 4, 3]],
            "2": [[2, 5, 3, 6], [2, 1, 3, 4], [2, 6, 3, 5], [2, 4, 3, 1]],
            "3": [[3, 5, 2, 6], [3, 4, 2, 1], [3, 6, 2, 5], [3, 1, 2, 4]],
            "4": [[4, 5, 1, 6], [4, 2, 1, 3], [4, 6, 1, 5], [4, 3, 1, 2]],
            "5": [[5, 1, 6, 4], [5, 2, 6, 3], [5, 4, 6, 1], [5, 3, 6, 2]],
            "6": [[6, 1, 5, 4], [6, 3, 5, 2], [6, 4, 5, 1], [6, 2, 5, 3]]
        };
        this.field = [];
        var dice;
        var diceType;
        var nextValue;
        var rows;
        for (var col = 0; col < 5; col++) {
            rows = [];
            for (var row = 0; row < 10; row++) {
                diceType = this.randomValue(1);
                if (diceType === 0) {
                    dice = new DiceButton(this.game, 305 + (50 * col), 200 + (40 * row), 'dice_black_atlas', this.onFieldDiceClick, this);
                    dice.diceType = diceType;
                }
                else {
                    dice = new DiceButton(this.game, 305 + (50 * col), 200 + (40 * row), 'dice_blue_atlas', this.onFieldDiceClick, this);
                    dice.diceType = diceType;
                }
                if (row < 9)
                    dice.inputEnabled = false;
                dice.diceValues = diceValues[this.randomValue(6)][this.randomValue(3)];
                dice.diceIndex = this.randomValue(3);
                dice.diceValue = dice.diceValues[dice.diceIndex];
                nextValue = dice.diceIndex === 3 ? 0 : (dice.diceIndex + 1);
                dice.frameName = "dice" + dice.diceValue + "0" + dice.diceValue + dice.diceValues[nextValue];
                this.group.addChild(dice);
                rows.push(dice);
            }
            this.field.push(rows);
        }
    };
    SevensState.prototype.onFieldDiceClick = function (event) {
        if (sound === true)
            this.sound3.play();
        if (event.frameName.length === 8) {
            event.frameName = event.frameName + "Y";
            this.points += event.diceValue;
            this.pointsText.text = 'Сумма кубиков: ' + this.points;
        }
        else {
            event.frameName = event.frameName.slice(0, 8);
            this.points -= event.diceValue;
            this.pointsText.text = 'Сумма кубиков: ' + this.points;
        }
        this.checkDiceScore();
    };
    SevensState.prototype.endGame = function (type) {
        clearInterval(this.timer);
        var graphicOverlay = new Phaser.Graphics(this.game, 0, 0);
        graphicOverlay.beginFill(0x000000, 0.5);
        graphicOverlay.drawRect(0, 0, this.game.width, this.game.height);
        graphicOverlay.endFill();
        var image = new Phaser.Image(this.game, 0, 0, graphicOverlay.generateTexture());
        image.inputEnabled = true;
        this.group.addChild(image);
        var window;
        var tween;
        if (type === "WIN") {
            window = new Phaser.Sprite(this.game, (this.game.width / 2) - (410 / 2), -215, 'win');
        }
        else {
            window = new Phaser.Sprite(this.game, (this.game.width / 2) - (410 / 2), -215, 'lost');
        }
        this.group.addChild(window);
        var button1 = new Phaser.Button(this.game, (this.game.width / 2) - 270, 5, 'button_restart_game', this.onButtonClick, this);
        button1.name = 'button_restart_game';
        button1.onInputOver.add(this.onButtonOver, this);
        button1.onInputOut.add(this.onButtonOut, this);
        this.group.addChild(button1);
        var button2 = new Phaser.Button(this.game, (this.game.width / 2) + 25, 5, 'button_back_menu', this.onButtonClick, this);
        button2.name = 'button_back_menu';
        button2.onInputOver.add(this.onButtonOver, this);
        button2.onInputOut.add(this.onButtonOut, this);
        this.group.addChild(button2);
        tween = this.game.add.tween(window);
        tween.to({ y: 185 }, 1500, 'Linear');
        tween.start();
        tween = this.game.add.tween(button1);
        tween.to({ y: 405 }, 1500, 'Linear');
        tween.start();
        tween = this.game.add.tween(button2);
        tween.to({ y: 405 }, 1500, 'Linear');
        tween.start();
        if (type === "WIN") {
            var button3 = new Phaser.Button(this.game, (this.game.width / 2) - 130, 55, 'button_post', this.onButtonClick, this);
            button3.name = 'button_post';
            button3.onInputOver.add(this.onButtonOver, this);
            button3.onInputOut.add(this.onButtonOut, this);
            this.group.addChild(button3);
            tween = this.game.add.tween(button3);
            tween.to({ y: 460 }, 1500, 'Linear');
            tween.start();
        }
    };
    SevensState.prototype.windowHelpCreate = function () {
        this.windowHelp = new Phaser.Group(this.game, this.group);
        var graphicOverlay = new Phaser.Graphics(this.game, 0, 0);
        graphicOverlay.beginFill(0x000000, 0.5);
        graphicOverlay.drawRect(0, 0, this.game.width, this.game.height);
        graphicOverlay.endFill();
        var image = new Phaser.Image(this.game, 0, 0, graphicOverlay.generateTexture());
        image.inputEnabled = true;
        this.windowHelp.addChild(image);
        var helpSprite = new Phaser.Sprite(this.game, (this.game.width / 2) - (486 / 2), 25, 'help_sevens');
        this.windowHelp.addChild(helpSprite);
        var button = new Phaser.Button(this.game, (this.game.width / 2) - 200, 650, 'button_close', this.onButtonClick, this);
        button.name = 'button_help_close';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.windowHelp.addChild(button);
    };
    SevensState.prototype.windowHelpClose = function () {
        this.windowHelp.removeChildren();
        this.group.removeChild(this.windowHelp);
    };
    return SevensState;
})(Phaser.State);
//# sourceMappingURL=sevens.js.map