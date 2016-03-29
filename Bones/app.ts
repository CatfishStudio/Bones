/// <reference path="./src/menu/menu.ts" />
/// <reference path="./src/sevens/sevens.ts" />
/// <reference path="./src/thousand/thousand.ts" />
/// <reference path="./src/preloader/preloader.ts" />

var sound: boolean = true;

class Game extends Phaser.Game {
    constructor() {
        super(860, 730, Phaser.CANVAS, "content", PreloaderState);
        this.state.add("MenuState", MenuState);
        this.state.add("SevensState", SevensState);
        this.state.add("ThousandState", ThousandState);
    }
}

window.onload = () => {
    /*
    VK.init(function() {
        apiId: 1234567;
    });
     */
    var game = new Game();
};