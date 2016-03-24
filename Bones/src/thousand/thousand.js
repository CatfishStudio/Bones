var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var ThousandState = (function (_super) {
    __extends(ThousandState, _super);
    function ThousandState() {
        _super.apply(this, arguments);
    }
    ThousandState.prototype.preload = function () {
    };
    ThousandState.prototype.create = function () {
        this.stage.backgroundColor = "#FFFFFF";
        this.group = new Phaser.Group(this.game, this.stage);
        this.sound1 = this.game.add.audio('sound1');
        this.sound1.loop = true;
        this.sound2 = this.game.add.audio('sound2');
        this.sound3 = this.game.add.audio('sound3');
        this.sound4 = this.game.add.audio('sound4');
        this.createBackground();
        this.createMessage();
        this.createButtons();
        this.createPlayers();
        this.createDice();
    };
    ThousandState.prototype.update = function () {
    };
    ThousandState.prototype.render = function () {
    };
    ThousandState.prototype.randomIndex = function () {
        var index = Math.round(Math.random() / 0.1);
        return index;
    };
    ThousandState.prototype.randomValue = function (count) {
        var index = this.randomIndex();
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
    ThousandState.prototype.createBackground = function () {
        var background = new Phaser.Sprite(this.game, 0, 0, 'background');
        this.group.addChild(background);
        var icons = new Phaser.Sprite(this.game, 0, 0, 'icons');
        this.group.addChild(icons);
    };
    ThousandState.prototype.createMessage = function () {
        this.messageText = new Phaser.Text(this.game, (this.game.width / 2) - 145, 125, "Чтобы вступить в игру. \nВам необходимо набрать 75 очков!", { font: "18px Arial", fill: "#FFFFFF", align: "center" });
        this.group.addChild(this.messageText);
    };
    ThousandState.prototype.createPlayers = function () {
        this.score = 0;
        this.playerIndex = 0;
        this.players = {
            "0": ["Вы", new Phaser.Text(this.game, 50, 548, "Вы", { font: "18px Arial", fill: "#FFFFFF" }), 0],
            "1": ["Джек", new Phaser.Text(this.game, 50, 257, "Джек", { font: "18px Arial", fill: "#FFFFFF" }), 0],
            "2": ["Барбосса", new Phaser.Text(this.game, 628, 257, "Барбосса", { font: "18px Arial", fill: "#FFFFFF" }), 0],
            "3": ["Анжелика", new Phaser.Text(this.game, 628, 548, "Анжелика", { font: "18px Arial", fill: "#FFFFFF" }), 0]
        };
        for (var key in this.players) {
            this.players[key][1].text = this.players[key][0] + ": не вступил.";
            this.group.addChild(this.players[key][1]);
        }
        key = null;
    };
    ThousandState.prototype.createDice = function () {
        this.diceCountMax = 5;
        this.boxDice = {
            "1": [1, false, 305, 595, new Phaser.Sprite(this.game, 0, 0, "dice_1_atlas")],
            "2": [2, false, 355, 595, new Phaser.Sprite(this.game, 0, 0, "dice_2_atlas")],
            "3": [3, false, 405, 595, new Phaser.Sprite(this.game, 0, 0, "dice_3_atlas")],
            "4": [4, false, 455, 595, new Phaser.Sprite(this.game, 0, 0, "dice_4_atlas")],
            "5": [5, false, 505, 595, new Phaser.Sprite(this.game, 0, 0, "dice_5_atlas")]
        };
        for (var key in this.boxDice) {
            this.boxDice[key][4].x = this.boxDice[key][2];
            this.boxDice[key][4].y = this.boxDice[key][3];
            this.boxDice[key][4].animations.add('dice', Phaser.Animation.generateFrameNames('dice', 0, 10, '', 2), 15, false);
            this.boxDice[key][4].animations.play('dice');
            this.group.addChild(this.boxDice[key][4]);
        }
        key = null;
    };
    ThousandState.prototype.createButtons = function () {
        var button = new Phaser.Button(this.game, 10, 665, 'button_end_game', this.onButtonClick, this);
        button.name = 'button_end_game';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.group.addChild(button);
        button = new Phaser.Button(this.game, 600, 665, 'button_help', this.onButtonClick, this);
        button.name = 'button_help';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.group.addChild(button);
        button = new Phaser.Button(this.game, 300, 665, 'button_settings', this.onButtonClick, this);
        button.name = 'button_settings';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.group.addChild(button);
        this.buttonApply = new Phaser.Button(this.game, 250, 200, 'button_throw', this.onActionButtonClick, this);
        this.buttonApply.name = 'button_throw';
        this.buttonApply.scale.setTo(0.7, 0.7);
        this.buttonApply.onInputOver.add(this.onActionButtonOver, this);
        this.buttonApply.onInputOut.add(this.onActionButtonOut, this);
        this.group.addChild(this.buttonApply);
        this.buttonCancel = new Phaser.Button(this.game, 435, 200, 'button_not_throw', this.onActionButtonClick, this);
        this.buttonCancel.name = 'button_not_throw';
        this.buttonCancel.scale.setTo(0.7, 0.7);
        this.buttonCancel.onInputOver.add(this.onActionButtonOver, this);
        this.buttonCancel.onInputOut.add(this.onActionButtonOut, this);
        this.group.addChild(this.buttonCancel);
    };
    ThousandState.prototype.onButtonClick = function (event) {
        this.sound4.play();
        switch (event.name) {
            case "button_end_game":
                {
                    event.inputEnabled = false;
                    break;
                }
            case "button_restart_game":
                {
                    this.group.removeChildren();
                    this.group = null;
                    this.windowHelp = null;
                    this.game.state.restart(true);
                    break;
                }
            case "button_back_menu":
                {
                    this.group.removeChildren();
                    this.group = null;
                    this.windowHelp = null;
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
            default:
                break;
        }
    };
    ThousandState.prototype.onButtonOver = function (event) {
        event.scale.setTo(0.95, 0.95);
        event.anchor.x -= 0.025;
    };
    ThousandState.prototype.onButtonOut = function (event) {
        event.scale.setTo(1, 1);
        event.anchor.x += 0.025;
    };
    ThousandState.prototype.onActionButtonClick = function (event) {
        switch (event.name) {
            case "button_throw":
                {
                    this.rollDice();
                    break;
                }
            case "button_not_throw":
                {
                    this.sound4.play();
                    break;
                }
            default:
                break;
        }
    };
    ThousandState.prototype.onActionButtonOver = function (event) {
        event.scale.setTo(0.65, 0.65);
        event.anchor.x -= 0.025;
    };
    ThousandState.prototype.onActionButtonOut = function (event) {
        event.scale.setTo(0.7, 0.7);
        event.anchor.x += 0.025;
    };
    ThousandState.prototype.windowHelpCreate = function () {
        this.windowHelp = new Phaser.Group(this.game, this.group);
        var graphicOverlay = new Phaser.Graphics(this.game, 0, 0);
        graphicOverlay.beginFill(0x000000, 0.5);
        graphicOverlay.drawRect(0, 0, this.game.width, this.game.height);
        graphicOverlay.endFill();
        var image = new Phaser.Image(this.game, 0, 0, graphicOverlay.generateTexture());
        image.inputEnabled = true;
        this.windowHelp.addChild(image);
        var helpSprite = new Phaser.Sprite(this.game, (this.game.width / 2) - (486 / 2), 25, 'help_thousand');
        this.windowHelp.addChild(helpSprite);
        var button = new Phaser.Button(this.game, (this.game.width / 2) - 200, 650, 'button_close', this.onButtonClick, this);
        button.name = 'button_help_close';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.windowHelp.addChild(button);
    };
    ThousandState.prototype.windowHelpClose = function () {
        this.windowHelp.removeChildren();
        this.group.removeChild(this.windowHelp);
    };
    ThousandState.prototype.rollDice = function () {
        this.sound1.stop();
        this.sound2.play();
        var tween;
        var index;
        var newPosX;
        var newPosY;
        if (this.diceCountMax === 0)
            this.diceCountMax = 5;
        for (var key in this.boxDice) {
            if (this.boxDice[key][1] === false) {
                index = this.randomValue(6);
                var newPosX = 250 + ((Math.random() / 0.1) * (key * 8));
                var newPosY = 250 + ((Math.random() / 0.1) * (key * 5));
                this.group.removeChild(this.boxDice[key][4]);
                this.boxDice[key][4] = new Phaser.Sprite(this.game, this.boxDice[key][2], this.boxDice[key][3], "dice_" + index + "_atlas");
                this.boxDice[key][4].animations.add('dice', Phaser.Animation.generateFrameNames('dice', 0, 10, '', 2), 15, false);
                this.boxDice[key][4].animations.play('dice');
                this.boxDice[key][0] = index;
                this.group.addChild(this.boxDice[key][4]);
                tween = this.game.add.tween(this.boxDice[key][4]);
                tween.to({ x: newPosX, y: newPosY }, 700, 'Linear');
                tween.onComplete.add(this.onRollDiceTweenComplete, this);
                tween.start();
            }
        }
        key = null;
        tween = null;
    };
    ThousandState.prototype.onRollDiceTweenComplete = function (event) {
        this.diceCountMax--;
        console.log(this.diceCountMax);
        if (this.diceCountMax === 0) {
            this.diceCountMax = 5;
            if (this.checkScoreDice() === true) {
                this.messageText.text = "Вы набрали " + this.score + " очков. \nЖелаете бросить ещё?";
                if (this.diceCountMax === 0)
                    for (var key in this.boxDice)
                        this.boxDice[key][1] = false;
            }
            else {
                if (this.playerIndex === 0) {
                    this.score = 0;
                    this.playerIndex++;
                    this.messageText.text = "Вам ничего не выпало.\nХод переходит к " + this.players[this.playerIndex.toString()][0] + ".";
                    this.buttonApply.visible = false;
                    this.buttonCancel.visible = false;
                    for (var key in this.boxDice)
                        this.boxDice[key][1] = false;
                }
                else {
                    if (this.playerIndex < 3) {
                        this.score = 0;
                        this.playerIndex++;
                        this.messageText.text = "Ничего не выпало.\nХод переходит к " + this.players[this.playerIndex.toString()][0] + ".";
                        this.buttonApply.visible = false;
                        this.buttonCancel.visible = false;
                        for (var key in this.boxDice)
                            this.boxDice[key][1] = false;
                    }
                    else {
                        this.score = 0;
                        this.playerIndex = 0;
                        this.messageText.text = "Ничего не выпало.\nХод переходит к Вам.";
                        this.buttonApply.visible = true;
                        this.buttonCancel.visible = true;
                        for (var key in this.boxDice)
                            this.boxDice[key][1] = false;
                    }
                }
            }
        }
    };
    ThousandState.prototype.checkScoreDice = function () {
        var result = false;
        if (this.checkDice5() === true) {
            result = true;
        }
        else {
            if (this.checkDice4() === true) {
                this.checkDice1();
                result = true;
            }
            else {
                if (this.checkDice3() === true) {
                    this.checkDice1();
                    result = true;
                }
                else {
                    if (this.checkDice1() === true)
                        result = true;
                }
            }
        }
        return result;
    };
    ThousandState.prototype.checkDice5 = function () {
        var dice = [];
        /* Поиск уникальной комбинации */
        for (var Key in this.boxDice) {
            if (this.boxDice[Key][1] === false)
                dice.push(this.boxDice[Key][0]);
            else
                this.diceCountMax--;
        }
        dice.sort(function (valueA, valueB) {
            return valueA - valueB;
        });
        if (dice.length === 5) {
            if (dice[0] === 1 && dice[1] === 2 && dice[2] === 3 && dice[3] === 4 && dice[4] === 5) {
                this.score -= 100;
                this.selectDice("ALL");
                this.diceCountMax -= 5;
                return true;
            }
            if (dice[0] === 2 && dice[1] === 3 && dice[2] === 4 && dice[3] === 5 && dice[4] === 6) {
                this.score += 200;
                this.selectDice("ALL");
                this.diceCountMax -= 5;
                return true;
            }
            if (dice[0] === dice[1] && dice[0] === dice[2] && dice[0] === dice[3] && dice[0] === dice[4]) {
                this.score += 1000;
                this.selectDice("ALL");
                this.diceCountMax -= 5;
                return true;
            }
        }
        else {
            return false;
        }
    };
    ThousandState.prototype.checkDice4 = function () {
        var dice = [];
        /* Поиск одинаковых значений кубиков */
        for (var iKey in this.boxDice) {
            if (this.boxDice[iKey][1] === false) {
                for (var jKey in this.boxDice) {
                    if (iKey !== jKey && this.boxDice[jKey][1] === false && this.boxDice[iKey][0] === this.boxDice[jKey][0]) {
                        dice.push(jKey);
                    }
                }
                if (dice.length === 3) {
                    dice.push(iKey);
                    if (this.boxDice[iKey][0] === 1)
                        this.score += 100;
                    if (this.boxDice[iKey][0] === 2)
                        this.score += 200;
                    if (this.boxDice[iKey][0] === 3)
                        this.score += 300;
                    if (this.boxDice[iKey][0] === 4)
                        this.score += 400;
                    if (this.boxDice[iKey][0] === 5)
                        this.score += 500;
                    if (this.boxDice[iKey][0] === 6)
                        this.score += 600;
                    this.selectDice(dice);
                    this.diceCountMax -= 4;
                    return true;
                }
                else {
                    dice = [];
                }
            }
        }
        return false;
    };
    ThousandState.prototype.checkDice3 = function () {
        var dice = [];
        /* Поиск одинаковых значений кубиков */
        for (var iKey in this.boxDice) {
            if (this.boxDice[iKey][1] === false) {
                for (var jKey in this.boxDice) {
                    if (iKey !== jKey && this.boxDice[jKey][1] === false && this.boxDice[iKey][0] === this.boxDice[jKey][0]) {
                        dice.push(jKey);
                    }
                }
                if (dice.length === 2) {
                    dice.push(iKey);
                    if (this.boxDice[iKey][0] === 1)
                        this.score += 30;
                    if (this.boxDice[iKey][0] === 2)
                        this.score += 20;
                    if (this.boxDice[iKey][0] === 3)
                        this.score += 30;
                    if (this.boxDice[iKey][0] === 4)
                        this.score += 40;
                    if (this.boxDice[iKey][0] === 5)
                        this.score += 50;
                    if (this.boxDice[iKey][0] === 6)
                        this.score += 60;
                    this.selectDice(dice);
                    this.diceCountMax -= 3;
                    return true;
                }
                else {
                    dice = [];
                }
            }
        }
        return false;
    };
    ThousandState.prototype.checkDice1 = function () {
        var result = false;
        var dice = [];
        for (var iKey in this.boxDice) {
            if (this.boxDice[iKey][1] === false) {
                if (this.boxDice[iKey][0] === 1) {
                    result = true;
                    this.score += 10;
                    dice.push(iKey);
                    this.diceCountMax -= 1;
                }
                if (this.boxDice[iKey][0] === 5) {
                    result = true;
                    this.score += 5;
                    dice.push(iKey);
                    this.diceCountMax -= 1;
                }
            }
        }
        if (result === true)
            this.selectDice(dice);
        return result;
    };
    ThousandState.prototype.selectDice = function (dice) {
        var tween;
        if (dice === "ALL") {
            for (var key in this.boxDice) {
                this.boxDice[key][1] = false;
                tween = this.game.add.tween(this.boxDice[key][4]);
                tween.to({ x: this.boxDice[key][2], y: this.boxDice[key][3] }, 500, Phaser.Easing.Linear.None);
                tween.start();
            }
        }
        else {
            var count = dice.length;
            for (var i = 0; i < count; i++) {
                this.boxDice[dice[i]][1] = true;
                tween = this.game.add.tween(this.boxDice[dice[i]][4]);
                tween.to({ x: this.boxDice[dice[i]][2], y: this.boxDice[dice[i]][3] }, 500, Phaser.Easing.Linear.None);
                tween.start();
            }
        }
    };
    return ThousandState;
})(Phaser.State);
//# sourceMappingURL=thousand.js.map