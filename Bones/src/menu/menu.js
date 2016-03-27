var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var MenuState = (function (_super) {
    __extends(MenuState, _super);
    function MenuState() {
        _super.apply(this, arguments);
    }
    MenuState.prototype.preload = function () {
    };
    MenuState.prototype.create = function () {
        this.stage.backgroundColor = "#FFFFFF";
        this.group = new Phaser.Group(this.game, this.stage);
        this.soundButton = new Phaser.Sound(this.game, 'sound4');
        this.createBackground();
        this.createButtons();
    };
    MenuState.prototype.update = function () {
    };
    MenuState.prototype.render = function () {
    };
    MenuState.prototype.createBackground = function () {
        var background = new Phaser.Sprite(this.game, 0, 0, 'background');
        this.group.addChild(background);
        var money = new Phaser.Sprite(this.game, 600, 50, 'money');
        this.group.addChild(money);
        var logo = new Phaser.Sprite(this.game, (this.game.width / 2) - (400 / 2), 10, 'logo_menu');
        logo.scale.setTo(0.8, 0.8);
        this.group.addChild(logo);
    };
    MenuState.prototype.createButtons = function () {
        var names = ["button_1000", "button_7", "button_settings", "button_ivent", "button_help"];
        var button;
        for (var i = 0; i < names.length; i++) {
            button = new Phaser.Button(this.game, (this.game.width / 2) - (250 / 2), 150 + (100 * i), names[i], this.onButtonClick, this);
            button.name = names[i];
            button.onInputOver.add(this.onButtonOver, this);
            button.onInputOut.add(this.onButtonOut, this);
            this.group.addChild(button);
        }
    };
    MenuState.prototype.onButtonClick = function (event) {
        if (sound === true)
            this.soundButton.play();
        switch (event.name) {
            case "button_7":
                {
                    this.group.removeChildren();
                    this.game.state.start("SevensState");
                    break;
                }
            case "button_1000":
                {
                    this.group.removeChildren();
                    this.game.state.start("ThousandState");
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
            case "button_settings":
                {
                    this.windowSettingsCreate();
                    break;
                }
            case "button_settings_close":
                {
                    this.windowSettingsClose();
                    break;
                }
            case "button_settings_sound":
                {
                    if (sound === true) {
                        sound = false;
                        this.windowSettings.removeChild(event);
                        event = new Phaser.Button(this.game, (this.game.width / 2) - 70, 285, 'button_settings_sound_off', this.onButtonClick, this);
                        event.name = 'button_settings_sound';
                        this.windowSettings.addChild(event);
                    }
                    else {
                        sound = true;
                        this.windowSettings.removeChild(event);
                        event = new Phaser.Button(this.game, (this.game.width / 2) - 70, 285, 'button_settings_sound_on', this.onButtonClick, this);
                        event.name = 'button_settings_sound';
                        this.windowSettings.addChild(event);
                    }
                    break;
                }
            default:
                break;
        }
    };
    MenuState.prototype.onButtonOver = function (event) {
        event.scale.setTo(0.95, 0.95);
        event.anchor.x -= 0.025;
    };
    MenuState.prototype.onButtonOut = function (event) {
        event.scale.setTo(1, 1);
        event.anchor.x += 0.025;
    };
    MenuState.prototype.windowHelpCreate = function () {
        this.windowHelp = new Phaser.Group(this.game, this.group);
        var graphicOverlay = new Phaser.Graphics(this.game, 0, 0);
        graphicOverlay.beginFill(0x000000, 0.5);
        graphicOverlay.drawRect(0, 0, this.game.width, this.game.height);
        graphicOverlay.endFill();
        var image = new Phaser.Image(this.game, 0, 0, graphicOverlay.generateTexture());
        image.inputEnabled = true;
        this.windowHelp.addChild(image);
        var helpSprite = new Phaser.Sprite(this.game, (this.game.width / 2) - (486 / 2), 25, 'help');
        this.windowHelp.addChild(helpSprite);
        var button = new Phaser.Button(this.game, (this.game.width / 2) - 200, 600, 'button_close', this.onButtonClick, this);
        button.name = 'button_help_close';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.windowHelp.addChild(button);
    };
    MenuState.prototype.windowHelpClose = function () {
        this.windowHelp.removeChildren();
        this.group.removeChild(this.windowHelp);
    };
    MenuState.prototype.windowSettingsCreate = function () {
        this.windowSettings = new Phaser.Group(this.game, this.group);
        var graphicOverlay = new Phaser.Graphics(this.game, 0, 0);
        graphicOverlay.beginFill(0x000000, 0.5);
        graphicOverlay.drawRect(0, 0, this.game.width, this.game.height);
        graphicOverlay.endFill();
        var image = new Phaser.Image(this.game, 0, 0, graphicOverlay.generateTexture());
        image.inputEnabled = true;
        this.windowSettings.addChild(image);
        var windowSprite = new Phaser.Sprite(this.game, (this.game.width / 2) - (309 / 2), 180, 'window_settings');
        this.windowSettings.addChild(windowSprite);
        var buttonSound;
        if (sound === true)
            buttonSound = new Phaser.Button(this.game, (this.game.width / 2) - 70, 285, 'button_settings_sound_on', this.onButtonClick, this);
        else
            buttonSound = new Phaser.Button(this.game, (this.game.width / 2) - 70, 285, 'button_settings_sound_off', this.onButtonClick, this);
        buttonSound.name = 'button_settings_sound';
        this.windowSettings.addChild(buttonSound);
        var button = new Phaser.Button(this.game, (this.game.width / 2) - 125, 355, 'button_close', this.onButtonClick, this);
        button.name = 'button_settings_close';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.windowSettings.addChild(button);
    };
    MenuState.prototype.windowSettingsClose = function () {
        this.windowSettings.removeChildren();
        this.group.removeChild(this.windowSettings);
    };
    return MenuState;
})(Phaser.State);
//# sourceMappingURL=menu.js.map