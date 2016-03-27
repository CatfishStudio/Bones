/// <reference path="./src/menu/menu.ts" />
/// <reference path="./src/sevens/sevens.ts" />
/// <reference path="./src/thousand/thousand.ts" />
/// <reference path="./src/preloader/preloader.ts" />
var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var sound = true;
var Game = (function (_super) {
    __extends(Game, _super);
    function Game() {
        _super.call(this, 860, 730, Phaser.CANVAS, "content", PreloaderState);
        this.state.add("MenuState", MenuState);
        this.state.add("SevensState", SevensState);
        this.state.add("ThousandState", ThousandState);
    }
    return Game;
})(Phaser.Game);
window.onload = function () {
    var game = new Game();
};
//# sourceMappingURL=app.js.map