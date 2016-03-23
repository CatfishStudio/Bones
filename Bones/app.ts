/// <reference path="./src/menu/menu.ts" />
/// <reference path="./src/sevens/sevens.ts" />
/// <reference path="./src/thousand/thousand.ts" />
/// <reference path="./src/preloader/preloader.ts" />

class Game extends Phaser.Game {
    constructor() {
        super(860, 730, Phaser.CANVAS, "content", PreloaderState);
        this.state.add("MenuState", MenuState);
        this.state.add("SevensState", SevensState);
        this.state.add("ThousandState", ThousandState);
    }
}

window.onload = () => {
    var game = new Game();
};