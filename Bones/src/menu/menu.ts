class MenuState extends Phaser.State {

    group: Phaser.Group;
    soundButton: Phaser.Sound;
    windowHelp: Phaser.Group;
    windowSettings: Phaser.Group;
    windowRating: Phaser.Group;

    preload() {

    }

    create() {
        this.stage.backgroundColor = "#FFFFFF";
        this.group = new Phaser.Group(this.game, this.stage);
        this.soundButton = new Phaser.Sound(this.game, 'sound4');

        this.createBackground();
        this.createButtons();
    }

    update() {

    }

    render() {

    }

    createBackground() {
        
        var background: Phaser.Sprite = new Phaser.Sprite(this.game, 0, 0, 'background');
        this.group.addChild(background);

        var money: Phaser.Sprite = new Phaser.Sprite(this.game, 600, 50, 'money');
        this.group.addChild(money);

        var logo: Phaser.Sprite = new Phaser.Sprite(this.game, (this.game.width / 2) - (400 / 2), 10, 'logo_menu');
        logo.scale.setTo(0.8, 0.8);
        this.group.addChild(logo);

    }

    createButtons() {
        var names: string[] = ["button_1000", "button_7", "button_settings", "button_ivent", "button_help", "button_rating"];
        var button: Phaser.Button;

        for (var i = 0; i < names.length; i++) {
            button = new Phaser.Button(this.game, (this.game.width / 2) - (250 / 2), 150 + (100 * i), names[i], this.onButtonClick, this);
            button.name = names[i];
            button.onInputOver.add(this.onButtonOver, this);
            button.onInputOut.add(this.onButtonOut, this);
            this.group.addChild(button);
        }
    }

    onButtonClick(event) {
        if (sound === true) this.soundButton.play();
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

            case "button_rating":
                {
                    this.windowRatingCreate();
                    break;
                }

            case "button_rating_close":
                {
                    this.windowRatingClose();
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
                    } else {
                        sound = true;
                        this.windowSettings.removeChild(event);
                        event = new Phaser.Button(this.game, (this.game.width / 2) - 70, 285, 'button_settings_sound_on', this.onButtonClick, this);
                        event.name = 'button_settings_sound';
                        this.windowSettings.addChild(event);
                    }
                    break;
                }

            case "button_ivent":
                {
                    /*
                    VK.callMethod("showInviteBox");
                    */
                    break;
                }

            default:
                break;
        }
    }

    onButtonOver(event) {
        event.scale.setTo(0.95, 0.95);
        event.anchor.x -= 0.025;
    }

    onButtonOut(event) {
        event.scale.setTo(1, 1);
        event.anchor.x += 0.025;
    }

    windowHelpCreate() {
        this.windowHelp = new Phaser.Group(this.game, this.group);

        var graphicOverlay: Phaser.Graphics = new Phaser.Graphics(this.game, 0, 0);
        graphicOverlay.beginFill(0x000000, 0.5);
        graphicOverlay.drawRect(0, 0, this.game.width, this.game.height);
        graphicOverlay.endFill();

        var image: Phaser.Image = new Phaser.Image(this.game, 0, 0, graphicOverlay.generateTexture());
        image.inputEnabled = true;
        this.windowHelp.addChild(image);

        var helpSprite: Phaser.Sprite = new Phaser.Sprite(this.game, (this.game.width / 2) - (486 / 2), 25, 'help');
        this.windowHelp.addChild(helpSprite);

        var button: Phaser.Button = new Phaser.Button(this.game, (this.game.width / 2) - 200, 600, 'button_close', this.onButtonClick, this);
        button.name = 'button_help_close';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.windowHelp.addChild(button);
    }

    windowHelpClose() {
        this.windowHelp.removeChildren();
        this.group.removeChild(this.windowHelp);
    }

    windowSettingsCreate() {
        this.windowSettings = new Phaser.Group(this.game, this.group);

        var graphicOverlay: Phaser.Graphics = new Phaser.Graphics(this.game, 0, 0);
        graphicOverlay.beginFill(0x000000, 0.5);
        graphicOverlay.drawRect(0, 0, this.game.width, this.game.height);
        graphicOverlay.endFill();

        var image: Phaser.Image = new Phaser.Image(this.game, 0, 0, graphicOverlay.generateTexture());
        image.inputEnabled = true;
        this.windowSettings.addChild(image);

        var windowSprite: Phaser.Sprite = new Phaser.Sprite(this.game, (this.game.width / 2) - (309 / 2), 180, 'window_settings');
        this.windowSettings.addChild(windowSprite);

        var buttonSound: Phaser.Button;
        if (sound === true) buttonSound = new Phaser.Button(this.game, (this.game.width / 2) - 70, 285, 'button_settings_sound_on', this.onButtonClick, this);
        else buttonSound = new Phaser.Button(this.game, (this.game.width / 2) - 70, 285, 'button_settings_sound_off', this.onButtonClick, this);
        buttonSound.name = 'button_settings_sound';
        this.windowSettings.addChild(buttonSound);

        var button: Phaser.Button = new Phaser.Button(this.game, (this.game.width / 2) - 125, 355, 'button_close', this.onButtonClick, this);
        button.name = 'button_settings_close';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.windowSettings.addChild(button);
    }

    windowSettingsClose() {
        this.windowSettings.removeChildren();
        this.group.removeChild(this.windowSettings);
    }
    
    windowRatingCreate() {
        
        this.windowRating = new Phaser.Group(this.game, this.group);

        var graphicOverlay: Phaser.Graphics = new Phaser.Graphics(this.game, 0, 0);
        graphicOverlay.beginFill(0x000000, 0.5);
        graphicOverlay.drawRect(0, 0, this.game.width, this.game.height);
        graphicOverlay.endFill();

        var image: Phaser.Image = new Phaser.Image(this.game, 0, 0, graphicOverlay.generateTexture());
        image.inputEnabled = true;
        this.windowRating.addChild(image);

        var helpSprite: Phaser.Sprite = new Phaser.Sprite(this.game, (this.game.width / 2) - (486 / 2), 25, 'rating');
        this.windowRating.addChild(helpSprite);

        var button: Phaser.Button = new Phaser.Button(this.game, (this.game.width / 2) - 200, 600, 'button_close', this.onButtonClick, this);
        button.name = 'button_rating_close';
        button.onInputOver.add(this.onButtonOver, this);
        button.onInputOut.add(this.onButtonOut, this);
        this.windowRating.addChild(button);

        var text: Phaser.Text = this.game.add.text(350, 55, "Тысяча", { font: "48px Monotype Corsiva", fill: "#5C2D15", align: "center" });
        this.windowRating.addChild(text);

        var ratingThousand: any[] = [
            ["Джек Воробей", 1000, "очков"],
            ["Уилл Тёрнер", 900, "очков"],
            ["Элизабет Суонн", 800, "очков"],
            ["Гектор Барбосса", 700, "очков"],
            ["Дейви Джонс", 600, "очков"],
            ["Тиа Дальма", 500, "очков"],
            ["Джошими Гиббс", 400, "очков"],
            ["Анжелика", 300, "очков"],
            ["Джеймс Норингтон", 200, "очков"]
        ];

        var userName: string = null;
        if (userFirstName !== null) {
            if ((userFirstName.length + userLastName.length) > 23) userName = userFirstName;
            else userName = userFirstName + " " + userLastName;
        } else userName = "Вы";
        
        var n: number = 0;
        var userWentUp: boolean = false;
        var count: number = ratingThousand.length;
        
        for (var i = 0; i < count; i++) {

            if (userRatingThousand >= ratingThousand[i][1] && userWentUp === false) {
                text = this.game.add.text(250, 100 + (20 * n), (n + 1).toString() + " " + userName, { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
                this.windowRating.addChild(text);
                text = this.game.add.text(450, 100 + (20 * n), userRatingThousand + " очков", { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
                this.windowRating.addChild(text);
                userWentUp = true;
                n++;
            }
            text = this.game.add.text(250, 100 + (20 * n), (n + 1).toString() + " " + ratingThousand[i][0], { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
            this.windowRating.addChild(text);
            text = this.game.add.text(450, 100 + (20 * n), ratingThousand[i][1] + " " + ratingThousand[i][2], { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
            this.windowRating.addChild(text);
            n++;
        }

        if (userRatingThousand < ratingThousand[count - 1][1]) {
            text = this.game.add.text(250, 100 + (20 * n), (n + 1).toString() + " " + userName, { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
            this.windowRating.addChild(text);
            text = this.game.add.text(450, 100 + (20 * n), userRatingThousand + " очков", { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
            this.windowRating.addChild(text);
        }


        text = this.game.add.text(350, 325, "Семёрка", { font: "48px Monotype Corsiva", fill: "#5C2D15", align: "center" });
        this.windowRating.addChild(text);
        var ratingSevens: any[] = [
            ["Уилл Тёрнер", 700, "очков"],
            ["Анжелика", 650, "очков"],
            ["Джек Воробей", 600, "очков"],
            ["Джеймс Норингтон", 550, "очков"],
            ["Джошими Гиббс", 500, "очков"],
            ["Гектор Барбосса", 450, "очков"],
            ["Тиа Дальма", 400, "очков"],
            ["Дейви Джонс", 450, "очков"],
            ["Элизабет Суонн", 300, "очков"]
        ];
        n = 0;
        userWentUp = false;
        var count: number = ratingSevens.length;
        for (var i = 0; i < count; i++) {

            if (userRatingSevens >= ratingSevens[i][1] && userWentUp === false) {
                text = this.game.add.text(250, 375 + (20 * n), (n + 1).toString() + " " + userName, { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
                this.windowRating.addChild(text);
                text = this.game.add.text(450, 375 + (20 * n), userRatingSevens + " очков", { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
                this.windowRating.addChild(text);
                userWentUp = true;
                n++;
            }
            text = this.game.add.text(250, 375 + (20 * n), (n + 1).toString() + " " + ratingSevens[i][0], { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
            this.windowRating.addChild(text);
            text = this.game.add.text(450, 375 + (20 * n), ratingSevens[i][1] + " " + ratingSevens[i][2], { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
            this.windowRating.addChild(text);
            n++;
        }

        if (userRatingSevens < ratingSevens[count - 1][1]) {
            text = this.game.add.text(250, 375 + (20 * n), (n + 1).toString() + " " + userName, { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
            this.windowRating.addChild(text);
            text = this.game.add.text(450, 375 + (20 * n), userRatingSevens + " очков", { font: "18px Monotype Corsiva", fill: "#5C2D15", align: "left" });
            this.windowRating.addChild(text);
        }


    }

    windowRatingClose() {
        this.windowRating.removeChildren();
        this.group.removeChild(this.windowRating);
    }
  
    
}