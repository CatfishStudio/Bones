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
var avatar = null;
var userFirstName = null;
var userLastName = null;
var userRatingThousand = 0;
var userRatingSevens = 0;
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
    VK.init(function() {
        apiId: 5380703;
    });

    VK.api("users.get", function(data) {
        userFirstName = data.response[0].first_name;
        userLastName = data.response[0].last_name;
    });

    VK.api("photos.get", {album_id: 'profile'}, function(data) {
        avatar = data.response[data.response.length-1]['src'];
        var game = new Game();
    });
 
};
//# sourceMappingURL=app.js.map