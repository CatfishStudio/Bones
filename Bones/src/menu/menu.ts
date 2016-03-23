class MenuState extends Phaser.State {

    group: Phaser.Group;
    soundButton: Phaser.Sound;
    windowHelp: Phaser.Group;

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
        var names: string[] = ["button_1000", "button_7", "button_settings", "button_ivent", "button_help"];
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
}