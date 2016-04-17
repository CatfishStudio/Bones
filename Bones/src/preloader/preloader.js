var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var PreloaderState = (function (_super) {
    __extends(PreloaderState, _super);
    function PreloaderState() {
        _super.apply(this, arguments);
        this.progressText = null;
        this.assetsLoadComplete = false;
    }
    PreloaderState.prototype.create = function () {
        this.stage.backgroundColor = "#FFFFFF";
        this.load.onLoadStart.add(this.onLoadStart.bind(this), this);
        this.load.onFileComplete.add(this.onFileComplete.bind(this), this);
        this.load.onLoadComplete.add(this.onLoadComplete.bind(this), this);
        if (avatar !== null) {
            this.load.image('avatar', avatar);
        }
        this.load.image('preloader', './assets/textures/1a.jpg');
        this.load.image('background', './assets/textures/background.jpg');
        this.load.image('box', './assets/textures/box.jpg');
        this.load.image('button_1000', './assets/textures/button_1000.png');
        this.load.image('button_7', './assets/textures/button_7.png');
        this.load.image('button_back_menu', './assets/textures/button_back_menu.png');
        this.load.image('button_close', './assets/textures/button_close.png');
        this.load.image('button_end_game', './assets/textures/button_end_game.png');
        this.load.image('button_help', './assets/textures/button_help.png');
        this.load.image('button_ivent', './assets/textures/button_ivent.png');
        this.load.image('button_post', './assets/textures/button_post.png');
        this.load.image('button_rating', './assets/textures/button_rating.png');
        this.load.image('button_restart_game', './assets/textures/button_restart_game.png');
        this.load.image('button_settings', './assets/textures/button_settings.png');
        this.load.image('button_settings_sound_on', './assets/textures/button_settings_sound_on.png');
        this.load.image('button_settings_sound_off', './assets/textures/button_settings_sound_off.png');
        this.load.image('button_throw', './assets/textures/button_throw.png');
        this.load.image('button_not_throw', './assets/textures/button_not_throw.png');
        this.load.image('help', './assets/textures/help.png');
        this.load.image('help_sevens', './assets/textures/help_sevens.png');
        this.load.image('help_thousand', './assets/textures/help_thousand.png');
        this.load.image('icons', './assets/textures/icons.png');
        this.load.image('logo_menu', './assets/textures/logo_menu.png');
        this.load.image('logo_seven', './assets/textures/logo_seven.png');
        this.load.image('lost_small', './assets/textures/lost_seven.png');
        this.load.image('lost', './assets/textures/lost_game.png');
        this.load.image('money', './assets/textures/money.png');
        this.load.image('panel', './assets/textures/panel.png');
        this.load.image('rating', './assets/textures/rating.png');
        this.load.image('win_small', './assets/textures/win_seven.png');
        this.load.image('win', './assets/textures/win_game.png');
        this.load.image('window_settings', './assets/textures/window_settings.png');
        this.load.atlas('dice_1_atlas', './assets/atlas/dice_1_atlas.png', './assets/atlas/dice_1_atlas.json');
        this.load.atlas('dice_2_atlas', './assets/atlas/dice_2_atlas.png', './assets/atlas/dice_2_atlas.json');
        this.load.atlas('dice_3_atlas', './assets/atlas/dice_3_atlas.png', './assets/atlas/dice_3_atlas.json');
        this.load.atlas('dice_4_atlas', './assets/atlas/dice_4_atlas.png', './assets/atlas/dice_4_atlas.json');
        this.load.atlas('dice_5_atlas', './assets/atlas/dice_5_atlas.png', './assets/atlas/dice_5_atlas.json');
        this.load.atlas('dice_6_atlas', './assets/atlas/dice_6_atlas.png', './assets/atlas/dice_6_atlas.json');
        this.load.atlas('dice_black_atlas', './assets/atlas/dice_black_atlas.png', './assets/atlas/dice_black_atlas.json');
        this.load.atlas('dice_blue_atlas', './assets/atlas/dice_blue_atlas.png', './assets/atlas/dice_blue_atlas.json');
        this.load.atlas('dice_win_atlas', './assets/atlas/dice_win_atlas.png', './assets/atlas/dice_win_atlas.json');
        this.load.audio('sound1', './assets/sounds/sound1.mp3');
        this.load.audio('sound2', './assets/sounds/sound2.mp3');
        this.load.audio('sound3', './assets/sounds/sound3.mp3');
        this.load.audio('sound4', './assets/sounds/sound4.mp3');
        this.load.start();
    };
    PreloaderState.prototype.onLoadStart = function () {
    };
    PreloaderState.prototype.onFileComplete = function (progress, cacheKey, success, totalLoaded, totalFiles) {
        //this.progressText.text = "File Complete: " + progress + "% - " + totalLoaded + " out of " + totalFiles;
        if (cacheKey === "preloader") {
            this.game.add.sprite(0, 0, 'preloader');
            this.progressText = this.game.add.text(340, 450, "ЗАГРУЗКА 0%", { font: "25px Monotype Corsiva", fill: "#FFFFAA", align: "center" });
        }
        if (this.progressText !== null)
            this.progressText.text = "ЗАГРУЗКА " + progress + "%";
    };
    PreloaderState.prototype.onLoadComplete = function () {
        this.game.state.start("MenuState");
    };
    return PreloaderState;
})(Phaser.State);
//# sourceMappingURL=preloader.js.map